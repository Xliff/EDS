use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::DataCal::View;

use GLib::Roles::Object;

our subset EDataCalViewAncestry is export of Mu
  where EDataCalView | GObject;

class Evolution::DataCal::View {
  also does GLib::Roles::Object;

  has EDataCalView $!edcv;

  submethod BUILD (:$cal-view) {
    self.setEDataCalView($cal-view) if $cal-view;
  }

  method setEDataCalView (EDataCalViewAncestry $_) {
    my $to-parent;

    $!edcv = do {
      when EDataCalView {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataCalView, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EDataCalView
  { $!edcv }

  multi method new (EDataCalViewAncestry $cal-view, :$ref = True) {
    return Nil unless $cal-view;

    my $o = self.bless( :$cal-view );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    ECalBackend()           $backend,
    ECalBackendSExp()       $sexp,
    GDBusConnection()       $connection,
    Str()                   $object_path,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $cal-view = e_data_cal_view_new(
      $backend,
      $sexp,
      $connection,
      $object_path,
      $error
    );
    set_error($error);

    $cal-view ?? self.bless( :$cal-view ) !! Nil;
  }

  proto method component_matches (|)
  { * }

  multi method component_matches (
    Evolution::DataCal::View:D:

    ECalComponent() $component
  ) {
    Evolution::DataCal::View.component_matches($!edcv, $component);
  }
  multi method component_matches (
    Evolution::DataCal::View:U:

    ECalComponent() $c1,
    ECalComponent() $c2
  ) {
    e_data_cal_view_component_matches($c1, $c2);
  }

  method get_backend (:$raw = False) {
    my $b = e_data_cal_view_get_backend($!edcv);

    $b ??
      ( $raw ?? $b !! Evolution::Calendar::Backend.new($b) )
      !!
      Nil;
  }

  method get_component_string (ECalComponent() $component) {
    e_data_cal_view_get_component_string($!edcv, $component);
  }

  method get_connection (:$raw = False) {
    my $c = e_data_cal_view_get_connection($!edcv);

    # Transfer: none (from C file)
    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_fields_of_interest (:$raw = False) {
    my $h = e_data_cal_view_get_fields_of_interest($!edcv);

    # Transfer: none (from C file)
    $h ??
      ( $raw ?? $h !! GLib::HashTable.new($h) )
      !!
      Nil
  }

  method get_flags {
    ECalClientViewFlagsEnum( e_data_cal_view_get_flags($!edcv) );
  }

  method get_object_path {
    e_data_cal_view_get_object_path($!edcv);
  }

  method get_sexp (:$raw = False) {
    my $s = e_data_cal_view_get_sexp($!edcv);

    # Transfer: none (from C file)
    $s ??
      ( $raw ?? $s !! Evolution::Backend::SExp.new($s) )
      !!
      Nil
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_cal_view_get_type, $n, $t );
  }

  method is_completed {
    so e_data_cal_view_is_completed($!edcv);
  }

  method is_started {
    so e_data_cal_view_is_started($!edcv);
  }

  method is_stopped {
    so e_data_cal_view_is_stopped($!edcv);
  }

  method notify_complete (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_data_cal_view_notify_complete($!edcv, $error);
    set_error($error);
  }

  proto method notify_components_added (|)
  { * }

  multi method notify_components_added (@components) {
    samewith( GLib::GSList.new( @components, typed => ECalComponent ) );
  }
  multi method notify_components_added (GSList() $ecalcomponents) {
    e_data_cal_view_notify_components_added($!edcv, $ecalcomponents);
  }

  method notify_components_added_1 (ECalComponent() $component) {
    e_data_cal_view_notify_components_added_1($!edcv, $component);
  }

  proto method notify_components_modified (|)
  { * }

  multi method notify_components_modified (@components) {
    samewith( GLib::GSList.new( @components, typed => ECalComponent ) );
  }
  multi method notify_components_modified (GSList() $ecalcomponents) {
    e_data_cal_view_notify_components_modified($!edcv, $ecalcomponents);
  }

  method notify_components_modified_1 (ECalComponent() $component) {
    e_data_cal_view_notify_components_modified_1($!edcv, $component);
  }


  proto method notify_objects_removed (|)
  { * }

  multi method notify_objects_removed (@ids) {
    samewith( GLib::GSList.new(@ids, typed => ECalComponentId) );
  }
  multi method notify_objects_removed (GSList() $ids) {
    e_data_cal_view_notify_objects_removed($!edcv, $ids);
  }

  method notify_objects_removed_1 (ECalComponentId() $id) {
    e_data_cal_view_notify_objects_removed_1($!edcv, $id);
  }

  method notify_progress (Int() $percent, Str() $message) {
    my gint $p = $percent;

    e_data_cal_view_notify_progress($!edcv, $p, $message);
  }

  method object_matches (Str() $object) {
    so e_data_cal_view_object_matches($!edcv, $object);
  }

  method ref_backend (:$raw = False) {
    my $ecb = e_data_cal_view_ref_backend($!edcv);

    # Late binding to prevent circularity
    # Transfer: full (from .c file)
    $ecb ??
      ( $raw ?? $ecb !! ::('Evolution::Backend::Calendar').new($ecb, :!ref) )
      !!
      Nil
  }

}
