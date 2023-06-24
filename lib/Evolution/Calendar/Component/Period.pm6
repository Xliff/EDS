use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Period;

# BOXED

class Evolution::Calendar::Component::Period {
  has ECalComponentPeriod $!eds-eccp is implementor;

  submethod BUILD ( :$e-cal-period ) {
    $!eds-eccp = $e-cal-period if $e-cal-period
  }

  method Evolution::Raw::Definitions::ECalComponentPeriod
    is also<ECalComponentPeriod>
  { $!eds-eccp }

  method new (ECalComponentPeriod $e-cal-period) {
    $e-cal-period ?? self.bless( :$e-cal-period ) !! Nil;
  }

  method new_datetime (ICalTime() $start, ICalTime() $end)
    is also<new-datetime>
  {
    my $e-cal-period = e_cal_component_period_new_datetime($start, $end);

    $e-cal-period ?? self.bless( :$e-cal-period ) !! Nil;
  }

  method new_duration (ICalTime() $start, ICalDuration() $duration)
    is also<new-duration>
  {
    my $e-cal-period = e_cal_component_period_new_duration($start, $duration);

    $e-cal-period ?? self.bless( :$e-cal-period ) !! Nil;
  }

  method duration is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_duration    },
      STORE => -> $, \v { self.set_duration(v) }
  }

  method end is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_end    },
      STORE => -> $, \v { self.set_end(v) }
  }

  method start is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_start    },
      STORE => -> $, \v { self.set_start(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_period_copy($!eds-eccp),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cal_component_period_free($!eds-eccp);
  }

  method get_duration ( :$raw = False ) is also<get-duration> {
    propReturnObject(
      e_cal_component_period_get_duration($!eds-eccp),
      $raw,
      |self.getTypePair
    );
  }

  method get_end ( :$raw = False ) is also<get-end> {
    propReturnObject(
      e_cal_component_period_get_end($!eds-eccp),
      $raw,
      |ICal::GLib::Time.getTypePair
    );
  }

  method get_kind ( :$enum = True ) is also<get-kind> {
    my $k =  e_cal_component_period_get_kind($!eds-eccp);
    return $k unless $enum;
    ECalComponentPeriodKind($k);
  }

  method get_start ( :$raw = False ) is also<get-start> {
    propReturnObject(
      e_cal_component_period_get_start($!eds-eccp),
      $raw,
      |ICal::GLib::Time.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_component_period_get_type, $n, $t );
  }

  method set_datetime_full (ICalTime() $start, ICalTime() $end)
    is also<set-datetime-full>
  {
    e_cal_component_period_set_datetime_full($!eds-eccp, $start, $end);
  }

  method set_duration (ICalDuration() $duration ) is also<set-duration> {
    e_cal_component_period_set_duration($!eds-eccp, $duration);
  }

  method set_duration_full (ICalTime() $start, ICalDuration() $duration)
    is also<set-duration-full>
  {
    e_cal_component_period_set_duration_full($!eds-eccp, $start, $duration);
  }

  method set_end (ICalTime() $end ) is also<set-end> {
    e_cal_component_period_set_end($!eds-eccp, $end);
  }

  method set_start (ICalTime() $start ) is also<set-start> {
    e_cal_component_period_set_start($!eds-eccp, $start);
  }

}
