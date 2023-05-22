use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::UI::Reminders;

use GTK::Widget;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ERemindersWidgetAncestry is export of Mu
  where ERemindersWidget | GObject;

class Evolution::UI::Reminders {
  also does GLib::Roles::Object;

  has ERemindersWidget $!eds-rw is implementor;

  submethod BUILD ( :$e-reminder-widget ) {
    self.setERemindersWidget($e-reminder-widget) if $e-reminder-widget
  }

  method setERemindersWidget (ERemindersWidgetAncestry $_) {
    my $to-parent;

    $!eds-rw = do {
      when ERemindersWidget {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ERemindersWidget, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ERemindersWidget
    is also<ERemindersWidget>
  { $!eds-rw }

  multi method new (
    $e-reminder-widget where * ~~ ERemindersWidgetAncestry,

    :$ref = True
  ) {
    return unless $e-reminder-widget;

    my $o = self.bless( :$e-reminder-widget );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $e-reminders-widget = e_reminders_widget_new();

    $e-reminders-widget ?? self.bless( :$e-reminders-widget ) !! Nil;
  }

  method get_paned (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-paned>
  {
    returnProperWidget(
      e_reminders_widget_get_paned($!eds-rw),
      $raw,
      $proper
    );
  }

  method get_settings ( :$raw = False ) is also<get-settings> {
    propReturnObject(
      e_reminders_widget_get_settings($!eds-rw),
      $raw,
      |GIO::Settings.getTypePair
    );
  }

  method get_tree_view (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-tree-view>
  {
    returnProperWidget(
      e_reminders_widget_get_tree_view($!eds-rw),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_reminders_widget_get_type, $n, $t );
  }

  method get_watcher ( :$raw = False ) is also<get-watcher> {
    propReturnObject(
      e_reminders_widget_get_watcher($!eds-rw),
      $raw,
      |Evolution::Reminder::Watcher.getTypePair
    );
  }

  method is_empty is also<is-empty> {
    so e_reminders_widget_is_empty($!eds-rw);
  }

  method report_error (Str() $prefix, GError() $error) is also<report-error> {
    e_reminders_widget_report_error($!eds-rw, $prefix, $error);
  }

}
