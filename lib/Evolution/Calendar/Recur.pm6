use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Recur;

use GLib::Roles::StaticClass;

class Evolution::Calendar::Recur {
  also does GLib::Roles::StaticClass;

  method describe_recurrence (
    ICalComponent() $icalcomp,
    Int()           $week_start_day,
    Int()           $flags
  ) {
    my GDateWeekday $w = $week_start_day;
    my guint32      $f = $flags;

    e_cal_recur_describe_recurrence($icalcomp, $w, $f);
  }

  method describe_recurrence_ex (
    ICalComponent() $icalcomp,
    Int()           $week_start_day,
    Int()           $flags,
                    &datetime_fmt_func
  ) {
    my GDateWeekday $w = $week_start_day;
    my guint32      $f = $flags;

    e_cal_recur_describe_recurrence_ex($icalcomp, $w, $f, &datetime_fmt_func);
  }

  proto method ensure_end_dates (|)
  { * }

  multi method ensure_end_dates (
    ECalComponent()          $comp,
                             &tz_cb,
    CArray[Pointer[GError]]  $error       = gerror,
    Int()                   :$refresh     = True,
    gpointer                :$tz_cb_data  = gpointer,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith(
      $comp,
      $refresh,
      &tz_cb,
      $tz_cb_data,
      $cancellable,
      $error
    );
  }
  multi method ensure_end_dates (
    ECalComponent()         $comp,
    Int()                   $refresh,
                            &tz_cb,
    gpointer                $tz_cb_data  = gpointer,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my gboolean $r = $refresh.so.Int;

    clear_error;
    my $rv = so e_cal_recur_ensure_end_dates(
      $comp,
      $r,
      &tz_cb,
      $tz_cb_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method generate_instances_sync (
    ICalComponent()         $icalcomp,
    ICalTime()              $interval_start,
    ICalTime()              $interval_end,
                            &callback,
    gpointer                $callback_user_data,
                            &get_tz_callback,
    gpointer                $get_tz_callback_user_data,
    ICalTimezone()          $default_timezone,
    GCancellable()          $cancellable                = GCancellable,
    CArray[Pointer[GError]] $error                      = gerror
  ) {
    clear_error
    my $rv = so e_cal_recur_generate_instances_sync(
      $icalcomp,
      $interval_start,
      $interval_end,
      &callback,
      $callback_user_data,
      &get_tz_callback,
      $get_tz_callback_user_data,
      $default_timezone,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_localized_nth (Int() $n) {
    my gint $nn = $n;

    e_cal_recur_get_localized_nth($nn);
  }

  method obtain_enddate (
    ICalRecurrence() $recur,
    ICalProperty()   $prop,
    ICalTimezone()   $zone,
    Int()            $convert_end_date
  ) {
    my gboolean $c = $convert_end_date.so.Int;

    e_cal_recur_obtain_enddate($recur, $prop, $zone, $c);
  }
}
