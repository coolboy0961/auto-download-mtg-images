
=pod
version 0.5.0   changelog
                          add download function.
                          add config file to config the series wanted download and output path.
=cut

use strict;
use warnings;
use HTML::TagParser;

my $configFileName = "config.txt";
my $cardSeries;
my $outputPath;

#設定ファイルを読み込む
open( DATAFILE, "< " . $configFileName ) or die("error :$!");
while ( my $line = <DATAFILE> ) {
    chomp($line);
    if ( $line =~ /cardSeries=/ ) {
        $cardSeries = $';
        print "Download All Card Series is " . $cardSeries . "\n";
    }
    if ( $line =~ /outputPath=/ ) {
        $outputPath = $';
        print "Output Path is " . $outputPath . "\n";
    }
}

my @cardSeriesList = split( /,/, $cardSeries );
for ( my $i = 0 ; $i < @cardSeriesList ; $i++ ) {
    print $cardSeriesList[$i] . "'s download is started.\n";
    my $path = $outputPath . "\/" . uc( $cardSeriesList[$i] );

    #ディレクトリ作成
    if ( -d $path ) {
        print "dir " . $path . " is already exist.\n";
    }
    else {
        mkdir $path;    #存在しなければ新たに作成する
        print "dir " . $path . " is created.\n";
    }

    #一シリーズのファイルをダウンロード
    my $cardUrl1 = "http://magiccards.info";
    my $html =
      HTML::TagParser->new(
        "http://magiccards.info/" . $cardSeriesList[$i] . "/cn.html" );
    print "download all card in "
      . "http://magiccards.info/"
      . $cardSeriesList[$i]
      . "/cn.html" . " to "
      . $path . "\n";
    my @aList = $html->getElementsByTagName("a");
    foreach my $a (@aList) {
        my $href = $a->attributes->{href};
        if ( $href =~ /$cardSeriesList[$i]\/cn\// ) {
            my $cardUrl = $cardUrl1 . $href;
            print "download card in " . $cardUrl . " to " . $path . "\n";
            &downloadOneCardImage( $cardUrl, $path );
        }
    }
}

sub downloadOneCardImage {
    my $url     = $_[0];
    my $path    = $_[1];
    my $html    = HTML::TagParser->new($url);
    my @imgList = $html->getElementsByTagName("img");
    my $targetImageUrl;
    my $targetEnglishCardName;
    my $targetChineseCardName;
    $url =~ /\/(\d+\w?)\.html/;
    my $cardNumber = $1;

    #print "\$url is " . $url . "\n";
    #print "\$cardNumber is " . $cardNumber . "\n";

    foreach my $img (@imgList) {
        my $imageUrl = $img->attributes->{src};
        my $cardName = $img->attributes->{alt};
        if ( $imageUrl =~ /http:\/\/magiccards\.info\/scans/ ) {
            $targetImageUrl        = $img->attributes->{src};
            $targetChineseCardName = $img->attributes->{alt};
        }
    }

    my @aList = $html->getElementsByTagName("a");
    foreach my $a (@aList) {
        my $href = $a->attributes->{href};
        if ( $href =~ /\/en\// ) {
            $targetEnglishCardName = $a->innerText();
        }
        if ( $href =~ /pca\/en\// ) {
            $targetEnglishCardName = $a->innerText() . $cardNumber;
        }
    }
    print "This is " . $cardNumber . "'st card\n";
    print "download "
      . $targetImageUrl . "to "
      . "$path\/$targetEnglishCardName.full.jpg" . "\n";
    print "English Card Name is " . $targetEnglishCardName . "\n";
    print "Chinese Card Name is " . $targetChineseCardName . "\n";
    `wget -q -O "$path\/$targetEnglishCardName.full.jpg" $targetImageUrl`;
}
