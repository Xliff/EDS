use v6.c;

use ICal::Raw::Definitions;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component;

use GLib::GList;
use ICal::Attach;
use ICal::Component;
use ICal::Property;

our subset ECalComponentAncestry is export of Mu
  where ECalComponent | GObject

class Evolution::Calendar::Componment {
  also does GLib::Object;

  has ECalComponent $!ecc;

  submethod BUILD (:$calendar-component) {
    self.setECalComponent($calendar-component) if $calendar-component;
  }

  method setECalComponent (ECalComponentAncestry $_) {
    my $to-parent;

    $!c = do {
      when ECalComponent {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalComponent, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECalComponent
  { $!ecc }

  multi method new (ECalComponentAncestry $client, :$ref = True) {
    return Nil unless $client;

    my $o = self.bless( :$client );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $calendar-component = e_cal_component_new();

    $calendar-component ?? self.bless( :$calendar-component ) !! Nil;
  }

  method new_from_icalcomponent (icalcomponent() $icalcomp) {
    $calendar-component = e_cal_component_new_from_icalcomponent($icalcomp);

    $calendar-component ?? self.bless( :$calendar-component ) !! Nil;
  }

  method new_from_string (Str() $calobj) {
    my $calendar-component = e_cal_component_new_from_string($calobj);

    $calendar-component ?? self.bless( :$calendar-component ) !! Nil;
  }

  method new_vtype (Int() $vtype) {
    my ECalComponentVType $v = $vtype;

    my $calendar-component = e_cal_component_new_vtype($vtype);

    $calendar-component ?? self.bless( :$calendar-component ) !! Nil;
  }

  method attachments (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_attachments(:$glist, :$raw) },
      STORE => $, $v { self.set_attachments($!att, $v)      }
  }

  method attendees (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_attendees(:$glist, :$raw) },
      STORE => $, $v { self.set_attendees($!att, $v)      }
  }

  method categories is rw {
    Proxy.new:
      FETCH => $           { self.get_categories            },
      STORE => $, Str() $v { self.set_categories($!att, $v) }
  }

  method categories_list is rw {
    Proxy.new:
      FETCH => $     { self.get_categories_list           },
      STORE => $, \v { self.set_categories_list($!att, v) }
  }

  method classification is rw {
    Proxy.new:
      FETCH => $           { self.get_classification            },
      STORE => $, Int() $v { self.set_classification($!att, $v) }
  }

  method comments (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_comments(:$glist, :$raw) },
      STORE => $, \v { self.set_comments($!att, v)       }
  }

