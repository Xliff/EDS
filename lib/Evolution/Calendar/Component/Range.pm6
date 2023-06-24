use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Range;

use GLib::Roles::Implementor;

# BOXED;

class Evolution::Calendar::Component::Range {
  has ECalComponentRange $!eds-eccr is implementor;

  submethod BUILD ( :$e-comp-range ) {
    $!eds-eccr = $e-comp-range;
  }

  method Evolution::Raw::Definitions::ECalComponentRange
    is also<ECalComponentRange>
  { $!eds-eccr }

  method new (Int() $kind, ECalComponentDateTime() $datetime) is static {
    my ECalComponentRangeKind $k = $kind;

    my $e-comp-range = e_cal_component_range_new($k, $datetime);

    $e-comp-range ?? self.bless( :$e-comp-range ) !! Nil;
  }

  method new_take (Int() $kind, ECalComponentDateTime() $datetime)
    is static

    is also<new-take>
  {
    my ECalComponentRangeKind $k = $kind;

    my $e-comp-range =  e_cal_component_range_new_take($kind, $datetime);

    $e-comp-range ?? self.bless( :$e-comp-range ) !! Nil;
  }

  method datetime is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_datetime    },
      STORE => -> $, \v { self.set_datetime(v) }
  }

  method kind is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_kind    },
      STORE => -> $, \v { self.set_kind(v) }
  }


  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_range_copy($!eds-eccr),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cal_component_range_free($!eds-eccr);
  }

  method get_datetime ( :$raw = False ) is also<get-datetime> {
    propReturnObject(
      e_cal_component_range_get_datetime($!eds-eccr),
      $raw,
      |Evolution::Calendar::Component::DateTime.getTypePair
    )
  }

  method get_kind ( :$enum = True ) is also<get-kind> {
    my $k = e_cal_component_range_get_kind($!eds-eccr);
    return $k unless $enum;
    ECalComponentRangeKindEnum($k);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_component_range_get_type, $n, $t );
  }

  method set_datetime (ECalComponentDateTime() $datetime)
    is also<set-datetime>
  {
    e_cal_component_range_set_datetime($!eds-eccr, $datetime);
  }

  method set_kind (Int() $kind) is also<set-kind> {
    my ECalComponentRangeKind $k = $kind;

    e_cal_component_range_set_kind($!eds-eccr, $k);
  }

  method take_datetime (ECalComponentDateTime() $datetime)
    is also<take-datetime>
  {
    e_cal_component_range_take_datetime($!eds-eccr, $datetime);
  }

}
