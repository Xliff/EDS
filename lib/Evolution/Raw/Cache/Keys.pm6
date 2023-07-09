use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Cache::Keys;

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-cache-keys.h

sub e_cache_keys_count_keys_sync (
  ECacheKeys              $self,
  gint64                  $out_n_stored is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_foreach_sync (
  ECacheKeys              $self,
                          &func (
                            ECacheKeys,
                            Str,
                            Str,
                            guint,
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_cache (ECacheKeys $self)
  returns ECache
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_key_column_name (ECacheKeys $self)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_ref_count_sync (
  ECacheKeys              $self,
  Str                     $key,
  guint                   $out_ref_count is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_sync (
  ECacheKeys              $self,
  Str                     $key,
  CArray[Str]             $out_value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_table_name (ECacheKeys $self)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_get_value_column_name (ECacheKeys $self)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_init_table_sync (
  ECacheKeys              $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_new (
  ECache $cache,
  Str    $table_name,
  Str    $key_column_name,
  Str    $value_column_name
)
  returns ECacheKeys
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_put_sync (
  ECacheKeys              $self,
  Str                     $key,
  Str                     $value,
  guint                   $inc_ref_counts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_remove_all_sync (
  ECacheKeys              $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_keys_remove_sync (
  ECacheKeys              $self,
  Str                     $key,
  guint                   $dec_ref_counts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }
