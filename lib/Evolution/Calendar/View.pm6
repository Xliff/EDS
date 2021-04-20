use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::View;

use GIO::DBus::Connection;
use Evolution::Calendar;

use GLib::Roles::Object;

our subset ECalClientViewAncestry is export of Mu
  where ECalClientView | GObject;

class Evolution::Calendar::View {
  also does GLib::Roles::Object;

  has ECalClientView $!ecv;

  submethod BUILD (:$cal-view) {
    self.setECalClientView($cal-view) if $cal-view;
  }

  method setECalClientView (ECalClientViewAncestry $_) {
    my $to-parent;

    $!ecv = do {
      when ECalClientView {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalClientView, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECalClientView
  { $!ecv }

  method new (ECalClientViewAncestry $cal-view, :$ref = True) {
    return Nil unless $cal-view;

    my $o = self.bless( :$cal-view );
    $o.ref if $ref;
    $o;
  }

  method get_connection (:$raw = False) {
    my $c = e_cal_client_view_get_connection($!ecv);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($1) )
      !!
      Nil;
  }

  method get_object_path {
    e_cal_client_view_get_object_path($!ecv);
  }

  method is_running {
    so e_cal_client_view_is_running($!ecv);
  }

  method ref_client (:$raw = False) {
    my $c = e_cal_client_view_ref_client($!ecv);

    # Transfer: full
    $c ??
      ( $raw ?? $c !! Evolution::Calendar.new($c, :!ref) )
      !!
      Nil;
  }

  proto method set_fields_of_interest (|)
  { * }

  multi method set_fields_of_interest (
                            @fields_of_interest,
    CArray[Pointer[GError]] $error              = gerror
  ) {
    samewith(
      GLib::GSList.new(@fields_of_interest),
      $error
    )
  }
  multi method set_fields_of_interest (
    GSList()                $fields_of_interest,
    CArray[Pointer[GError]] $error              = gerror
  ) {
    clear_error;
    e_cal_client_view_set_fields_of_interest(
      $!ecv,
      $fields_of_interest,
      $error
    );
    set_error($error);
  }

  method set_flags (ECalClientViewFlags $flags, CArray[Pointer[GError]] $error) {
    my ECalClientViewFlags $f = $flags;

    clear_error;
    e_cal_client_view_set_flags($!ecv, $f, $error);
    set_error($error);
  }

  method start (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_cal_client_view_start($!ecv, $error);
    set_error($error);
  }

  method stop (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_cal_client_view_stop($!ecv, $error);
    set_error($error);
  }

}
