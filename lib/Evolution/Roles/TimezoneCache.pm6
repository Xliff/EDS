use v6.c;

use NativeCall;

use ICal::Raw::Definitions;
use Evolution::Raw::Types;

use ICal::Timezone;

use GLib::GList;

role Evolution::Roles::TimezoneCache {
  has ETimezoneCache $!etzc;

  method Evolution::Raw::Definitions::ETimezoneCache
  { $!etzc }

  method add_timezone (icaltimezone() $zone) {
    e_timezone_cache_add_timezone($!etzc, $zone);
  }

  method get_timezone (Str() $tzid, :$raw = False) {
    my $tz = e_timezone_cache_get_timezone($!etzc, $tzid);

    # Transfer: none
    $tz ??
      ( $raw ?? $tz !! ICal::Timezone.new($tz) )
      !!
      Nil;
  }

  method etimezonecache_get_type {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &e_timezone_cache_get_type, $n, $t );
  }

  method list_timezones (:$glist = False, :$raw = False) {
    returnGList(
      e_timezone_cache_list_timezones($!etzc),
      $glist,
      $raw,
      icaltimezone,
      ICal::Timezone
    );
  }

}

use GLib::Roles::Object;

our subset ETimezoneCacheAncestry is export of Mu
  where ETimezoneCache | GObject;

class Evolution::TimezoneCache {
  also does Evolution::Roles::TimezoneCache;
  also does GLib::Roles::Object;

  submethod BUILD (:$timezone-cache) {
    self.setETimezoneCache($timezone-cache) if $timezone-cache;
  }

  method setETimezoneCache (ETimezoneCacheAncestry $_) {
    my $to-parent;

    $!etzc = do {
      when ETimezoneCache {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ETimezoneCache, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (ETimezoneCacheAncestry $timezone-cache, :$ref = True) {
    return Nil unless $timezone-cache;

    my $o = self.bless( :$timezone-cache );
    $o.ref if $ref;
    $o;
  }

}

### /usr/include/evolution-data-server/libecal/e-timezone-cache.h

sub e_timezone_cache_add_timezone (ETimezoneCache $cache, icaltimezone $zone)
  is native(ecal)
  is export
{ * }

sub e_timezone_cache_get_timezone (ETimezoneCache $cache, Str $tzid)
  returns icaltimezone
  is native(ecal)
  is export
{ * }

sub e_timezone_cache_get_type ()
  returns GType
  is native(ecal)
  is export
{ * }

sub e_timezone_cache_list_timezones (ETimezoneCache $cache)
  returns GList
  is native(ecal)
  is export
{ * }