  method completed (:$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_completed(:$raw)    },
      STORE => $, \v { self.set_completed($!att, v) }
  }

  method contacts is rw {
    Proxy.new:
      FETCH => $     { self.get_contacts           },
      STORE => $, \v { self.set_contacts($!att, v) }
  }

  method created (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $                    { self.get_created            },
      STORE => $, icaltimetype() $v { self.set_created($!att, $v) }
  }

  method descriptions (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_descriptions(:$glist, :$raw) },
      STORE => $, \v { self.set_descriptions($!att, v)       }
  }

  method dtend (:$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_dtend(:$raw)    },
      STORE => $, \v { self.set_dtend($!att, v) }
  }

  method dtstamp(:$raw = False) is rw {
    Proxy.new:
      FETCH => $                    { self.get_dtstamp(:$raw)    },
      STORE => $, icaltimetype() $v { self.set_dtstamp($!att, v) }
  }

  method dtstart (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                             { self.get_dtstart(:$raw)     },
      STORE => $, ECalComponentDateTime() $v { self.set_dtstart($!att, $v) }
  }

  method due (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                           { self.get_due(:$raw)     },
      STORE => $, ECalComponentDateTime $v { self.set_due($!att, $v) }
  }

  method exdates (:$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_exdates(:$glist, :$raw) },
      STORE => $, \v { self.set_exdates($!att, v)        }
  }

  method exrules (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_exrules(:$glist, :$raw) },
      STORE => $, \v { self.set_exrules($!att, v)       }
  }

  method geo is rw {
    Proxy.new:
      FETCH => $                   { self.get_geo           },
      STORE => $, icalgeotypetype() $v { self.set_geo($!att, v) }
  }

  method icalcomponent (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                      { self.get_icalcomponent(:$raw)     },
      STORE => $, icalcomponment() $v { self.set_icalcomponent($!att, $v) }
  }

  method last_modified (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                    { self.get_last_modified(:$raw)     },
      STORE => $, icaltimetype() $v { self.set_last_modified($!att, $v) }
  }

  method location is rw {
    Proxy.new:
      FETCH => $           { self.get_location            },
      STORE => $, Str() \v { self.set_location($!att, $v) }
  }

  method organizer (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                              { self.get_organizer(:$raw)    },
      STORE => $, ECalComponentOrganizer() $v { self.set_organizer($!att, v) }
  }

  method percent_complete is rw {
    Proxy.new:
      FETCH => $           { self.get_percent_complete            },
      STORE => $, Int() $v { self.set_percent_complete($!att, $v) }
  }

  method priority is rw {
    Proxy.new:
      FETCH => $           { self.get_priority            },
      STORE => $, Int() $v { self.set_priority($!att, $v) }
  }

  method rdates (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_rdates(:$glist, :$raw },
      STORE => $, \v { self.set_rdates($!att, v)      }
  }

  method recurid (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                          { self.get_recurid(:$raw)    },
      STORE => $, ECalComponentRange() \v { self.set_recurid($!att, v) }
  }

  method rrules (:$glist = False, :$raw = False) is rw {
    Proxy.new:
      FETCH => $     { self.get_rrules(:$glist, :$raw) },
      STORE => $, \v { self.set_rrules($!att, v)       }
  }

  method sequence is rw {
    Proxy.new:
      FETCH => $           { self.get_sequence           },
      STORE => $, Int() $v { self.set_sequence($!att, $v) }
  }

  method status is rw {
    Proxy.new:
      FETCH => $           { self.get_status            },
      STORE => $, Int() $v { self.set_status($!att, $v) }
  }

  method summary (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                       { self.get_summary(:$raw)    },
      STORE => $, ECalComponentText $v { self.set_summary($!att, v) }
  }

  method transparency (:$raw = False) is rw {
    Proxy.new:
      FETCH => $                         { self.get_transparency(:$raw)     },
      STORE => $, ECalComponentText() $v { self.set_transparency($!att, $v) }
  }

  method uid is rw {
    Proxy.new:
      FETCH => $           { self.get_uid            },
      STORE => $, Str() $v { self.set_uid($!att, $v) }
  }

  method url is rw {
    Proxy.new:
      FETCH => $           { self.get_url           },
      STORE => $, Str() $v { self.set_url($!att, $v) }
  }

  method abort_sequence {
    e_cal_component_abort_sequence($!ecc);
  }

  method add_alarm (ECalComponentAlarm() $alarm) {
    e_cal_component_add_alarm($!ecc, $alarm);
  }

  method clone (:$raw = False) {
    my $c = e_cal_component_clone($!ecc);

    $c ??
      ( $raw ?? $c !! Evolution::Calendar::Component.new($c) )
      !!
      Nil;
  }

  method commit_sequence {
    e_cal_component_commit_sequence($!ecc);
  }

  method get_alarm (Str() $auid, :$raw = False) {
    my $a = e_cal_component_get_alarm($!ecc, $auid);

    $a ??
      ( $raw ?? $a !! ::('ECalendar::Component::Alarm').new($raw) )
      !!
      Nil;
  }

  method get_alarm_uids (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_alarm_uids($!ecc),
      $glist,
      $raw
    )
  }

  method get_all_alarms (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_all_alarms($!ecc),
      $glist,
      $raw,
      ECalComponentAlarm,
      ::('Evolution::Calendar::Component::Alarm'),
    )

  }

  method get_as_string {
    e_cal_component_get_as_string($!ecc);
  }

  method get_attachments (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_attachments($!ecc),
      $glist,
      $raw,
      icalattach,
      ICal::Attach
    );
  }

  method get_attendees (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_attendees($!ecc),
      $glist,
      $raw,
      ECalComponentAttendee,
      ::('Evolution::Calendar::Component::Attendee')
    );
  }

  method get_categories {
    e_cal_component_get_categories($!ecc);
  }

  method get_categories_list {
    returnGList(
      e_cal_component_get_categories_list($!ecc),
      $glist,
      $raw
    )
  }

  method get_classification (:$raw = False) {
    my $c = e_cal_component_get_classification($!ecc);

    $c ??
      ( $raw ?? $c !! ::('Evolution::Calendar::Component::Classification').new($c) )
      !!
      Nil;
  }

  method get_comments (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_comments($!ecc),
      $glist,
      $raw,
      ECalComponentText,
      ::('Evolution::Calendar::Component::Text')
    )
  }

  method get_completed {
    e_cal_component_get_completed($!ecc);
  }

  method get_contacts (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_contacts($!ecc),
      $glist,
      $raw,
      ECalComponentText,
      ::('Evolution::Calendar::Component::Text')
    );
  }

  method get_created {
    e_cal_component_get_created($!ecc);
  }

  method get_descriptions (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_descriptions($!ecc),
      $glist,
      $raw,
      ECalComponentText,
      ::('Evolution::Calendar::Component::Text')
    )
  }

  method get_dtend (:$raw = False) {
    my $t = e_cal_component_get_dtend($!ecc);

    $t ??
      ( $raw ?? $t !! ::('Evolution::Calendar::Component::DateTime').new($t)
      !!
      Nil
  }

  method get_dtstamp (:$raw = False) {
    my $t = e_cal_component_get_dtstamp($!ecc);

    $t ??
      ( $raw ?? $t !! ::('Evolution::Calendar::Component::DateTime').new($t)
      !!
      Nil
  }

  method get_dtstart {
    e_cal_component_get_dtstart($!ecc);
  }

  method get_due (:$raw = False) {
    my $t = e_cal_component_get_due($!ecc);

    $t ??
      ( $raw ?? $t !! ::('Evolution::Calendar::Component::DateTime').new($t)
      !!
      Nil
  }

  method get_exdates (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_exdates($!ecc),
      $glist,
      $raw,
      ECalComponentDateTime,
      ::('Evolution::Calendar::Component::DateTime'),
    )
  }

  method get_exrule_properties (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_exrule_properties($!ecc),
      $glist,
      $raw,
      icalproperty,
      ICal::Property
    );
  }

  method get_exrules (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_exrules($!ecc),
      $glist,
      $raw,
      icalrecurrencetype
    );
  }

  method get_geo {
    e_cal_component_get_geo($!ecc);
  }

  method get_icalcomponent (:$raw = False) {
    my $ic = e_cal_component_get_icalcomponent($!ecc);

    $ic ??
      ( $raw ?? $ic !! ICal::Component.new($ic) )
      !!
      Nil;
  }

  method get_id (:$raw = False) {
    my $i = e_cal_component_get_id($!ecc);

    $i ??
      ( $raw ?? $i !! ::('Evolution::Calendar::Component::ID').new($i) )
      !!
      Nil
  }

  method get_last_modified {
    e_cal_component_get_last_modified($!ecc);
  }

  method get_location {
    e_cal_component_get_location($!ecc);
  }

  method get_organizer (:$raw = False) {
    my $o = e_cal_component_get_organizer($!ecc);

    $o ??
      ( $raw ?? $o !! ::('Evolution::Calendar::Component::Organizer').new($o) )
      !!
      Nil
  }

  method get_percent_complete {
    e_cal_component_get_percent_complete($!ecc);
  }

  method get_priority {
    e_cal_component_get_priority($!ecc);
  }

  method get_rdates (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_rdates($!ecc),
      $glist,
      $raw,
      ECalComponentPeriod,
      ::('Evolution::Calendar::Component::Period'),
     )
  }

  method get_recurid {
    my $r = e_cal_component_get_recurid($!ecc);

    $r ??
      ( $raw ?? $r !! ::('Evolution::Calendar::Component::Range').new($r) )
      !!
      Nil;
  }

  method get_recurid_as_string {
    e_cal_component_get_recurid_as_string($!ecc);
  }

  method get_rrule_properties (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_rrule_properties($!ecc),
      $glist,
      $raw,
      icalproperty,
      ICal::Property
    );
  }

  method get_rrules (:$glist = False, :$raw = False) {
    returnGList(
      e_cal_component_get_rrules($!ecc),
      $glist,
      $raw,
      icalrecurrencetype
    )
  }

  method get_sequence {
    e_cal_component_get_sequence($!ecc);
  }

  method get_status {
    icalproperty_statusEnum( e_cal_component_get_status($!ecc) );
  }

  method get_summary (:$raw = False) {
    my $s = e_cal_component_get_summary($!ecc);

    $s ??
      ( $raw ?? $s !! ::('Evolution::Calendar::Component::Text').new($s) )
      !!
      Nil;
  }

  method get_transparency {
    ECalComponentTransparencyEnum( e_cal_component_get_transparency($!ecc) )
  }

  method get_uid {
    e_cal_component_get_uid($!ecc);
  }

  method get_url {
    e_cal_component_get_url($!ecc);
  }

  method get_vtype {
    ECalComponentVTypeEnum( _cal_component_get_vtype($!ecc) );
  }

  method has_alarms {
    so e_cal_component_has_alarms($!ecc);
  }

  method has_attachments {
    so e_cal_component_has_attachments($!ecc);
  }

  method has_attendees {
    so e_cal_component_has_attendees($!ecc);
  }

  method has_exceptions {
    so e_cal_component_has_exceptions($!ecc);
  }

  method has_exdates {
    so e_cal_component_has_exdates($!ecc);
  }

  method has_exrules {
    so e_cal_component_has_exrules($!ecc);
  }

  method has_organizer {
    so e_cal_component_has_organizer($!ecc);
  }

  method has_rdates {
    so e_cal_component_has_rdates($!ecc);
  }

  method has_recurrences {
    so e_cal_component_has_recurrences($!ecc);
  }

  method has_rrules {
    so e_cal_component_has_rrules($!ecc);
  }

  method has_simple_recurrence {
    so e_cal_component_has_simple_recurrence($!ecc);
  }

  method is_instance {
    so e_cal_component_is_instance($!ecc);
  }

  method remove_alarm (Str() $auid) {
    e_cal_component_remove_alarm($!ecc, $auid);
  }

  method remove_all_alarms {
    e_cal_component_remove_all_alarms($!ecc);
  }

  proto method set_attachments (|)
  { * }

  multi method set_attachments (@attachments) {
    samewith( GLib::GSList.new(@attachments, typed => icalattach) );
  }
  multi method set_attachments (GSList() $attachments) {
    e_cal_component_set_attachments($!ecc, $attachments);
  }

  proto method set_attendees (|)
  { * }

  multi method set_attendees (@attendees) {
    samewith(
      GLib::GSList.new( @attendees, typed => ECalComponentAttendee )
    )
  }
  multi method set_attendees (GSList() $attendee_list) {
    e_cal_component_set_attendees($!ecc, $attendee_list);
  }

  method set_categories (Str() $categories) {
    e_cal_component_set_categories($!ecc, $categories);
  }

  proto method set_categories_list (|)
  { * }

  multi method set_categories_list (@category-list) {
    samewith(
      GLib::GSList.new( @category-list, typed => Str );
    )
  }
  multi method set_categories_list (GSList() $categ_list) {
    e_cal_component_set_categories_list($!ecc, $categ_list);
  }

  method set_classification (ECalComponentClassification $classif) {
    my ECalComponentClassification $c = $classif;

    e_cal_component_set_classification($!ecc, $c);
  }

  proto method set_components (|)
  { * }

  multi method set_comments (@comments) {
    samewith(
      GLib::GSList.new(@comments, typed => ECalComponentText)
    )
  }
  multi method set_comments (GSList() $text_list) {
    e_cal_component_set_comments($!ecc, $text_list);
  }

  method set_completed (icaltimetype() $tt) {
    e_cal_component_set_completed($!ecc, $tt);
  }

  proto method set_contracts (|)
  { * }

  multi method set_contacts (@contacts) {
    samwith( GLib::GSList.new(@contacts, typed => ECalComponentText) );
  }
  method set_contacts (GSList() $text_list) {
    e_cal_component_set_contacts($!ecc, $text_list);
  }

  method set_created (icaltimetype() $tt) {
    e_cal_component_set_created($!ecc, $tt);
  }

  proto method set_descriptions (|)
  { * }

  multi method set_descriptions (@list) {
    samewith( GLib::GSList.new(@list, typed => ECalComponentText);
  }
  multi method set_descriptions (GSList() $text_list) {
    e_cal_component_set_descriptions($!ecc, $text_list);
  }

  method set_dtend (ECalComponentDateTime() $dt) {
    e_cal_component_set_dtend($!ecc, $dt);
  }

  method set_dtstamp (icaltimetype() $tt) {
    e_cal_component_set_dtstamp($!ecc, $tt);
  }

  method set_dtstart (ECalComponentDateTime() $dt) {
    e_cal_component_set_dtstart($!ecc, $dt);
  }

  method set_due (ECalComponentDateTime() $dt) {
    e_cal_component_set_due($!ecc, $dt);
  }

  proto method set_exdates (|)
  { * }

  multi method set_exdates (@exdates) {
    samewith( GLib::GSList.new(@exdates, typed => ECalComponentDateTime) );
  }
  multi method set_exdates (GSList() $exdate_list) {
    e_cal_component_set_exdates($!ecc, $exdate_list);
  }

  proto method set_exrules (|)
  { * }

  multi method set_exrules (@recur-list) {
    samewith( GLib::GSList.new(@recur-list, typed => icalrecurrencetype) )
  }
  multi method set_exrules (GSList() $recur_list) {
    e_cal_component_set_exrules($!ecc, $recur_list);
  }

  method set_geo (icalgeotypetype() $geo) {
    e_cal_component_set_geo($!ecc, $geo);
  }

  method set_icalcomponent (icalcomponent() $icalcomp) {
    e_cal_component_set_icalcomponent($!ecc, $icalcomp);
  }

  method set_last_modified (icaltimetype() $tt) {
    e_cal_component_set_last_modified($!ecc, $tt);
  }

  method set_location (Str() $location) {
    e_cal_component_set_location($!ecc, $location);
  }

  method set_new_vtype (Int() $type) {
    my ECalComponentVType $t = $type;

    e_cal_component_set_new_vtype($!ecc, $t);
  }

  method set_organizer (ECalComponentOrganizer() $organizer) {
    e_cal_component_set_organizer($!ecc, $organizer);
  }

  method set_percent_complete (Int() $percent) {
    my gint $p = $percent;

    e_cal_component_set_percent_complete($!ecc, $percent);
  }

  method set_priority (Int() $priority) {
    my gint $p = $priority;

    e_cal_component_set_priority($!ecc, $priority);
  }

  proto method set_rdates (|)
  { * }

  multi method set_rdates (@rdate-list) {
    samewith( GLib::GList.new(@rdate-list, typed => ECalComponentPeriod) );
  }
  multi method set_rdates (GSList() $rdate_list) {
    e_cal_component_set_rdates($!ecc, $rdate_list);
  }

  method set_recurid (ECalComponentRange() $recur_id) {
    e_cal_component_set_recurid($!ecc, $recur_id);
  }

  method set_rrules (GSList() $recur_list) {
    e_cal_component_set_rrules($!ecc, $recur_list);
  }

  method set_sequence (Int() $sequence) {
    my gint $s = $sequence;

    e_cal_component_set_sequence($!ecc, $s);
  }

  method set_status (Int() $status) {
    my icalproperty_status $s = $status;

    e_cal_component_set_status($!ecc, $s);
  }

  method set_summary (ECalComponentText() $summary) {
    e_cal_component_set_summary($!ecc, $summary);
  }

  method set_transparency (Int() $transp) {
    my ECalComponentTransparency $t = $transp;

    e_cal_component_set_transparency($!ecc, $t);
  }

  method set_uid (Str() $uid) {
    e_cal_component_set_uid($!ecc, $uid);
  }

  method set_url (Str() $url) {
    e_cal_component_set_url($!ecc, $url);
  }

  method strip_errors {
    e_cal_component_strip_errors($!ecc);
  }

}
