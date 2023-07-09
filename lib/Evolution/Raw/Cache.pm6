use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Cache;

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-cache.h

sub e_cache_change_revision (ECache $cache)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_clear_offline_changes (
  ECache                  $cache,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_info_copy (ECacheColumnInfo $info)
  returns ECacheColumnInfo
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_info_free (ECacheColumnInfo $info)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_info_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_info_new (
  Str $name,
  Str $type,
  Str $index_name
)
  returns ECacheColumnInfo
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_contains (
  ECacheColumnValues $other_columns,
  Str                $name
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_copy (ECacheColumnValues $other_columns)
  returns ECacheColumnValues
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_free (ECacheColumnValues $other_columns)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_get_size (ECacheColumnValues $other_columns)
  returns guint
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_init_iter (
  ECacheColumnValues $other_columns,
  GHashTableIter     $iter
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_lookup (
  ECacheColumnValues $other_columns,
  Str                $name
)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_new
  returns ECacheColumnValues
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_put (
  ECacheColumnValues $other_columns,
  Str                $name,
  Str                $value
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_remove (
  ECacheColumnValues $other_columns,
  Str                $name
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_remove_all (ECacheColumnValues $other_columns)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_take (
  ECacheColumnValues $other_columns,
  Str                $name,
  Str                $value
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_column_values_take_value (
  ECacheColumnValues $other_columns,
  Str                $name,
  Str                $value
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_contains (
  ECache            $cache,
  Str               $uid,
  ECacheDeletedFlag $deleted_flag
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_copy_missing_to_column_values (
  ECache             $cache,
  gint               $ncols,
  CArray[Str]        $column_names,
  CArray[Str]        $column_values,
  ECacheColumnValues $other_columns
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_dup_key (
  ECache                  $cache,
  Str                     $key,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_dup_revision (ECache $cache)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_erase (ECache $cache)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_foreach (
  ECache                  $cache,
  ECacheDeletedFlag       $deleted_flag,
  Str                     $where_clause,
                          &func (
                            ECache,
                            Str,
                            Str,
                            Str,
                            EOfflineState,
                            gint,
                            CArray[Str],
                            CArray[Str],
                            gpointer --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_foreach_update (
  ECache                  $cache,
  ECacheDeletedFlag       $deleted_flag,
  Str                     $where_clause,
                          &func (
                            ECache,
                            Str,
                            Str,
                            Str,
                            EOfflineState,
                            gint,
                            CArray[Str],
                            CArray[Str],
                            CArray[Str],
                            CArray[Str],
                            EOfflineState is rw,
                            CArray[Pointer[ECacheColumnValues]],
                            gpointer --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_freeze_revision_change (ECache $cache)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get (
  ECache                     $cache,
  Str                        $uid,
  CArray[Str]                $out_revision,
  CArray[ECacheColumnValues] $out_other_columns,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_count (
  ECache                  $cache,
  ECacheDeletedFlag       $deleted_flag,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns guint
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_filename (ECache $cache)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_key_int (
  ECache                  $cache,
  Str                     $key,
  CArray[Pointer[GError]] $error
)
  returns gint
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_object_include_deleted (
  ECache                     $cache,
  Str                        $uid,
  CArray[Str]                $out_revision,
  CArray[ECacheColumnValues] $out_other_columns,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_objects (
  ECache                  $cache,
  ECacheDeletedFlag       $deleted_flag,
  CArray[GSList]          $out_objects,
  CArray[GSList]          $out_revisions,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_offline_changes (
  ECache                  $cache,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSList
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_offline_state (
  ECache                  $cache,
  Str                     $uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EOfflineState
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_sqlitedb (ECache $cache)
  returns Pointer
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_uids (
  ECache                  $cache,
  ECacheDeletedFlag       $deleted_flag,
  CArray[GSList]          $out_uids,
  CArray[GSList]          $out_revisions,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_get_version (ECache $cache)
  returns gint
  is      native(ebackend)
  is      export
{ * }

sub e_cache_initialize_sync (
  ECache                  $cache,
  Str                     $filename,
  GSList                  $other_columns,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_is_revision_change_frozen (ECache $cache)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_lock (
  ECache         $cache,
  ECacheLockType $lock_type
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_offline_change_copy (ECacheOfflineChange $change)
  returns ECacheOfflineChange
  is      native(ebackend)
  is      export
{ * }

sub e_cache_offline_change_free (ECacheOfflineChange $change)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_offline_change_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_cache_offline_change_new (
  Str           $uid,
  Str           $revision,
  Str           $object,
  EOfflineState $state
)
  returns ECacheOfflineChange
  is      native(ebackend)
  is      export
{ * }

sub e_cache_put (
  ECache                  $cache,
  Str                     $uid,
  Str                     $revision,
  Str                     $object,
  ECacheColumnValues      $other_columns,
  ECacheOfflineFlag       $offline_flag,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_remove (
  ECache                  $cache,
  Str                     $uid,
  ECacheOfflineFlag       $offline_flag,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_remove_all (
  ECache                  $cache,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_set_key (
  ECache                  $cache,
  Str                     $key,
  Str                     $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_set_key_int (
  ECache                  $cache,
  Str                     $key,
  gint                    $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_set_offline_state (
  ECache                  $cache,
  Str                     $uid,
  EOfflineState           $state,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_set_revision (
  ECache $cache,
  Str    $revision
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_set_version (
  ECache $cache,
  gint   $version
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_exec (
  ECache                  $cache,
  Str                     $sql_stmt,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_maybe_vacuum (
  ECache                  $cache,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_select (
  ECache                  $cache,
  Str                     $sql_stmt,
                          &func (
                            ECache,
                            gint,
                            CArray[Str],
                            CArray[Str],
                            gpointer --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_stmt_append_printf (
  GString $stmt,
  Str     $format,
  Str
)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_stmt_free (Str $stmt)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_sqlite_stmt_printf (Str $format, Str)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_cache_thaw_revision_change (ECache $cache)
  is      native(ebackend)
  is      export
{ * }

sub e_cache_unlock (
  ECache             $cache,
  ECacheUnlockAction $action
)
  is      native(ebackend)
  is      export
{ * }
