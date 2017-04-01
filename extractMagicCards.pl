use strict;
use warnings;
use HTML::TagParser;

my $cardSeries = $ARGV[0];
my $outputPath = $ARGV[1];

my $cardUrl1="http://magiccards.info";

my $html = HTML::TagParser->new( "http://magiccards.info/query?q=%2B%2Be%3A".$cardSeries."%2Fcn&v=list&s=issue" );
my @aList = $html->getElementsByTagName( "a" );
foreach my $a (@aList) {
  my $href = $a->attributes->{href};
  if($href =~ /$cardSeries\/cn\//){
    my $cardUrl = $cardUrl1.$href;
    print "card url is ".$cardUrl."\n";
    &downloadImage($cardUrl);
  }
}

sub downloadImage{
  my $url = $_[0];
  my $html = HTML::TagParser->new( $url );
  my @imgList = $html->getElementsByTagName( "img" );
  my $targetImageUrl;
  my $targetEnglishCardName;
  my $targetChineseCardName;
  $url =~ /\/(.+)\.html/;
  my $i = $1;
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
    if($href =~ /\/en\//){
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
