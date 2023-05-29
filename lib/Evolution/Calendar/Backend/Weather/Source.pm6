use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use GWeather::Raw::Definitions;
use GWeather::Raw::Structs;
use GLib::Roles::Implementor;
use GLib::Roles::Object;

class Evolution::Calendar::Backend::Weather::Source {
  also does GLib::Roles::Object;

  has EWeatherSource $!eds-ws is implementor;

  method new (Str() $location) {
    my $e-weather-source = e_weather_source_new($location);

    $e-weather-source ?? self.bless( :$e-weather-source ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_weather_source_get_type, $n, $t );
  }

  method parse (&done, gpointer $data  = gpointer) {
    e_weather_source_parse($!eds-ws, &done, $data);
  }

}


### /usr/src/evolution-data-server-3.48.0/src/calendar/backends/weather/e-weather-source.h

sub e_weather_source_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_weather_source_new (Str $location)
  returns EWeatherSource
  is      native(eds)
  is      export
{ * }

sub e_weather_source_parse (
  EWeatherSource $source,
                 &done    (GWeatherInfo, gpointer),
  gpointer       $data
)
  is      native(eds)
  is      export
{ * }
