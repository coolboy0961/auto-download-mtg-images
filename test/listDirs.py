import os

files = os.listdir("/Users/coolboy096188/Library/Caches/Forge/pics/cards")
str = ""
for file in files:
    str += file.lower() + ","
print(str)

str2 = "ab"
str2 = str2.replace("/", ":")
print(str2)
