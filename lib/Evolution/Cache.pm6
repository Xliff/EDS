use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Cache;

use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use Evolution::Roles::Signals::Cache;

our subset ECacheAncestry is export of Mu
  where ECache | GObject;

class Evolution::Cache {
  also does Evolution::Roles::Signals::Cache;
  also does GLib::Roles::Object;

  has ECache $!eds-c is implementor;

  submethod BUILD ( :$e-cache ) {
    self.setECache($e-cache) if $e-cache
  }

  method setECache (ECacheAncestry $_) {
    my $to-parent;

    $!eds-c = do {
      when ECache {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECache, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECache
    is also<ECache>
  { $!eds-c }

  multi method new ($e-cache where * ~~ ECacheAncestry , :$ref = True) {
    return unless $e-cache;

    my $o = self.bless( :$e-cache );
    $o.ref if $ref;
    $o;
  }

  # Is originally:
  # ECache *cache,  Str *uid,  GCancellable *cancellable,  GError **error --> gboolean
  method before-remove {
    self.connect-before-remove($!eds-c);
  }

  # Is originally:
  # ECache *cache,  Str *uid,  Str *revision,  Str *object,  ECacheColumnValues *other_columns,  gboolean is_replace,  GCancellable *cancellable,  GError **error --> gboolean
  method before-put {
    self.connect-before-put($!eds-c);
  }

  method revision-changed is also<revision_changed> {
    self.connect($!eds-c, 'revision-changed');
  }

  method change_revision is also<change-revision> {
    e_cache_change_revision($!eds-c);
  }

  proto method clear_offline_changes (|)
    is also<clear-offline-changes>
  { * }

  multi method clear_offline_changes (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method clear_offline_changes (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = so e_cache_clear_offline_changes($!eds-c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method contains (Str() $uid, Int() $deleted_flag) {
    my ECacheDeletedFlag $d = $deleted_flag;

    so e_cache_contains($!eds-c, $uid, $d);
  }

  proto method copy_missing_to_column_values (|)
    is also<copy-missing-to-column-values>
  { * }

  multi method copy_missing_to_column_values (
                         @names,
                         @values,
    ECacheColumnValues() $other_columns
  ) {
    X::GLib::InvalidSize.new(
      message => "\@names and \@values must be the same size when using .{
                   &?ROUTINE.name }!"
    ).throw;

    samewith(
      @names.elems,
      ArrayToCArray(Str, @names),
      ArrayToCArray(Str, @values),
      $other_columns
    );
  }
  multi method copy_missing_to_column_values (
    Int()                $ncols,
    CArray[Str]          $column_names,
    CArray[Str]          $column_values,
    ECacheColumnValues() $other_columns
  ) {
    my gint $n = $ncols;

    e_cache_copy_missing_to_column_values(
      $!eds-c,
      $n,
      $column_names,
      $column_values,
      $other_columns
    );
  }

  method dup_key (Str() $key, CArray[Pointer[GError]] $error = gerror)
    is also<dup-key>
  {
    clear_error;
    my $rv = e_cache_dup_key($!eds-c, $key, $error);
    set_error($error);
    $rv;
  }

  method dup_revision is also<dup-revision> {
    e_cache_dup_revision($!eds-c);
  }

  method erase {
    e_cache_erase($!eds-c);
  }

  multi method foreach (
                            &func,
    gpointer                $user_data
                             = gpointer,
    CArray[Pointer[GError]] $error
                              = gerror,
    Int()                   :d(:deleted(:deleted-flag(:$deleted_flag)))
                              = 0,
    Str()                   :where(:where-clause(:$where_clause))
                              = Str,
    GCancellable()          :$cancellable
                              = GCancellable
  ) {
    samewith(
      $deleted_flag,
      $where_clause,
      &func,
      $user_data,
      $cancellable,
      $error
    )
  }
  multi method foreach (
    Int()                   $deleted_flag,
    Str()                   $where_clause,
                            &func,
    gpointer                $user_data     = gpointer,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my ECacheDeletedFlag $d = $deleted_flag;

    e_cache_foreach(
      $!eds-c,
      $d,
      $where_clause,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }

  proto method foreach_update (|)
    is also<foreach-update>
  { * }

  multi method foreach_update (
                             &func,
    gpointer                 $user_data
                               = gpointer,
    CArray[Pointer[GError]]  $error
                               = gerror,
    Int()                   :d(:deleted(:deleted-flag(:$deleted_flag)))
                               = 0,
    Str()                   :where(:where-clause(:$where_clause))
                               = Str,
    GCancellable()          :$cancellable
                               = GCancellable
  ) {
    samewith(
      $deleted_flag,
      $where_clause,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }
  multi method foreach_update (
    Int()                   $deleted_flag,
    Str()                   $where_clause,
                            &func,
    gpointer                $user_data,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my ECacheDeletedFlag $d = $deleted_flag;

    e_cache_foreach_update(
      $!eds-c,
      $d,
      $where_clause,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }

  method freeze_revision_change is also<freeze-revision-change> {
    e_cache_freeze_revision_change($!eds-c);
  }

  multi method get (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $uid,
      newCArray(Str),
      newCArray(ECacheColumnValues),
      $cancellable,
      $error
    );
  }
  multi method get (
    Str()                      $uid,
    CArray[Str]                $out_revision,
    CArray[ECacheColumnValues] $out_other_columns,
    GCancellable()             $cancellable        = GCancellable,
    CArray[Pointer[GError]]    $error              = gerror
  ) {
    clear_error;
    my $c = e_cache_get(
      $!eds-c,
      $uid,
      $out_revision,
      $out_other_columns,
      $cancellable,
      $error
    );
    set_error($error);
    $c;
  }

  proto method get_count (|)
    is also<get-count>
  { * }

  multi method get_count (
    GCancellable()          $cancellable
                              = GCancellable,
    CArray[Pointer[GError]] $error
                              = gerror,
    Int()                   :deleted(:deleted-flag(:$deleted_flag))
                              = 0
  ) {
    samewith($deleted_flag, $cancellable, $error);
  }
  multi method get_count (
    Int()                   $deleted_flag,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    e_cache_get_count($!eds-c, $deleted_flag, $cancellable, $error);
  }

  method get_filename is also<get-filename> {
    e_cache_get_filename($!eds-c);
  }

  method get_key_int (Str() $key, CArray[Pointer[GError]] $error = gerror)
    is also<get-key-int>
  {
    clear_error;
    my $i = e_cache_get_key_int($!eds-c, $key, $error);
    set_error($error);
    $i;
  }

  proto method get_object_include_deleted (|)
    is also<get-object-include-deleted>
  { * }

  multi method get_object_include_deleted (
    Str()                       $uid,
    CArray[Pointer[GError]]     $error                = gerror,
    GCancellable()             :cancel(:$cancellable) = GCancellable,
                               :$raw                  = False
  ) {
    samewith(
       $uid,
       newCArray(Str),
       newCArray(ECacheColumnValues),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method get_object_include_deleted (
    Str()                       $uid,
    CArray[Str]                 $out_revision,
    CArray[ECacheColumnValues]  $out_other_columns,
    GCancellable()              $cancellable        = GCancellable,
    CArray[Pointer[GError]]     $error              = gerror,
                               :$all                = False,
                               :$raw                = False
  ) {
    clear_error;
    my $rv = so e_cache_get_object_include_deleted(
      $!eds-c,
      $uid,
      $out_revision,
      $out_other_columns,
      $cancellable,
      $error
    );
    set_error($error);

    my $ooc = propReturnObject(
      ppr($out_other_columns),
      $raw,
      |Evolution::Cache::Column::Values.getTypePair
    );

    $all.not ?? $rv !! ( ppr($out_revision), $ooc );
  }

  proto method get_objects (|)
    is also<get-objects>
  { * }

  multi method get_objects (
    CArray[Pointer[GError]]  $error                 = gerror,
    Int()                   :$deleted_flag          = 0,
    GCancellable            :cancel(:$cancellable)  = GCancellable
  ) {
    samewith(
      $deleted_flag,
      newCArray(GSList),
      newCArray(GSList),
      $cancellable,
      $error;
    );
  }
  multi method get_objects (
    Int()                    $deleted_flag,
    CArray[Pointer[GSList]]  $out_objects,
    CArray[Pointer[GSList]]  $out_revisions,
    GCancellable()           $cancellable     = GCancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                             :$all            = False,
                             :$raw            = False,
                             :glist(:$gslist) = False
  ) {
    my ECacheDeletedFlag $d = $deleted_flag;

    clear_error;
    my $rv = e_cache_get_objects(
      $!eds-c,
      $deleted_flag,
      $out_objects,
      $out_revisions,
      $cancellable,
      $error
    );
    set_error($error);

    my $oo = returnGSList(
      ppr($out_objects),
      $raw,
      $gslist,
      Str
    );

    my $or = returnGSList(
      ppr($out_revisions),
      $raw,
      $gslist,
      Str
    );

    $all.not ?? $rv !! ($oo, $or);
  }

  proto method get_offline_changes (|)
    is also<get-offline-changes>
  { * }

  multi method get_offline_changes (
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method get_offline_changes (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cache_get_offline_changes($!eds-c, $cancellable, $error);
    set_error($error);
    $rv
  }

  proto method get_offline_state (|)
    is also<get-offline-state>
  { * }

  multi method get_offline_state (
    Str                      $uid,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable            :cancel(:$cancellable) = GCancellable
  ) {
    samewith($uid, $cancellable, $error);
  }
  multi method get_offline_state (
    Str()                   $uid,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cache_get_offline_state(
      $!eds-c,
      $uid,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_sqlitedb is also<get-sqlitedb> {
    e_cache_get_sqlitedb($!eds-c);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cache_get_type, $n, $t );
  }

  proto method get_uids (|)
    is also<get-uids>
  { * }

  multi method get_uids (
    CArray[Pointer[GError]]  $error                = gerror,
    Int()                   :$deleted_flag         = 0,
    GCancellable()          :cancel(:$cancellable) = GCancellable,
                            :$raw                  = False
  ) {
    samewith(
       $deleted_flag,
       newCArray(GSList),
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method get_uids (
    Int()                    $deleted_flag,
    CArray[Pointer[GSList]]  $out_uids,
    CArray[Pointer[GSList]]  $out_revisions,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error,
                            :$all            = False,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    my ECacheDeletedFlag $d = $deleted_flag;

    clear_error;
    my $rv = so e_cache_get_uids(
      $!eds-c,
      $d,
      $out_uids,
      $out_revisions,
      $cancellable,
      $error
    );
    set_error($error);

    my $oo = returnGSList(
      ppr($out_uids),
      $raw,
      $gslist,
      Str
    );

    my $or = returnGSList(
      ppr($out_revisions),
      $raw,
      $gslist,
      Str
    );

    $all.not ?? $rv !! ($oo, $or);
  }

  method get_version is also<get-version> {
    e_cache_get_version($!eds-c);
  }

  proto method initialize_sync (|)
    is also<initialize-sync>
  { * }

  multi method initialize_sync (
    Str()                    $filename,
    CArray[Pointer[GError]]  $error                = gerror,
                            :others(
                              :other-columns(:@other_columns)
                             ),
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith(
      $filename,
      GLib::GSList.new(typed => ECacheColumnInfo, @other_columns),
      $cancellable,
      $error
    );
  }
  multi method initialize_sync (
    Str()                   $filename,
    GSList()                $other_columns,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    clear_error;
    my $rv = so e_cache_initialize_sync(
      $!eds-c,
      $filename,
      $other_columns,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method is_revision_change_frozen is also<is-revision-change-frozen> {
    so e_cache_is_revision_change_frozen($!eds-c);
  }

  method lock (Int() $lock_type) {
    my ECacheLockType $l = $lock_type;

    e_cache_lock($!eds-c, $l);
  }

  multi method put (
    Str()                               $uid,
    Str()                               $object,
    CArray[Pointer[GError]]             $error
                                           = gerror,
    Str()                               :$revision
                                           = Str,
                                        :others(
                                          :other-columns(:@other_columns)
                                        ),
    Int()                               :offline(
                                          :offline-flag(:$offline_flag)
                                        ) = False,
    GCancellable()                      :cancel(:$cancellable)
                                          = GCancellable
  ) {
    samewith(
      $uid,
      $revision,
      $object,
      ArrayToCArray(ECacheColumnValues, @other_columns),
      $offline_flag,
      $cancellable,
      $error
    );
  }
  multi method put (
    Str()                               $uid,
    Str()                               $revision,
    Str()                               $object,
    CArray[Pointer[ECacheColumnValues]] $other_columns,
    Int()                               $offline_flag,
    GCancellable()                      $cancellable,
    CArray[Pointer[GError]]             $error          = gerror
  ) {
    my ECacheOfflineFlag $o = $offline_flag;

    clear_error;
    my $rv = so e_cache_put(
      $!eds-c,
      $uid,
      $revision,
      $object,
      $other_columns,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }


  multi method remove (
    Str()                   $uid,
    CArray[Pointer[GError]] $error
                              = gerror,
    Int()                   :offline(:offline-flag(:$offline_flag))
                              = False,
    GCancellable()          :cancel(:$cancellable)
                              = GCancellable
  ) {
    samewith(
      $uid,
      $offline_flag,
      $cancellable,
      $error
    );
  }
  multi method remove (
    Str()                   $uid,
    Int()                   $offline_flag,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my ECacheOfflineFlag $o = $offline_flag;

    clear_error;
    my $rv = so e_cache_remove($!eds-c, $uid, $o, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method remove_all (|)
    is also<remove-all>
  { * }

  multi method remove_all (
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method remove_all (
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = e_cache_remove_all($!eds-c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method set_key (
    Str()                   $key,
    Str()                   $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-key>
  {
    clear_error;
    my $rv = so e_cache_set_key($!eds-c, $key, $value, $error);
    set_error($error);
    $rv;
  }

  method set_key_int (
    Str()                   $key,
    Int()                   $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-key-int>
  {
    my gint $v = $value;

    clear_error;
    my $rv = so e_cache_set_key_int($!eds-c, $key, $v, $error);
    set_error($error);
    $rv;
  }

  proto method set_offline_state (|)
    is also<set-offline-state>
  { * }

  multi method set_offline_state (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error       = gerror,
    Int()                   :$state       = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $uid,
      $state,
      $cancellable,
      $error
    );
  }
  multi method set_offline_state (
    Str()                   $uid,
    Int()                   $state,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my ECacheOfflineFlag $o = $state;

    clear_error;
    my $rv = so e_cache_set_offline_state(
      $!eds-c,
      $uid,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_revision (Str() $revision) is also<set-revision> {
    e_cache_set_revision($!eds-c, $revision);
  }

  method set_version (Int() $version) is also<set-version> {
    my gint $v = $version;

    e_cache_set_version($!eds-c, $v);
  }

  proto method sqlite_exec (|)
    is also<sqlite-exec>
  { * }

  multi method sqlite_exec (
    Str()                    $sql_stmt,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith(
      $sql_stmt,
      $cancellable,
      $error
    );
  }
  multi method sqlite_exec (
    Str()                   $sql_stmt,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cache_sqlite_exec($!eds-c, $sql_stmt, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method sqlite_maybe_vacuum (|)
    is also<sqlite-maybe-vacuum>
  { * }

  multi method sqlite_maybe_vacuum (
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method sqlite_maybe_vacuum (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cache_sqlite_maybe_vacuum($!eds-c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method sqlite_select (|)
    is also<sqlite-select>
  { * }

  multi method sqlite_select (
    Str()                    $sql_stmt,
                             &func,
    gpointer                 $user_data   = gpointer,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $sql_stmt,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }
  multi method sqlite_select (
    Str()                   $sql_stmt,
                            &func,
    gpointer                $user_data,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = so e_cache_sqlite_select(
      $!eds-c,
      $sql_stmt,
      &func,
      $user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method sqlite_stmt_append_print (GString() $stmt, Str() $format)
    is static

    is also<sqlite-stmt-append-print>
  {
    e_cache_sqlite_stmt_append_printf($stmt, $format, Str);
  }

  # method sqlite_stmt_free is static {
  #   e_cache_sqlite_stmt_free($stmt);
  # }

  method sqlite_stmt_print (Str() $format)
    is static
    is also<sqlite-stmt-print>
  {
    e_cache_sqlite_stmt_printf($format, Str);
  }

  method thaw_revision_change is also<thaw-revision-change> {
    e_cache_thaw_revision_change($!eds-c);
  }

  method unlock (Int() $action) {
    my ECacheUnlockAction $a = $action;

    e_cache_unlock($!eds-c, $a);
  }

}

# BOXED

class Evolution::Cache::Column::Info {
  also does GLib::Roles::Implementor;

  has ECacheColumnInfo $!eds-cci is boxed;

  submethod BUILD ( :$e-cache-colinfo ) {
    $!eds-cci = $e-cache-colinfo if $e-cache-colinfo
  }

  method Evolution::Raw::Structs::ECacheColumnInfo
    is also<ECacheColumnInfo>
  { $!eds-cci }

  multi method new (ECacheColumnInfo $e-cache-colinfo) {
    $e-cache-colinfo ?? self.bless( $e-cache-colinfo ) !! Nil;
  }
  multi method new (Str() $name, Str() $type, Str() $index_name) {
    my $e-cache-colinfo = e_cache_column_info_new($name, $type, $index_name);

    $e-cache-colinfo ?? self.bless( $e-cache-colinfo ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cache_column_info_copy($!eds-cci),
      $raw,
      |self.getTypePair
    )
  }

  method free {
    e_cache_column_info_free($!eds-cci);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cache_column_info_get_type, $n, $t );
  }

}

# BOXED - NEEDS IMPLEMENTOR

class Evolution::Cache::Column::Values {
  also does GLib::Roles::Implementor;

  has ECacheColumnValues $!eds-ccv is boxed;

  submethod BUILD ( :$e-cache-colvals ) {
    $!eds-ccv = $e-cache-colvals if $e-cache-colvals;
  }

  method Evolution::Raw::Definitions::ECacheColumnValues
    is also<ECacheColumnValues>
  { $!eds-ccv }

  multi method new (ECacheColumnValues $e-cache-colvals) {
    $e-cache-colvals ?? self.bless( :$e-cache-colvals ) !! Nil;
  }
  multi method new {
    my $e-cache-colvals = e_cache_column_values_new();

    $e-cache-colvals ?? self.bless( :$e-cache-colvals ) !! Nil;
  }

  method contains (Str() $name) {
    so e_cache_column_values_contains($!eds-ccv, $name);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cache_column_values_copy($!eds-ccv),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cache_column_values_free($!eds-ccv);
  }

  method get_size is also<get-size> {
    e_cache_column_values_get_size($!eds-ccv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cache_column_values_get_type, $n, $t );
  }

  proto method init_iter (|)
    is also<init-iter>
  { * }

  multi method init_iter ( :$raw = False ) {
    samewith(GHashTableIter.new)
  }
  multi method init_iter (GHashTableIter() $iter, :$raw = False) {
    propReturnObject(
      e_cache_column_values_init_iter($!eds-ccv, $iter),
      $raw,
      |GLib::HashTable::Iter.getTypePair
    );
  }

  method lookup (Str() $name) {
    e_cache_column_values_lookup($!eds-ccv, $name);
  }

  method put (Str() $name, Str() $value) {
    e_cache_column_values_put($!eds-ccv, $name, $value);
  }

  method remove (Str() $name) {
    e_cache_column_values_remove($!eds-ccv, $name);
  }

  method remove_all {
    e_cache_column_values_remove_all($!eds-ccv);
  }

  method take (Str() $name, Str() $value) {
    e_cache_column_values_take($!eds-ccv, $name, $value);
  }

  method take_value (Str() $name, Str() $value) is also<take-value> {
    e_cache_column_values_take_value($!eds-ccv, $name, $value);
  }

}

# BOXED

class Evolution::Cache::Offline::Change {
  also does GLib::Roles::Implementor;

  has ECacheOfflineChange $eds-oc is boxed handles<uid revision object>;

  submethod BUILD ( :$e-offline-change ) {
    $!eds-oc = $e-offline-change if $e-offline-change;
  }

  method Evolution::Raw::Structs::ECacheOfflineChange
    is also<ECacheOfflineChange>
  { $!eds-oc }

  multi method new (ECacheOfflineChange $e-offline-change) {
    $e-offline-change ?? self.bless( :$e-offline-change ) !! Nil;
  }
  multi method new (
    Str() $uid,
    Str() $revision,
    Str() $object,
    Int() $state
  )
    is also<offline-change-new>
  {
    my EOfflineState $s = $state;

    my $e-offline-change = e_cache_offline_change_new(
      $uid,
      $revision,
      $object,
      $s
    );

    $e-offline-change ?? self.bless( :$e-offline-change ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
       e_cache_offline_change_copy($!eds-oc),
       $raw,
      |self.getTypePair
    )
  }

  method free {
    e_cache_offline_change_free($!eds-oc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cache_offline_change_get_type, $n, $t );
  }

}
