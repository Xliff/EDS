use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Reminder;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-reminder-watcher.h

sub e_reminder_watcher_describe_data (
  EReminderWatcher $watcher,
  EReminderData    $rd,
  guint32          $flags
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss (
  EReminderWatcher    $watcher,
  EReminderData       $rd,
  GCancellable        $cancellable,
                      &callback (EReminderWatcher, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss_all (
  EReminderWatcher    $watcher,
  GCancellable        $cancellable,
                      &callback (EReminderWatcher, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss_all_finish (
  EReminderWatcher        $watcher,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss_all_sync (
  EReminderWatcher        $watcher,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss_finish (
  EReminderWatcher        $watcher,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dismiss_sync (
  EReminderWatcher        $watcher,
  EReminderData           $rd,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dup_default_zone (EReminderWatcher $watcher)
  returns ICalTimezone
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dup_past (EReminderWatcher $watcher)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_dup_snoozed (EReminderWatcher $watcher)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_get_registry (EReminderWatcher $watcher)
  returns ESourceRegistry
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_get_timers_enabled (EReminderWatcher $watcher)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_new (ESourceRegistry $registry)
  returns EReminderWatcher
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_ref_opened_client (
  EReminderWatcher $watcher,
  Str              $source_uid
)
  returns ECalClient
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_set_default_zone (
  EReminderWatcher $watcher,
  ICalTimezone     $zone
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_set_timers_enabled (
  EReminderWatcher $watcher,
  gboolean         $enabled
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_snooze (
  EReminderWatcher $watcher,
  EReminderData    $rd,
  gint64           $until
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_watcher_timer_elapsed (EReminderWatcher $watcher)
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_copy (EReminderData $rd)
  returns EReminderData
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_free (EReminderData $rd)
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_get_component (EReminderData $rd)
  returns ECalComponent
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_get_instance (EReminderData $rd)
  returns ECalComponentAlarmInstance
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_get_source_uid (EReminderData $rd)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_new (
  Str                        $source_uid,
  ECalComponent              $component,
  ECalComponentAlarmInstance $instance
)
  returns EReminderData
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_set_component (
  EReminderData $rd,
  ECalComponent $component
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_set_instance (
  EReminderData              $rd,
  ECalComponentAlarmInstance $instance
)
  is      native(eds)
  is      export
{ * }

sub e_reminder_data_set_source_uid (
  EReminderData $rd,
  Str           $source_uid
)
  is      native(eds)
  is      export
{ * }
