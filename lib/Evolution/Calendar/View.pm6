use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::View;

use GIO::DBus::Connection;
use Evolution::Calendar;

use GLib::Roles::Object;
use Evolution::Roles::Signals::Calendar::View;

our subset ECalClientViewAncestry is export of Mu
  where ECalClientView | GObject;

class Evolution::Calendar::View {
  also does GLib::Roles::Object;
  also does Evolution::Roles::Signals::Calendar::View;

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
    is also<ECalClientView>
  { $!ecv }

  method new (ECalClientViewAncestry $cal-view, :$ref = True) {
    return Nil unless $cal-view;

    my $o = self.bless( :$cal-view );
    $o.ref if $ref;
    $o;
  }

  # Is originally:
  # ECalClientView, GError, gpointer --> void
  method complete {
    self.connect-complete($!ecv.p);
  }

  # Is originally:
  # ECalClientView, gpointer, gpointer --> void
  method objects-added {
    self.connect-objects($!ecv.p, 'objects-added');
  }

  # Is originally:
  # ECalClientView, gpointer, gpointer --> void
  method objects-modified {
    self.connect-objects($!ecv.p, 'objects-modified');
  }

  # Is originally:
  # ECalClientView, gpointer, gpointer --> void
  method objects-removed {
    self.connect-objects($!ecv.p, 'objects-removed');
  }

  # Is originally:
  # ECalClientView, guint, gchar, gpointer --> void
  method progress {
    self.connect-progress($!ecv);
  }

  method get_connection (:$raw = False) is also<get-connection> {
    my $c = e_cal_client_view_get_connection($!ecv);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($1) )
      !!
      Nil;
  }

  method get_object_path is also<get-object-path> {
    e_cal_client_view_get_object_path($!ecv);
  }

  method is_running is also<is-running> {
    so e_cal_client_view_is_running($!ecv);
  }

  method ref_client (:$raw = False) is also<ref-client> {
    my $c = e_cal_client_view_ref_client($!ecv);

    # Transfer: full
    $c ??
      ( $raw ?? $c !! Evolution::Calendar.new($c, :!ref) )
      !!
      Nil;
  }

  proto method set_fields_of_interest (|)
      is also<set-fields-of-interest>
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

  method reset_fields_of_interest is also<reset-fields-of-interest> {
    self.set_fields_of_interest(GSList);
  }

  method set_flags (
    ECalClientViewFlags     $flags,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-flags>
  {
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
