use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Refresh;

use Evolution::Source::Extension;

our subset ESourceRefreshAncestry is export of Mu
  where ESourceRefresh | ESourceExtensionAncestry;

class Evolution::Source::Refresh is Evolution::Source::Extension {
  has ESourceRefresh $!esr;

  submethod BUILD (:$refresh) {
    self.setESourceRefresh($refresh) if $refresh;
  }

  method setESourceRefresh (ESourceRefreshAncestry $_) {
    my $to-parent;

    $!esr = do {
      when ESourceRefresh {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceRefresh, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceRefresh
  { $!esr }

  method new (
    ESourceRefreshAncestry $refresh,
                           :$ref   = True
  ) {
    return Nil unless $refresh;

    my $o = self.bless( :$refresh );
    $o.ref if $ref;
    $o;
  }

  method enabled is rw {
    Proxy.new:
      FETCH => -> $     { self.get_enabled    },
      STORE => -> $, \v { self.set_enabled(v) }
  }

  method interval_minutes is rw {
    Proxy.new:
      FETCH => -> $     { self.get_interval_minutes    },
      STORE => -> $, \v { self.set_interval_minutes(v) }
  }

  proto method add_timeout (|)
  { * }

  multi method add_timeout (
                   &callback,
    gpointer       $user_data = gpointer,
                   &notify    = Callable,
    GMainContext() :$context  = GMainContext
  ) {
    samewith(
      $context,
      &callback,
      $user_data,
      &notify
    );
  }
  multi method add_timeout (
    GMainContext() $context,
                   &callback,
    gpointer       $user_data = gpointer,
                   &notify    = Callable
  ) {
    e_source_refresh_add_timeout(
      $!esr,
      $context,
      &callback,
      $user_data,
      &notify
    );
  }

  multi method force_timeout (Evolution::Source::Refresh:D: ) {
    Evolution::Source::Refresh.force_timeout(self.ESource);
  }
  multi method force_timeout (
    Evolution::Source::Refresh:U:
    ESource()                     $source
  ) {
    e_source_refresh_force_timeout($source);
  }

  method get_enabled {
    so e_source_refresh_get_enabled($!esr);
  }

  method get_interval_minutes {
    e_source_refresh_get_interval_minutes($!esr);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_refresh_get_type,
      $n,
      $t
    );
  }

  multi method remove_timeout (
    Evolution::Source::Refresh:D:
    Int()     $refresh_timeout_id
  ) {
    Evolution::Source::Refresh.remove_timeout(
      self.ESource,
      $refresh_timeout_id
    );
  }
  multi method remove_timeout (
    Evolution::Source::Refresh:U:
    ESource() $source,
    Int()     $refresh_timeout_id
  ) {
    my guint $r = $refresh_timeout_id;

    e_source_refresh_remove_timeout($source, $r);
  }

  # $user_data does not subscribe to the default, here.
  multi method remove_timeouts_by_data (
    Evolution::Source::Refresh:D:
    ESource()                     $source,
    gpointer                      $user_data
  ) {
    Evolution::Source::Refresh.remove_timeouts_by_data($source, $user_data);
  }
  multi method remove_timeouts_by_data (
    Evolution::Source::Refresh:U:
    ESource()                     $source,
    gpointer                      $user_data
  ) {
    e_source_refresh_remove_timeouts_by_data($!esr, $source, $user_data);
  }

  method set_enabled (Int() $enabled) {
    my gboolean $e = $enabled.so.Int;

    e_source_refresh_set_enabled($!esr, $e);
  }

  method set_interval_minutes (Int() $interval_minutes) {
    my guint $i = $interval_minutes.so.Int;

    e_source_refresh_set_interval_minutes($!esr, $i);
  }

}
