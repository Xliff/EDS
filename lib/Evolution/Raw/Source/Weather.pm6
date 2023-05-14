use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Weather;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-weather.h

sub e_source_weather_dup_location (ESourceWeather $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_weather_get_location (ESourceWeather $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_weather_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_weather_get_units (ESourceWeather $extension)
  returns ESourceWeatherUnits
  is native(eds)
  is export
{ * }

sub e_source_weather_set_location (ESourceWeather $extension, Str $location)
  is native(eds)
  is export
{ * }

sub e_source_weather_set_units (
  ESourceWeather      $extension,
  ESourceWeatherUnits $units
)
  is native(eds)
  is export
{ * }
