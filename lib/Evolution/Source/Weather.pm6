use v6.c

use Evolution::Raw::Types;
use Evolution::Raw::Source::Weather;

use Evolution::Source::Extension;

our subset ESourceWeatherAncestry is export of Mu
  where ESourceWeather | ESourceExtensionAncestry;

class Evolution::Source::Weather is Evolution::Source::Extension {
  has ESourceWeather $!esw;

  submethod BUILD (:$weather) {
    self.setESourceWeather($weather) if $weather;
  }

  method setESourceWeather (ESourceWeatherAncestry $_) {
    my $to-parent;

    $!esw = do {
      when ESourceWeather {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceWeather, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceWeather
  { $!esw }

  method new (
    ESourceWeatherAncestry $weather,
                          :$ref   = True
  ) {
    return Nil unless $weather;

    my $o = self.bless( :$weather );
    $o.ref if $ref;
    $o;
  }

  method dup_location {
    e_source_weather_dup_location($!esw);
  }

  method get_location {
    e_source_weather_get_location($!esw);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_weather_get_type,
      $n,
      $t
    );
  }

  method get_units {
    ESourceWeatherUnitsEnum( e_source_weather_get_units($!esw) )
  }

  method set_location (Str() $location) {
    e_source_weather_set_location($!esw, $location);
  }

  method set_units (Int() $units) {
    my ESourceWeatherUnits $u = $units;

    e_source_weather_set_units($!esw, $u);
  }

}
