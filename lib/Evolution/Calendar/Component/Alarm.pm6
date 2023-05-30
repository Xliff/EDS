use v6.c;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Alarm;

use ICal::GLib::Attach;
use ICal::GLib::Component;
use ICal::GLib::Time;

use GLib::GSList;

use Evolution::Calendar::Component::Alarm::Repeat;
use Evolution::Calendar::Component::Alarm::Trigger;
use Evolution::Calendar::Component::Attendee;
use Evolution::Calendar::Component::Text;
use Evolution::Calendar::Component::PropertyBag;

use GLib::Roles::Implementor;

class Evolution::Calendar::Component::Alarm {
  also does GLib::Roles::Implementor;

  has ECalComponentAlarm $!eds-ecca is implementor;

  submethod BUILD ( :$e-cal-component-alarm ) {
    $!eds-ecca = $e-cal-component-alarm;
  }

  method Evolution::Raw::Definitions::ECalComponentAlarm
  { $!eds-ecca };

  multi method new (ECalComponentAlarm $e-cal-component-alarm) {
    $e-cal-component-alarm ?? self.bless( :$e-cal-component-alarm ) !! Nil;
  }
  multi method new {
    my $e-cal-component-alarm = e_cal_component_alarm_new();

    $e-cal-component-alarm ?? self.bless( :$e-cal-component-alarm ) !! Nil;
  }

  method new_from_component (ICalComponent() $component) {
    my $e-cal-component-alarm = e_cal_component_alarm_new_from_component(
      $component
    );

    $e-cal-component-alarm ?? self.bless( :$e-cal-component-alarm ) !! Nil;
  }

  method acknowledged is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_acknowledged    },
      STORE => -> $, \v { self.set_acknowledged(v) }
  }

  method action is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_action    },
      STORE => -> $, \v { self.set_action(v) }
  }

  method attachments is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_attachments    },
      STORE => -> $, \v { self.set_attachments(v) }
  }

  method attendees is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_attendees    },
      STORE => -> $, \v { self.set_attendees(v) }
  }

  method description is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_description    },
      STORE => -> $, \v { self.set_description(v) }
  }

  method repeat is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_repeat    },
      STORE => -> $, \v { self.set_repeat(v) }
  }

  method summary is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_summary    },
      STORE => -> $, \v { self.set_summary(v) }
  }

  method trigger is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_trigger    },
      STORE => -> $, \v { self.set_trigger(v) }
  }

  method uid is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_uid    },
      STORE => -> $, \v { self.set_uid(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_copy($!eds-ecca),
      $raw,
      |self.getTypePair
    )
  }

  method fill_component (ICalComponent() $component) {
    e_cal_component_alarm_fill_component($!eds-ecca, $component);
  }

  method free {
    e_cal_component_alarm_free($!eds-ecca);
  }

  method get_acknowledged ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_acknowledged($!eds-ecca),
      $raw,
      |ICal::GLib::Time.getTypePair
    );
  }

  method get_action ( :$enum = True ) {
    my $a = e_cal_component_alarm_get_action($!eds-ecca);
    return $a unless $enum;
    ECalComponentAlarmActionEnum($a);
  }

  method get_as_component ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_as_component($!eds-ecca),
      $raw,
      |ICal::GLib::Component.getTypePair
    );
  }

  method get_attachments ( :$raw = False, :glist(:$gslist) = False ) {
    returnGSList(
      e_cal_component_alarm_get_attachments($!eds-ecca),
      $raw,
      $gslist,
      |ICal::GLib::Attach.getTypePair
    );
  }

  method get_attendees ( :$raw = False, :glist(:$gslist) = False ) {
    returnGSList(
      e_cal_component_alarm_get_attendees($!eds-ecca),
      $raw,
      $gslist,
      |Evolution::Calendar::Component::Attendee.getTypePair
    );
  }

  method get_description ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_description($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component::Text.getTypePair
    );
  }

  method get_property_bag ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_property_bag($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component::PropertyBag.getTypePair
    );
  }

  method get_repeat (:$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_repeat($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component::Alarm::Repeat.getTypePair
    );
  }

  method get_summary ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_summary($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component::Text.getTypePair
    );
  }

  method get_trigger ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarm_get_trigger($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component::Alarm::Trigger.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_component_alarm_get_type, $n, $t );
  }

  method get_uid {
    e_cal_component_alarm_get_uid($!eds-ecca);
  }

  method has_attachments {
    so e_cal_component_alarm_has_attachments($!eds-ecca);
  }

  method has_attendees {
    so e_cal_component_alarm_has_attendees($!eds-ecca);
  }

  method set_acknowledged (ICalTime() $when) {
    e_cal_component_alarm_set_acknowledged($!eds-ecca, $when);
  }

  method set_action (ECalComponentAlarmAction() $action) {
    e_cal_component_alarm_set_action($!eds-ecca, $action);
  }

  method set_attachments (GSList() $attachments) {
    e_cal_component_alarm_set_attachments($!eds-ecca, $attachments);
  }

  method set_attendees (GSList() $attendees) {
    e_cal_component_alarm_set_attendees($!eds-ecca, $attendees);
  }

  method set_description (ECalComponentText() $description) {
    e_cal_component_alarm_set_description($!eds-ecca, $description);
  }

  method set_from_component (ICalComponent() $component) {
    e_cal_component_alarm_set_from_component($!eds-ecca, $component);
  }

  method set_repeat (ECalComponentAlarmRepeat() $repeat) {
    e_cal_component_alarm_set_repeat($!eds-ecca, $repeat);
  }

  method set_summary (ECalComponentText() $summary) {
    e_cal_component_alarm_set_summary($!eds-ecca, $summary);
  }

  method set_trigger (ECalComponentAlarmTrigger() $trigger) {
    e_cal_component_alarm_set_trigger($!eds-ecca, $trigger);
  }

  method set_uid (Str() $uid) {
    e_cal_component_alarm_set_uid($!eds-ecca, $uid);
  }

  method take_acknowledged (ICalTime() $when) {
    e_cal_component_alarm_take_acknowledged($!eds-ecca, $when);
  }

  method take_attachments (GSList() $attachments) {
    e_cal_component_alarm_take_attachments($!eds-ecca, $attachments);
  }

  method take_attendees (GSList() $attendees) {
    e_cal_component_alarm_take_attendees($!eds-ecca, $attendees);
  }

  method take_description (ECalComponentText() $description) {
    e_cal_component_alarm_take_description($!eds-ecca, $description);
  }

  method take_repeat (ECalComponentAlarmRepeat() $repeat) {
    e_cal_component_alarm_take_repeat($!eds-ecca, $repeat);
  }

  method take_summary (ECalComponentText() $summary) {
    e_cal_component_alarm_take_summary($!eds-ecca, $summary);
  }

  method take_trigger (ECalComponentAlarmTrigger() $trigger) {
    e_cal_component_alarm_take_trigger($!eds-ecca, $trigger);
  }

}
