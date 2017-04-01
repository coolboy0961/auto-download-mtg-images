## prepare

### confirm perl
~~~
% perl -v

This is perl 5, version 18, subversion 2 (v5.18.2) built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail)

Copyright 1987-2013, Larry Wall
~~~
### cpanminus install
~~~
% brew search cpanminus
cpanminus
% brew install cpanminus
~~~

### HTML::TagParser install
~~~
sudo cpanm install HTML::TagParser
~~~
### URI::Fetch install
~~~
sudo cpanm install URL::Fetch
~~~

## usage
~~~
perl extractMagicCards.pl kld
This is 1'st card
Image Url is http://magiccards.info/scans/cn/kld/1.jpg
English Card Name is Acrobatic Maneuver
Chinese Card Name is 杂耍计略
This is 2'st card
Image Url is http://magiccards.info/scans/cn/kld/2.jpg
English Card Name is Aerial Responder
Chinese Card Name is 翔空援兵
This is 3'st card
Image Url is http://magiccards.info/scans/cn/kld/3.jpg
English Card Name is Aetherstorm Roc
Chinese Card Name is 乙太暴洛克鸟
This is 4'st card
Image Url is http://magiccards.info/scans/cn/kld/4.jpg
English Card Name is Angel of Invention
Chinese Card Name is 新创天使
This is 5'st card
Image Url is http://magiccards.info/scans/cn/kld/5.jpg
English Card Name is Authority of the Consuls
Chinese Card Name is 执政官威权
This is 6'st card
Image Url is http://magiccards.info/scans/cn/kld/6.jpg
English Card Name is Aviary Mechanic
Chinese Card Name is 停机库技师
This is 7'st card
Image Url is http://magiccards.info/scans/cn/kld/7.jpg
English Card Name is Built to Last
Chinese Card Name is 造以恒久
This is 8'st card
Image Url is http://magiccards.info/scans/cn/kld/8.jpg
English Card Name is Captured by the Consulate
Chinese Card Name is 执政院缉捕
This is 9'st card
Image Url is http://magiccards.info/scans/cn/kld/9.jpg
English Card Name is Cataclysmic Gearhulk
Chinese Card Name is 灾变巨械
This is 10'st card
Image Url is http://magiccards.info/scans/cn/kld/10.jpg
English Card Name is Consulate Surveillance
Chinese Card Name is 执政监视网
~~~
kld is the series name.

*You can confim this in url like this http://magiccards.info/kld/cn/67.html*

*Please notice kld.*

Chinese card images will be download in the same path as extractMagicCards.pl.
