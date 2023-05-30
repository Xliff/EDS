use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Alarm::Repeat;

use ICal::GLib::Duration;

use GLib::Roles::Implementor;

class Evolution::Calendar::Component::Alarm::Repeat {
  also does GLib::Roles::Implementor;

  has ECalComponentAlarmRepeat $!eds-eccar is implementor;

  multi method new (ECalComponentAlarmRepeat $e-alarm-repeat) {
    $e-alarm-repeat ?? self.bless( :$e-alarm-repeat ) !! Nil;
  }
  multi method new (Int() $repetitions, ICalDuration() $interval) {
    my gint $r = $repetitions;

    my $e-alarm-repeat = e_cal_component_alarm_repeat_new($r, $interval);

    $e-alarm-repeat ?? self.bless( :$e-alarm-repeat ) !! Nil;
  }

  method new_seconds (Int() $repetitions, Int() $interval_seconds)
    is also<new-seconds>
  {
    my gint ($r, $i) = ($repetitions, $interval_seconds);

    my $e-alarm-repeat = e_cal_component_alarm_repeat_new_seconds($r, $i);

    $e-alarm-repeat ?? self.bless( :$e-alarm-repeat ) !! Nil;
  }

  method interval is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_interval    },
      STORE => -> $, \v { self.set_interval(v) }
  }

  method interval_seconds is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_interval_seconds    },
      STORE => -> $, \v { self.set_interval_seconds(v) }
  }

  method repetitions is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_repetitions    },
      STORE => -> $, \v { self.set_repetitions(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_repeat_copy($!eds-eccar),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cal_component_alarm_repeat_free($!eds-eccar);
  }

  method get_interval ( :$raw = False ) is also<get-interval> {
    propReturnObject(
      e_cal_component_alarm_repeat_get_interval($!eds-eccar),
      $raw,
      |ICal::GLib::Duration.getTypePair
    );
  }

  method get_interval_seconds is also<get-interval-seconds> {
    e_cal_component_alarm_repeat_get_interval_seconds($!eds-eccar);
  }

  method get_repetitions is also<get-repetitions> {
    e_cal_component_alarm_repeat_get_repetitions($!eds-eccar);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_alarm_repeat_get_type,
      $n,
      $t
    );
  }

  method set_interval (ICalDuration() $interval) is also<set-interval> {
    e_cal_component_alarm_repeat_set_interval($!eds-eccar, $interval);
  }

  method set_interval_seconds (Int() $interval_seconds)
    is also<set-interval-seconds>
  {
    my gint $i = $interval_seconds;

    e_cal_component_alarm_repeat_set_interval_seconds($!eds-eccar, $i);
  }

  method set_repetitions (Int() $repetitions) is also<set-repetitions> {
    my gint $r = $repetitions;

    e_cal_component_alarm_repeat_set_repetitions($!eds-eccar, $r);
  }

}
