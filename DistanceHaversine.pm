package DDG::Goodie::DistanceHaversine;
# ABSTRACT: Calculates the distance in meters between two coordinates using the haversine formula

use DDG::Goodie;
use GIS::Distance;

triggers start => 'from';
triggers start => 'to';

primary_example_queries 'from 32.5058801,-116.9479381 to 32.5057611,-116.9495635';
description 'get the distance in meters between two coordinates';
name 'DistanceHaversine';
category 'calculations';

zci is_cached => 1;
zci answer_type => "haversine_distance";

handle remainder => sub {
   if($_ =~ /^(\-?\d+(\.\d+)?,\s*\-?\d+(\.\d+)?)\s*(to|from)\s*(\-?\d+(\.\d+)?,\s*\-?\d+(\.\d+)?)$/) {
      my $gis = GIS::Distance->new();
      my @coordfrom = split(/,/,lc $1);
      my @coordto = split(/,/,lc $5);

      my $dist = ($gis->distance($coordfrom[0],$coordfrom[1],
            $coordto[0],$coordto[1])->meters());
      return 'Distance: '.$dist.' meters';
   } return;
};

1;
