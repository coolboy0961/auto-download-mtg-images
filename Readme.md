## prepare

### confirm python3
~~~
$ python3 --version
Python 3.6.1
~~~
### configparser install
~~~
$ pip3 install configparser
~~~

### beautifulsoup4 install
~~~
$ pip3 install beautifulsoup4
~~~

## setting
config.txt

~~~
[settings]
cardSeries=10e,4e,5e,6e,7e,8e,9e,a,aer,al,ala,an,ap,aq,arb,arc,avr,b,bfz,bng,bok,c13,c14,c15,c16,cfx,ch,chk,cm1,cn14,cn2,cns,com,cs,dd2,ddc,ddd,dde,ddf,ddg,ddh,ddi,ddj,ddk,ddl,ddm,ddn,ddo,ddp,ddq,ddr,dgm,dis,dk,dka,drb,ds,dtk,ema,emn,eve,evg,ex,exp,fd,fe,frf,fut,fve,fvl,fvr,gp,gtc,hl,hop,ia,in,isd,jou,ju,kld,ktk,le,lg,lrw,m10,m11,m12,m13,m14,m15,mbp,mbs,md1,me2,me3,me4,med,mi,mm,mm2,mma,mor,mps,mr,ne,nph,od,ogw,on,ori,p2,p3,pc2,pca,pd2,pd3,pds,plc,ps,pt,py,r,rav,roe,rtr,s2k,sc,sh,shm,soi,sok,som,st,te,ths,to,tpr,tsb,tsp,u,ud,ugf,ul,us,v12,v13,v14,v15,v16,van,vi,vma,w16,wl,wwk,zen
outputPath=./card
~~~

## usage
~~~
$ python3 downloadMtgCardImages.py
All series will be downloaded to xxx/card .
10e series is downloaded.
/Users/coolboy096188/Desktop/card/10E is created.
card url is http://magiccards.info/10e/cn/1.html
card image url is http://magiccards.info/scans/cn/10e/1.jpg
card cardChineseName is 祖灵的爱民
card cardEnglishName is Ancestor's Chosen
This card is downloaded to /Users/coolboy096188/Desktop/card/10E/Ancestor's Chosen.full.jpg
card url is http://magiccards.info/10e/cn/2.html
card image url is http://magiccards.info/scans/cn/10e/2.jpg
card cardChineseName is 慈悲天使
card cardEnglishName is Angel of Mercy
This card is downloaded to /Users/coolboy096188/Desktop/card/10E/Angel of Mercy.full.jpg
~~~
