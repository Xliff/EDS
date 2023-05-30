use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Alarm::Trigger;

use ICal::GLib::Time;
use ICal::GLib::Property;
use ICal::GLib::Duration;
use Evolution::Calendar::Component::ParameterBag;

use GLib::Roles::Implementor;

class Evolution::Calendar::Component::Alarm::Trigger {
  also does GLib::Roles::Implementor;

  has ECalComponentAlarmTrigger $!eds-eccat is implementor;

  method new (ECalComponentAlarmTrigger $e-alarm-trigger) {
    $e-alarm-trigger ?? self.bless( :$e-alarm-trigger ) !! Nil;
  }

  method new_absolute (ICalTime() $absolute_time) {
    my $e-alarm-trigger = e_cal_component_alarm_trigger_new_absolute(
      $absolute_time
    );

    $e-alarm-trigger ?? self.bless( :$e-alarm-trigger ) !! Nil;
  }

  method new_from_property (ICalProperty() $property) {
    my $e-alarm-trigger = e_cal_component_alarm_trigger_new_from_property(
      $property
    );

    $e-alarm-trigger ?? self.bless( :$e-alarm-trigger ) !! Nil;
  }

  method new_relative (Int() $kind, ICalDuration() $duration) {
    my ECalComponentAlarmTriggerKind $k = $kind;

    my $e-alarm-trigger = e_cal_component_alarm_trigger_new_relative(
      $k,
      $duration
    );

    $e-alarm-trigger ?? self.bless( :$e-alarm-trigger ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_trigger_copy($!eds-eccat),
      $raw,
      |self.getTypePair
    );
  }

  method fill_property (ICalProperty() $property) {
    e_cal_component_alarm_trigger_fill_property($!eds-eccat, $property);
  }

  method free {
    e_cal_component_alarm_trigger_free($!eds-eccat);
  }

  method get_absolute_time ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_trigger_get_absolute_time($!eds-eccat),
      $raw,
      |ICal::GLib::Time.getTypePair
    );
  }

  method get_as_property ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_trigger_get_as_property($!eds-eccat),
      $raw,
      |ICal::GLib::Property.getTypePair
    )
  }

  method get_duration ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_trigger_get_duration($!eds-eccat),
      $raw,
      |ICal::GLib::Duration.getTypePair
    );
  }

  method get_kind ( :$enum = True ) {
    my $k = e_cal_component_alarm_trigger_get_kind($!eds-eccat);
    return $k unless $enum;
    ECalComponentAlarmTriggerKind($k);
  }

  method get_parameter_bag ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_trigger_get_parameter_bag($!eds-eccat),
      $raw,
      |Evolution::Calendar::Component::ParameterBag.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_alarm_trigger_get_type,
      $n,
      $t
    );
  }

  method set_absolute (ICalTime() $absolute_time) {
    e_cal_component_alarm_trigger_set_absolute($!eds-eccat, $absolute_time);
  }

  method set_absolute_time (ICalTime() $absolute_time) {
    e_cal_component_alarm_trigger_set_absolute_time(
      $!eds-eccat,
      $absolute_time
    );
  }

  method set_duration (ICalDuration() $duration) {
    e_cal_component_alarm_trigger_set_duration($!eds-eccat, $duration);
  }

  method set_from_property (ICalProperty() $property) {
    e_cal_component_alarm_trigger_set_from_property($!eds-eccat, $property);
  }

  method set_kind (Int() $kind) {
    my ECalComponentAlarmTriggerKind $k = $kind;

    e_cal_component_alarm_trigger_set_kind($!eds-eccat, $k);
  }

  method set_relative (Int() $kind, ICalDuration() $duration) {
    my ECalComponentAlarmTriggerKind $k = $kind;

    e_cal_component_alarm_trigger_set_relative($!eds-eccat, $k, $duration);
  }

}
