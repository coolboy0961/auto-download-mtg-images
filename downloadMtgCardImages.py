# coding: UTF-8
import configparser
import os
import re
import sys
from urllib.request import urlopen, urlretrieve

from bs4 import BeautifulSoup

homeUrl = "http://magiccards.info"
# read config file
configFile = configparser.SafeConfigParser()
configFile.read("./config.txt")
cardSeries = configFile.get("settings", "cardSeries")
outputPath = configFile.get("settings", "outputPath")
cardSeriesList = cardSeries.split(",")
print("All series will be downloaded to " + outputPath + " .")

plainsNum = 0
forestNum = 0
mountainNum = 0
islandNum = 0
swampNum = 0

# function defination


def clearEarth():
    global plainsNum
    global forestNum
    global mountainNum
    global islandNum
    global swampNum
    plainsNum = 0
    forestNum = 0
    mountainNum = 0
    islandNum = 0
    swampNum = 0


def downloadOneSeriesImages(seriesCode):
    clearEarth()
    seriesUrl = "http://magiccards.info/" + seriesCode + "/cn.html"
    html = urlopen(seriesUrl)
    soup = BeautifulSoup(html, "html.parser")
    cardChineseAList = soup.find_all("a", href=re.compile(
        "\/" + seriesCode + "\/cn/(\d+\w?).html"))
    if len(cardChineseAList) == 0:
        print("This is no " + seriesCode +
              "\'s Chinese cards.")
        print(seriesCode + " skip.")
        return()
    # make directory
    directory = outputPath + "/" + seriesCode.upper()
    if not os.path.exists(directory):
        print(directory + " is created.")
        os.makedirs(directory)
    else:
        print(directory + " exists.")
    for cardChineseA in cardChineseAList:
        cardChineseUrl = homeUrl + cardChineseA.get("href")
        print("card url is " + cardChineseUrl)
        downloadOneCardImage(cardChineseUrl, directory)


def downloadOneCardImage(cardChineseUrl, directory):
    html = urlopen(cardChineseUrl)
    soup = BeautifulSoup(html, "html.parser")
    cardImageUrl = soup.find("img", src=re.compile(
        "http:\/\/magiccards\.info\/scans")).get("src")
    cardChineseName = soup.find("img", src=re.compile(
        "http:\/\/magiccards\.info\/scans")).get("alt")
    cardEnglishName = getEnglishCardName(cardChineseUrl)
    cardEnglishName = cardEnglishName.replace("/", ":")
    print("card image url is " + cardImageUrl)
    print("card cardChineseName is " + cardChineseName)

    # earth filename rename
    global plainsNum
    global forestNum
    global mountainNum
    global islandNum
    global swampNum
    if cardEnglishName == "Plains":
        plainsNum += 1
        cardEnglishName += str(plainsNum)
    elif cardEnglishName == "Forest":
        forestNum += 1
        cardEnglishName += str(forestNum)
    elif cardEnglishName == "Mountain":
        mountainNum += 1
        cardEnglishName += str(mountainNum)
    elif cardEnglishName == "Island":
        islandNum += 1
        cardEnglishName += str(islandNum)
    elif cardEnglishName == "Swamp":
        swampNum += 1
        cardEnglishName += str(swampNum)

    print("card cardEnglishName is " + cardEnglishName)
    downloadFileName = directory + "/" + cardEnglishName + ".full.jpg"
    if not os.path.exists(downloadFileName):
        print("This card is downloaded to " + downloadFileName)
        try:
            urlretrieve(cardImageUrl, downloadFileName)
        except Error as e:
            print("type:{0}".format(type(e)))
            print("args:{0}".format(e.args))
            print("message:{0}".format(e.message))
            print("{0}".format(e))
    else:
        print(downloadFileName + " exists.")


def getEnglishCardName(cardChineseUrl):
    cardEnglishUrl = cardChineseUrl.replace("/cn/", "/en/")
    print("English card url is " + cardEnglishUrl)
    html = urlopen(cardEnglishUrl)
    soup = BeautifulSoup(html, "html.parser")
    cardEnglishName = soup.find("img", src=re.compile(
        "http:\/\/magiccards\.info\/scans")).get("alt")

    # change file name like Rags (Rags/Riches) to RagsRiches
    pattern = "^[a-zA-Z]+ \(([a-zA-Z]+.*)/([a-zA-Z]+.*)\)"
    repatter = re.compile(pattern)
    matchOB = repatter.match(cardEnglishName)
    if matchOB:
        cardEnglishName = matchOB.group(1) + matchOB.group(2)
    return(cardEnglishName)


# start download
for oneSeries in cardSeriesList:
    print(oneSeries + " series is downloaded.")
    downloadOneSeriesImages(oneSeries)
