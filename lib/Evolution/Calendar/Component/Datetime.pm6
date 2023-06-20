use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Datetime;

# BOXED
class Evolution::Calendar::Component::DateTime {
  also does GLib::Roles::Implementor;

  has ECalComponentDateTime $!eds-eccd is implementor;

  submethod BUILD ( :$eds-comp-datetime ) {
    $!eds-eccd = $eds-comp-datetime if $eds-comp-datetime;
  }

  method Evolution::Raw::Definitions::ECalComponentDateTime
    is also<ECalComponentDateTime>
  { $!eds-eccd }

  multi method new (ECalComponentDateTime $eds-comp-datetime) {
    $eds-comp-datetime ?? self.bless( :$eds-comp-datetime ) !! Nil;
  }
  multi method new (ICalTime() $value, Str() $tzid) {
    my $eds-comp-datetime = e_cal_component_datetime_new($value, $tzid);

    $eds-comp-datetime ?? self.bless( :$eds-comp-datetime ) !! Nil;
  }

  method tzid is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_tzid    },
      STORE => -> $, \v { self.set_tzid(v) }
  }

  method value is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_value    },
      STORE => -> $, \v { self.set_value(v) }
  }

  method new_take (ICalTime() $value, Str() $tzid) is also<new-take> {
    my $eds-comp-datetime = e_cal_component_datetime_new_take(
      $value,
      $tzid
    );

    $eds-comp-datetime ?? self.bless( :$eds-comp-datetime ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_datetime_copy($!eds-eccd),
      $raw,
      |self.getTypePair
    );
  }

  method !free {
    e_cal_component_datetime_free($!eds-eccd);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_datetime_get_type,
      $n,
      $t
    );
  }

  method get_tzid is also<get-tzid> {
    e_cal_component_datetime_get_tzid($!eds-eccd);
  }

  method get_value ( :$raw = False ) is also<get-value> {
    propReturnObject(
      e_cal_component_datetime_get_value($!eds-eccd),
      $raw,
      |ICal::GLib::Time.getTypePair
    );
  }

  method set (ICalTime() $value, Str() $tzid) {
    e_cal_component_datetime_set($!eds-eccd, $value, $tzid);
  }

  method set_tzid (Str() $tzid ) is also<set-tzid> {
    e_cal_component_datetime_set_tzid($!eds-eccd, $tzid);
  }

  method set_value (ICalTime() $value ) is also<set-value> {
    e_cal_component_datetime_set_value($!eds-eccd, $value);
  }

  method take_tzid (Str() $tzid ) is also<take-tzid> {
    e_cal_component_datetime_take_tzid($!eds-eccd, $tzid);
  }

  method take_value (ICalTime() $value ) is also<take-value> {
    e_cal_component_datetime_take_value($!eds-eccd, $value);
  }

}
