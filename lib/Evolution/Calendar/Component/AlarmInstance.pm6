use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::AlarmInstance;

# BOXED

class Evolution::Calendar::Component::AlarmInstance {
  also does GLib::Roles::Implementor;

  has ECalComponentAlarmInstance $!eds-eccai is implementor;

  submethod BUILD ( :$e-cal-alarminstance ) {
    $!eds-eccai = $e-cal-alarminstance if $e-cal-alarminstance;
  }

  method Evolution::Raw::Structs::ECalComponentAlarmInstance
    is also<ECalComponentAlarmInstance>
  { $!eds-eccai }

  multi method new (
    ECalComponentAlarmInstance $e-cal-alarminstance,

    :$ref = True
  ) {
    return Nil unless $e-cal-alarminstance;

    my $o = self.bless( :$e-cal-alarminstance );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $uid,
    time_t $instance_time,
    time_t $occur_start,
    time_t $occur_end
  ) {
    my time_t ($i, $s, $e) = ($instance_time, $occur_start, $occur_end);

    my $e-cal-alarminstance = e_cal_component_alarm_instance_new(
      $uid,
      $i,
      $s,
      $e
    );

    $e-cal-alarminstance ?? self.bless( :$e-cal-alarminstance ) !! Nil;
  }

  method component is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_component    },
      STORE => -> $, \v { self.set_component(v) }
  }

  method occur_end is rw is g-accessor is also<occur-end> {
    Proxy.new:
      FETCH => -> $     { self.get_occur_end    },
      STORE => -> $, \v { self.set_occur_end(v) }
  }

  method occur_start is rw is g-accessor is also<occur-start> {
    Proxy.new:
      FETCH => -> $     { self.get_occur_start    },
      STORE => -> $, \v { self.set_occur_start(v) }
  }

  method rid is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_rid    },
      STORE => -> $, \v { self.set_rid(v) }
  }

  method time is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_time    },
      STORE => -> $, \v { self.set_time(v) }
  }

  method uid is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_uid    },
      STORE => -> $, \v { self.set_uid(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_instance_copy($!eds-eccai),
      $raw,
      |self.getTypePair
    );
  }

  method !free {
    e_cal_component_alarm_instance_free($!eds-eccai);
  }

  submethod DESTROY {
    #self!free
  }

  method get_component ( :$raw = False ) is also<get-component> {
    propReturnObject(
      e_cal_component_alarm_instance_get_component($!eds-eccai),
      $raw,
      |Evolution::Calendar::Component.getTypePair
    );
  }

  method get_occur_end is also<get-occur-end> {
    e_cal_component_alarm_instance_get_occur_end($!eds-eccai);
  }

  method get_occur_start is also<get-occur-start> {
    e_cal_component_alarm_instance_get_occur_start($!eds-eccai);
  }

  method get_rid is also<get-rid> {
    e_cal_component_alarm_instance_get_rid($!eds-eccai);
  }

  method get_time is also<get-time> {
    e_cal_component_alarm_instance_get_time($!eds-eccai);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_alarm_instance_get_type,
      $n,
      $t
    );
  }

  method get_uid is also<get-uid> {
    e_cal_component_alarm_instance_get_uid($!eds-eccai);
  }

  method set_component (ECalComponent() $component) is also<set-component> {
    e_cal_component_alarm_instance_set_component($!eds-eccai, $component);
  }

  method set_occur_end (Int() $occur_end) is also<set-occur-end> {
    my time_t $e = $occur_end;

    e_cal_component_alarm_instance_set_occur_end($!eds-eccai, $e);
  }

  method set_occur_start (Int() $occur_start) is also<set-occur-start> {
    my time_t $s = $occur_start;

    e_cal_component_alarm_instance_set_occur_start($!eds-eccai, $s);
  }

  method set_rid (Str() $rid) is also<set-rid> {
    e_cal_component_alarm_instance_set_rid($!eds-eccai, $rid);
  }

  method set_time (Int() $instance_time) is also<set-time> {
    my time_t $i = $instance_time;

    e_cal_component_alarm_instance_set_time($!eds-eccai, $i);
  }

  method set_uid (Str() $uid) is also<set-uid> {
    e_cal_component_alarm_instance_set_uid($!eds-eccai, $uid);
  }

}
