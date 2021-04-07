use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::Raw::Definitions;
use ICal::Raw::Enums;
use ICal::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component;

### /usr/include/evolution-data-server/libecal/e-cal-component.h

sub e_cal_component_abort_sequence (ECalComponent $comp)
  is native(eds)
  is export
{ * }

sub e_cal_component_add_alarm (ECalComponent $comp, ECalComponentAlarm $alarm)
  is native(eds)
  is export
{ * }

sub e_cal_component_clone (ECalComponent $comp)
  returns ECalComponent
  is native(eds)
  is export
{ * }

sub e_cal_component_commit_sequence (ECalComponent $comp)
  is native(eds)
  is export
{ * }

sub e_cal_component_get_alarm (ECalComponent $comp, Str $auid)
  returns ECalComponentAlarm
  is native(eds)
  is export
{ * }

sub e_cal_component_get_alarm_uids (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_all_alarms (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_as_string (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_attachments (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_attendees (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_categories (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_categories_list (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_classification (ECalComponent $comp)
  returns ECalComponentClassification
  is native(eds)
  is export
{ * }

sub e_cal_component_get_comments (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_completed (ECalComponent $comp)
  returns icaltimetype
  is native(eds)
  is export
{ * }

sub e_cal_component_get_contacts (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_created (ECalComponent $comp)
  returns icaltimetype
  is native(eds)
  is export
{ * }

sub e_cal_component_get_descriptions (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_dtend (ECalComponent $comp)
  returns ECalComponentDateTime
  is native(eds)
  is export
{ * }

sub e_cal_component_get_dtstamp (ECalComponent $comp)
  returns icaltimetype
  is native(eds)
  is export
{ * }

sub e_cal_component_get_dtstart (ECalComponent $comp)
  returns ECalComponentDateTime
  is native(eds)
  is export
{ * }

sub e_cal_component_get_due (ECalComponent $comp)
  returns ECalComponentDateTime
  is native(eds)
  is export
{ * }

sub e_cal_component_get_exdates (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_exrule_properties (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_exrules (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_geo (ECalComponent $comp)
  returns icalgeotype
  is native(eds)
  is export
{ * }

sub e_cal_component_get_icalcomponent (ECalComponent $comp)
  returns icalcomponent
  is native(eds)
  is export
{ * }

sub e_cal_component_get_id (ECalComponent $comp)
  returns ECalComponentId
  is native(eds)
  is export
{ * }

sub e_cal_component_get_last_modified (ECalComponent $comp)
  returns icaltimetype
  is native(eds)
  is export
{ * }

sub e_cal_component_get_location (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_organizer (ECalComponent $comp)
  returns ECalComponentOrganizer
  is native(eds)
  is export
{ * }

sub e_cal_component_get_percent_complete (ECalComponent $comp)
  returns gint
  is native(eds)
  is export
{ * }

sub e_cal_component_get_priority (ECalComponent $comp)
  returns gint
  is native(eds)
  is export
{ * }

sub e_cal_component_get_rdates (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_recurid (ECalComponent $comp)
  returns ECalComponentRange
  is native(eds)
  is export
{ * }

sub e_cal_component_get_recurid_as_string (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_rrule_properties (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_rrules (ECalComponent $comp)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_cal_component_get_sequence (ECalComponent $comp)
  returns gint
  is native(eds)
  is export
{ * }

sub e_cal_component_get_status (ECalComponent $comp)
  returns icalproperty_status
  is native(eds)
  is export
{ * }

sub e_cal_component_get_summary (ECalComponent $comp)
  returns ECalComponentText
  is native(eds)
  is export
{ * }

sub e_cal_component_get_transparency (ECalComponent $comp)
  returns ECalComponentTransparency
  is native(eds)
  is export
{ * }

sub e_cal_component_get_uid (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_url (ECalComponent $comp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_cal_component_get_vtype (ECalComponent $comp)
  returns ECalComponentVType
  is native(eds)
  is export
{ * }

sub e_cal_component_has_alarms (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_attachments (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_attendees (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_exceptions (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_exdates (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_exrules (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_organizer (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_rdates (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_recurrences (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_rrules (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_has_simple_recurrence (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_is_instance (ECalComponent $comp)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_new ()
  returns ECalComponent
  is native(eds)
  is export
{ * }

sub e_cal_component_new_from_icalcomponent (icalcomponent $icalcomp)
  returns ECalComponent
  is native(eds)
  is export
{ * }

sub e_cal_component_new_from_string (Str $calobj)
  returns ECalComponent
  is native(eds)
  is export
{ * }

sub e_cal_component_new_vtype (ECalComponentVType $vtype)
  returns ECalComponent
  is native(eds)
  is export
{ * }

sub e_cal_component_remove_alarm (ECalComponent $comp, Str $auid)
  is native(eds)
  is export
{ * }

sub e_cal_component_remove_all_alarms (ECalComponent $comp)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_attachments (ECalComponent $comp, GSList $attachments)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_attendees (ECalComponent $comp, GSList $attendee_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_categories (ECalComponent $comp, Str $categories)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_categories_list (
  ECalComponent $comp,
  GSList        $categ_list
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_classification (
  ECalComponent               $comp,
  ECalComponentClassification $classif
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_comments (ECalComponent $comp, GSList $text_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_completed (ECalComponent $comp, icaltimetype $tt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_contacts (ECalComponent $comp, GSList $text_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_created (ECalComponent $comp, icaltimetype $tt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_descriptions (ECalComponent $comp, GSList $text_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_dtend (ECalComponent $comp, ECalComponentDateTime $dt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_dtstamp (ECalComponent $comp, icaltimetype $tt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_dtstart (
  ECalComponent         $comp,
  ECalComponentDateTime $dt
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_due (ECalComponent $comp, ECalComponentDateTime $dt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_exdates (ECalComponent $comp, GSList $exdate_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_exrules (ECalComponent $comp, GSList $recur_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_geo (ECalComponent $comp, icalgeotype $geo)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_icalcomponent (
  ECalComponent $comp,
  icalcomponent $icalcomp
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_cal_component_set_last_modified (ECalComponent $comp, icaltimetype $tt)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_location (ECalComponent $comp, Str $location)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_new_vtype (
  ECalComponent      $comp,
  ECalComponentVType $type
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_organizer (
  ECalComponent          $comp,
  ECalComponentOrganizer $organizer
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_percent_complete (ECalComponent $comp, gint $percent)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_priority (ECalComponent $comp, gint $priority)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_rdates (ECalComponent $comp, GSList $rdate_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_recurid (
  ECalComponent      $comp,
  ECalComponentRange $recur_id
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_rrules (ECalComponent $comp, GSList $recur_list)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_sequence (ECalComponent $comp, gint $sequence)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_status (
  ECalComponent $comp,
  icalproperty_status $status
  )
  is native(eds)
  is export
{ * }

sub e_cal_component_set_summary (
  ECalComponent $comp,
  ECalComponentText $summary
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_transparency (
  ECalComponent             $comp,
  ECalComponentTransparency $transp
)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_uid (ECalComponent $comp, Str $uid)
  is native(eds)
  is export
{ * }

sub e_cal_component_set_url (ECalComponent $comp, Str $url)
  is native(eds)
  is export
{ * }

sub e_cal_component_strip_errors (ECalComponent $comp)
  is native(eds)
  is export
{ * }
