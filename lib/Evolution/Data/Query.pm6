use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Data::Query;

use GLib::Roles::Implementor;

class Evolution::Data::Query {
  also does GLib::Roles::Implementor;

  has EGDataQuery $!eds-dq is implementor;

  submethod BUILD ( :$e-data-query ) {
    $!eds-dq = $e-data-query if $e-data-query;
  }

  method Evolution::Raw::Definitions::EGDataQuery
  { $!eds-dq }

  multi method new (EGDataQuery $e-data-query) {
    $e-data-query ?? self.bless( :$e-data-query ) !! Nil
  }
  multi method new {
    my $e-data-query = e_gdata_query_new();

    $e-data-query ?? self.bless( :$e-data-query ) !! Nil
  }

  method completed_max is rw is g-accessor is also<completed-max> {
    Proxy.new:
      FETCH => -> $     { self.get_completed_max    },
      STORE => -> $, \v { self.set_completed_max(v) }
  }

  method completed_min is rw is g-accessor is also<completed-min> {
    Proxy.new:
      FETCH => -> $     { self.get_completed_min    },
      STORE => -> $, \v { self.set_completed_min(v) }
  }

  method due_max is rw is g-accessor is also<due-max> {
    Proxy.new:
      FETCH => -> $     { self.get_due_max    },
      STORE => -> $, \v { self.set_due_max(v) }
  }

  method due_min is rw is g-accessor is also<due-min> {
    Proxy.new:
      FETCH => -> $     { self.get_due_min    },
      STORE => -> $, \v { self.set_due_min(v) }
  }

  method max_results is rw is g-accessor is also<max-results> {
    Proxy.new:
      FETCH => -> $     { self.get_max_results    },
      STORE => -> $, \v { self.set_max_results(v) }
  }

  method show_completed is rw is g-accessor is also<show-completed> {
    Proxy.new:
      FETCH => -> $     { self.get_show_completed    },
      STORE => -> $, \v { self.set_show_completed(v) }
  }

  method show_deleted is rw is g-accessor is also<show-deleted> {
    Proxy.new:
      FETCH => -> $     { self.get_show_deleted    },
      STORE => -> $, \v { self.set_show_deleted(v) }
  }

  method show_hidden is rw is g-accessor is also<show-hidden> {
    Proxy.new:
      FETCH => -> $     { self.get_show_hidden    },
      STORE => -> $, \v { self.set_show_hidden(v) }
  }

  method updated_min is rw is g-accessor is also<updated-min> {
    Proxy.new:
      FETCH => -> $     { self.get_updated_min    },
      STORE => -> $, \v { self.set_updated_min(v) }
  }

  method get_completed_max (Int() $out_exists) is also<get-completed-max> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_completed_max($!eds-dq, $o);
  }

  method get_completed_min (Int() $out_exists) is also<get-completed-min> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_completed_min($!eds-dq, $o);
  }

  method get_due_max (Int() $out_exists) is also<get-due-max> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_due_max($!eds-dq, $o);
  }

  method get_due_min (Int() $out_exists) is also<get-due-min> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_due_min($!eds-dq, $o);
  }

  method get_max_results (Int() $out_exists) is also<get-max-results> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_max_results($!eds-dq, $o);
  }

  method get_show_completed (Int() $out_exists) is also<get-show-completed> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_show_completed($!eds-dq, $o);
  }

  method get_show_deleted (Int() $out_exists) is also<get-show-deleted> {
    my gboolean $o = $out_exists.so.Int;

    e_gdata_query_get_show_deleted($!eds-dq, $o);
  }

  method get_show_hidden (Int() $out_exists) is also<get-show-hidden> {
    my gboolean $o = $out_exists.so.In;

    e_gdata_query_get_show_hidden($!eds-dq, $out_exists);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_gdata_query_get_type, $n, $t );
  }

  method get_updated_min (Int() $out_exists) is also<get-updated-min> {
    my gboolean $o = $out_exists.so.In;

    e_gdata_query_get_updated_min($!eds-dq, $o);
  }

  method ref {
    e_gdata_query_ref($!eds-dq);
    self;
  }

  method set_completed_max (Int() $value) is also<set-completed-max> {
    my gint64 $v = $value;

    e_gdata_query_set_completed_max($!eds-dq, $v);
  }

  method set_completed_min (Int() $value) is also<set-completed-min> {
    my gint64 $v = $value;

    e_gdata_query_set_completed_min($!eds-dq, $v);
  }

  method set_due_max (Int() $value) is also<set-due-max> {
    my gint64 $v = $value;

    e_gdata_query_set_due_max($!eds-dq, $v);
  }

  method set_due_min (Int() $value) is also<set-due-min> {
    my gint64 $v = $value;

    e_gdata_query_set_due_min($!eds-dq, $v);
  }

  method set_max_results (Int() $value) is also<set-max-results> {
    my gint $v = $value;

    e_gdata_query_set_max_results($!eds-dq, $v);
  }

  method set_show_completed (Int() $value) is also<set-show-completed> {
    my gboolean $v = $value.so.Int;

    e_gdata_query_set_show_completed($!eds-dq, $v);
  }

  method set_show_deleted (Int() $value) is also<set-show-deleted> {
    my gboolean $v = $value.so.Int;

    e_gdata_query_set_show_deleted($!eds-dq, $v);
  }

  method set_show_hidden (Int() $value) is also<set-show-hidden> {
    my gboolean $v = $value.so.Int;

    e_gdata_query_set_show_hidden($!eds-dq, $v);
  }

  method set_updated_min (Int() $value) is also<set-updated-min> {
    my gint64 $v = $value;

    e_gdata_query_set_updated_min($!eds-dq, $v);
  }

  method to_string is also<to-string> {
    e_gdata_query_to_string($!eds-dq);
  }

  method unref {
    e_gdata_query_unref($!eds-dq);
  }

}
