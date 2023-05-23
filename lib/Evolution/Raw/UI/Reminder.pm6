use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::UI::Reminders;

### /usr/src/evolution-data-server-3.48.0/src/libedataserverui/e-reminders-widget.h

sub e_reminders_widget_get_paned (ERemindersWidget $reminders)
  returns GtkPaned
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_get_settings (ERemindersWidget $reminders)
  returns GSettings
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_get_tree_view (ERemindersWidget $reminders)
  returns GtkTreeView
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_get_watcher (ERemindersWidget $reminders)
  returns EReminderWatcher
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_is_empty (ERemindersWidget $reminders)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_new (EReminderWatcher $watcher)
  returns ERemindersWidget
  is      native(eds)
  is      export
{ * }

sub e_reminders_widget_report_error (
  ERemindersWidget $reminders,
  Str              $prefix,
  Pointer[GError]  $error
)
  is      native(eds)
  is      export
{ * }
