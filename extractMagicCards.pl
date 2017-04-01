use strict;
use warnings;
use HTML::TagParser;

my $cardTotalCount = $ARGV[0];
my $cardSeries = $ARGV[1];
my $outputPath = $ARGV[2];

for (my $i = 1; $i <= $cardTotalCount; $i++) {
  # HTML::TagParserのオブジェクト作成
  my $html = HTML::TagParser->new( "http://magiccards.info/".$cardSeries."/cn/".$i.".html" );
  my @imgList = $html->getElementsByTagName( "img" );
  my $targetImageUrl;
  my $targetEnglishCardName;
  my $targetChineseCardName;
  foreach my $img (@imgList){
    my $imageUrl = $img->attributes->{src};
    my $cardName = $img->attributes->{alt};
    if($imageUrl =~ /http:\/\/magiccards\.info\/scans/){
      $targetImageUrl = $img->attributes->{src};
      $targetChineseCardName = $img->attributes->{alt};
    }
  }

  my @aList = $html->getElementsByTagName( "a" );
  foreach my $a (@aList) {
    my $href = $a->attributes->{href};
    if($href =~ /$cardSeries\/en\//){
      $targetEnglishCardName = $a->innerText();
    }
    if($href =~ /pca\/en\//){
      $targetEnglishCardName = $a->innerText().$i;
    }
  }
  print "This is ".$i."'st card\n";
  print "Image Url is ".$targetImageUrl."\n";
  print "English Card Name is ".$targetEnglishCardName."\n";
  print "Chinese Card Name is ".$targetChineseCardName."\n";
  `wget -q -O "$targetEnglishCardName.full.jpg" $targetImageUrl`;
}
