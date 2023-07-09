use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Cache::Keys;

use Evolution::Cache;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ECacheKeysAncestry is export of Mu
  where ECacheKeys | GObject;

class Evolution::Cache::Keys {
  also does GLib::Roles::Object;

  has ECacheKeys $!eds-ck is implementor;

  submethod BUILD ( :$e-cache-keys ) {
    self.setECacheKeys($e-cache-keys) if $e-cache-keys
  }

  method setECacheKeys (ECacheKeysAncestry $_) {
    my $to-parent;

    $!eds-ck = do {
      when ECacheKeys {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECacheKeys, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECacheKeys
    is also<ECacheKeys>
  { $!eds-ck }

  multi method new (
     $e-cache-keys where * ~~ ECacheKeysAncestry,

    :$ref = True
  ) {
    return unless $e-cache-keys;

    my $o = self.bless( :$e-cache-keys );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    ECache() $cache,
    Str()    $table_name,
    Str()    $key_column_name,
    Str()    $value_column_name
  ) {
    my $e-cache-keys = e_cache_keys_new(
      $cache,
      $table_name,
      $key_column_name,
      $value_column_name
    );

    $e-cache-keys ?? self.bless( :$e-cache-keys ) !! Nil;
  }

  # Type: EvolutionCache
  method cache ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Evolution::Cache.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cache', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Evolution::Cache.getTypePair
        );
      },
      STORE => -> $, ECache() $val is copy {
        $gv.object = $val;
        self.prop_set('cache', $gv);
      }
    );
  }

  # Type: string
  method key-column-name is rw  is g-property is also<key_column_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('key-column-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('key-column-name', $gv);
      }
    );
  }

  # Type: string
  method table-name is rw  is g-property is also<table_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('table-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('table-name', $gv);
      }
    );
  }

  # Type: string
  method value-column-name is rw  is g-property is also<value_column_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value-column-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('value-column-name', $gv);
      }
    );
  }

  # Is originally:
  # ECacheKeys *self, gpoiner --> void
  method changed {
    self.connect($!eds-ck, 'changed');
  }

  proto method count_keys_sync (|)
    is also<count-keys-sync>
  { * }

  multi method count_keys_sync (
    CArray[Pointer[GError]] $error                 = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($, $cancellable, $error, :all);
  }
  multi method count_keys_sync (
                             $out_n_stored is rw,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error                = gerror,
                            :$all                  = False
  ) {
    my gint64 $o = 0;

    clear_error;
    my $rv = so e_cache_keys_count_keys_sync(
      $!eds-ck,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $out_n_stored = $o;

    $all.not ?? $rv !! $o;
  }

  proto method foreach_sync (|)
    is also<foreach-sync>
  { * }

  multi method foreach_sync (
                             &func,
    CArray[Pointer[GError]]  $error                = gerror,
    gpointer                :$user_data            = gpointer,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith(&func, $user_data, $cancellable, $error);
  }
  multi method foreach_sync (
                            &func,
    gpointer                $user_data,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    e_cache_keys_foreach_sync(
      $!eds-ck,
      &func,
      $user_data,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method get_cache ( :$raw = False ) is also<get-cache> {
    propReturnObject(
      e_cache_keys_get_cache($!eds-ck),
      $raw,
      |Evolution::Cache.getTypePair
    );
  }

  method get_key_column_name is also<get-key-column-name> {
    e_cache_keys_get_key_column_name($!eds-ck);
  }

  proto method get_ref_count_sync (|)
    is also<get-ref-count-sync>
  { * }

  multi method get_ref_count_sync (
    Str()                    $key,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable            :cancel(:$cancellable) = GCancellable
  ) {
    samewith($key, $, $cancellable, $error, :all);
  }
  multi method get_ref_count_sync (
    Str                      $key,
                             $out_ref_count is rw,
    GCancellable             $cancellable,
    CArray[Pointer[GError]]  $error                 = gerror,
                            :$all                   = False
  ) {
    my guint $o = 0;

    clear_error;
    my $rv = e_cache_keys_get_ref_count_sync(
      $!eds-ck,
      $key,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $out_ref_count = $o;

    $all.not ?? $rv !! $o
  }

  proto method get_sync (|)
    is also<get-sync>
  { * }

  multi method get_sync (
    Str()                    $key,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($key, newCArray(Str), $cancellable, $error, :all);
  }
  multi method get_sync (
    Str                      $key,
    CArray[Str]              $out_value,
    GCancellable             $cancellable,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$all          = False
  ) {
    clear_error;
    my $rv = so e_cache_keys_get_sync(
      $!eds-ck,
      $key,
      $out_value,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ppr($out_value)
  }

  method get_table_name is also<get-table-name> {
    e_cache_keys_get_table_name($!eds-ck);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cache_keys_get_type, $n, $t );
  }

  method get_value_column_name is also<get-value-column-name> {
    e_cache_keys_get_value_column_name($!eds-ck);
  }

  proto method init_table_sync (|)
    is also<init-table-sync>
  { * }

  multi method init_table_sync (
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method init_table_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error
    my $rv = so e_cache_keys_init_table_sync($!eds-ck, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method put_sync (|)
    is also<put-sync>
  { * }

  multi method put_sync (
    Str()                   $key,
    Str()                   $value,
    CArray[Pointer[GError]] $error                       = gerror,
    Int()                   :inc(:ref(:$inc_ref_counts)) = True,
    GCancellable()          :cancel(:$cancellable)       = GCancellable
  ) {
    samewith($key, $value, $inc_ref_counts, $cancellable, $error);
  }
  multi method put_sync (
    Str()                   $key,
    Str()                   $value,
    Int()                   $inc_ref_counts,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my guint $i = $inc_ref_counts.so.Int;

    clear_error;
    my $rv = so e_cache_keys_put_sync(
      $!eds-ck,
      $key,
      $value,
      $i,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_all_sync (|)
    is also<remove-all-sync>
  { * }

  multi method remove_all_sync (
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method remove_all_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cache_keys_remove_all_sync($!eds-ck, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method remove_sync (|)
    is also<remove-sync>
  { * }

  multi method remove_sync (
    Str()                    $key,
    CArray[Pointer[GError]]  $error                        = gerror,
    Int()                   :dec(:unref(:$dec_ref_counts)) = True,
    GCancellable()          :cancel(:$cancellable)         = GCancellable
  ) {
    samewith($key, $dec_ref_counts, $cancellable, $error);
  }
  multi method remove_sync (
    Str()                   $key,
    Int()                   $dec_ref_counts,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my guint $d = $dec_ref_counts;

    clear_error;
    my $rv = so e_cache_keys_remove_sync(
      $!eds-ck,
      $key,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}
