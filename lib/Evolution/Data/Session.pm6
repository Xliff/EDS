use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Data::Session;

use JSON::GLib::Object;
use SOUP::Session;

use Evolution::Roles::Extends::JSON;

our subset EGDataSessionAncestry is export of Mu
  where EGDataSession | SoupSessionAncestry;

class Evolution::Data::Session::TaskLists is SOUP::Session {
  has EGDataSession $!eds-gds is implementor;

  has $!tasks;

  submethod BUILD ( :$e-data-session ) {
    self.setEGDataSession($e-data-session) if $e-data-session
  }

  method setEGDataSession (EGDataSessionAncestry $_) {
    my $to-parent;

    $!eds-gds = do {
      when EGDataSession {
        $to-parent = cast(SoupSession, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EGDataSession, $_);
      }
    }
    self.setSoupSession($to-parent);
  }

  method Evolution::Raw::Definitions::EGDataSession
    is also<EGDataSession>
  { $!eds-gds }

  multi method new (
     $e-data-session where * ~~ EGDataSessionAncestry,

    :$ref = True
  ) {
    return unless $e-data-session;

    my $o = self.bless( :$e-data-session );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESource() $source) {
    my $e-gdata-session = e_gdata_session_new($source);

    $e-gdata-session ?? self.bless( :$e-gdata-session ) !! Nil;
  }

  method tasks {
    $!tasks = Evolution::Data::Session::Tasks.new($!eds-gds)
      unless $!tasks;
    $!tasks;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &e_gdata_session_get_type, $n, $t );
  }

  method delete_sync (
    Str()                   $tasklist_id,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so e_gdata_session_tasklists_delete_sync(
      $!eds-gds,
      $tasklist_id,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_sync (|)
    is also<get-sync>
  { * }

  multi method get_sync (
    Str()                    $tasklist_id,
    GCancellable()           $cancellable   = GCancellable,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False
  ) {
    samewith(
      $tasklist_id,
      newCArray(JsonObject),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method get_sync (
    Str()                    $tasklist_id,
    CArray[JsonObject]       $out_tasklist,
    GCancellable()           $cancellable   = GCancellable,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$all           = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasklists_get_sync(
      $!eds-gds,
      $tasklist_id,
      $out_tasklist,
      $cancellable,
      $error
    );
    set_error($error);

    my $otl = propReturnObject(
      ppr($out_tasklist) but Evolution::Roles::Extens::JSON::TaskList,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    return Nil unless $rv;

    $all.not ?? $rv !! $otl;
  }


  proto method insert_sync (|)
    is also<insert-sync>
  { * }

  multi method insert_sync (
    Str()                    $title,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    samewith(
       $title,
       newCArray(JsonObject),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method insert_sync (
    Str()                    $title,
    CArray[JsonObject]       $out_inserted_tasklist,
    GCancellable()           $cancellable            = GCancellable,
    CArray[Pointer[GError]]  $error                  = gerror,
                            :$all                    = False,
                            :$raw                    = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasklists_insert_sync(
      $!eds-gds,
      $title,
      $out_inserted_tasklist,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $otl = propReturnObject(
      ppr($out_inserted_tasklist)
        but Evolution::Roles::Extens::JSON::TaskList,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $all.not ?? $rv !! $otl;
  }


  proto method list_sync (|)
    is also<list-sync>
  { * }

  multi method list_sync (
    EGDataQuery()            $query,
                             &cb,
    gpointer                 $user_data            = gpointer,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :cancel(:$cancellable) = GCancellable
  ) {
    samewith(
      $query,
      &cb,
      $user_data,
      $cancellable,
      $error
    );
  }
  multi method list_sync (
    EGDataQuery()           $query,
                            &cb,
    gpointer                $user_data   = gpointer,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasklists_list_sync(
      $!eds-gds,
      $query,
      &cb,
      $user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method patch_sync (|)
    is also<patch-sync>
  { * }

  multi method patch_sync (
    Str                      $tasklist_id,
    JsonBuilder()            $tasklist_properties,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :$cancellable          = GCancellable,
                            :$raw                  = False
  ) {
    samewith(
       $tasklist_id,
       $tasklist_properties,
       newCArray(JsonObject),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method patch_sync (
    Str                      $tasklist_id,
    JsonBuilder()            $tasklist_properties,
    CArray[JsonObject]       $out_patched_tasklist,
    GCancellable()           $cancellable           = GCancellable,
    CArray[Pointer[GError]]  $error                 = gerror,
                            :$all                   = False,
                            :$raw                   = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasklists_patch_sync(
      $!eds-gds,
      $tasklist_id,
      $tasklist_properties,
      $out_patched_tasklist,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $opl = propReturnObject(
      ppr($out_patched_tasklist) but
        Evolution::Roles::Extends::JSON::TaskList,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $all.not ?? $rv !! $opl;
  }

  proto method update_sync (|)
    is also<update-sync>
  { * }

  multi method update_sync (
    Str()                    $tasklist_id,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$raw          = False
  ) {
    samewith(
      $tasklist_id,
      newCArray(JsonObject),
      $cancellable,
      $error
    );
  }
  multi method update_sync (
    Str()                    $tasklist_id,
    CArray[JsonObject]       $out_updated_tasklist,
    GCancellable()           $cancellable           = GCancellable,
    CArray[Pointer[GError]]  $error                 = gerror,
                            :$raw                   = False,
                            :$all                   = False,
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasklists_update_sync(
      $!eds-gds,
      $tasklist_id,
      $out_updated_tasklist,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $oul = propReturnObject(
      ppr($out_updated_tasklist)
        but Evolution::Roles::Extends::JSON::TaskList,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $all.not ?? $rv !! $oul;
  }

}

class Evolution::Data::Session::Tasks is SOUP::Session {
  has EGDataSession $!eds-gds is implementor;

  has $!tasklist;

  submethod BUILD ( :$e-data-session ) {
    self.setEGDataSession($e-data-session) if $e-data-session
  }

  method setEGDataSession (EGDataSessionAncestry $_) {
    my $to-parent;

    $!eds-gds = do {
      when EGDataSession {
        $to-parent = cast(SoupSession, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EGDataSession, $_);
      }
    }
    self.setSoupSession($to-parent);
  }

  method Evolution::Raw::Definitions::EGDataSession
    is also<EGDataSession>
  { $!eds-gds }

  multi method new (
     $e-data-session where * ~~ EGDataSessionAncestry,

    :$ref = True
  ) {
    return unless $e-data-session;

    my $o = self.bless( :$e-data-session );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESource() $source) {
    my $e-gdata-session = e_gdata_session_new($source);

    $e-gdata-session ?? self.bless( :$e-gdata-session ) !! Nil;
  }

  method tasklists {
    $!tasklist = Evolution::Data::Session::Tasks.new($!eds-gds)
      unless $!tasklist;
    $!tasklist;
  }

  method clear_sync (
    Str()                   $tasklist_id,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<clear-sync>
  {
    clear_error;
    my $rv = so e_gdata_session_tasks_clear_sync(
      $!eds-gds,
      $tasklist_id,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method delete_sync (
    Str()                   $tasklist_id,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so e_gdata_session_tasks_delete_sync(
      $!eds-gds,
      $tasklist_id,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_sync (|)
    is also<get-sync>
  { * }

  multi method get_sync (
    Str()                    $tasklist_id,
    Str()                    $task_id,
    GCancellable()           $cancellable   = GCancellable,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False
  ) {
    samewith(
      $tasklist_id,
      $task_id,
      newCArray(JsonObject),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method get_sync (
    Str()                    $tasklist_id,
    Str()                    $task_id,
    CArray[JsonObject]       $out_task,
    GCancellable()           $cancellable   = GCancellable,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$all           = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasks_get_sync(
      $!eds-gds,
      $tasklist_id,
      $task_id,
      $out_task,
      $cancellable,
      $error
    );
    set_error($error);

    my $otl = propReturnObject(
      ppr($out_task) but Evolution::Roles::Extens::JSON::Task,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    return Nil unless $rv;

    $all.not ?? $rv !! $otl;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &e_gdata_session_get_type, $n, $t );
  }

  proto method insert_sync (|)
    is also<insert-sync>
  { * }

  multi method insert_sync (
    Str()                    $title,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    samewith(
       $title,
       newCArray(JsonObject),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method insert_sync (
    Str()                    $title,
    CArray[JsonObject]       $out_inserted_task,
    GCancellable()           $cancellable            = GCancellable,
    CArray[Pointer[GError]]  $error                  = gerror,
                            :$all                    = False,
                            :$raw                    = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasks_insert_sync(
      $!eds-gds,
      $title,
      $out_inserted_task,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $otl = propReturnObject(
      ppr($out_inserted_task) ,
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $otl = $otl but Evolution::Roles::Extens::JSON::Task unless $raw;

    $all.not ?? $rv !! $otl;
  }

  proto method list_sync (|)
    is also<list-sync>
  { * }

  multi method list_sync (
    EGDataQuery()            $query,
                             &cb,
    gpointer                 $user_data            = gpointer,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable            :cancel(:$cancellable) = GCancellable
  ) {
    samewith(
      $query,
      &cb,
      $user_data,
      $cancellable,
      $error
    );
  }
  multi method list_sync (
    EGDataQuery()           $query,
                            &cb,
    gpointer                $user_data   = gpointer,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasks_list_sync(
      $!eds-gds,
      $query,
      &cb,
      $user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method move_sync (|)
    is also<move-sync>
  { * }

  multi method move_sync (
    Str()                    $tasklist_id,
    Str()                    $task_id,
    CArray[Pointer[GError]]  $error
                                = gerror,
    Str()                   :parent(:parent-task-id(:$parent_task_id))
                                = Str,
    Str()                   :prev(:previous(
                              (:previous-task-id(:$previous_task_id))
                             )) = Str,
    GCancellable()          :$cancellable
                                = GCancellable
  ) {
    samewith(
      $tasklist_id,
      $task_id,
      $parent_task_id,
      $previous_task_id,
      $cancellable,
      $error
    );
  }
  multi method move_sync (
    Str()                   $tasklist_id,
    Str()                   $task_id,
    Str()                   $parent_task_id,
    Str()                   $previous_task_id,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror
  ) {
    e_gdata_session_tasks_move_sync(
      $!eds-gds,
      $tasklist_id,
      $task_id,
      $parent_task_id,
      $previous_task_id,
      $cancellable,
      $error
    );
  }

  proto method patch_sync (|)
    is also<patch-sync>
  { * }

  multi method patch_sync (
    Str                      $tasklist_id,
    JsonBuilder()            $tasklist_properties,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable            :$cancellable  = GCancellable,
                            :$raw          = False
  ) {
    samewith(
       $tasklist_id,
       $tasklist_properties,
       newCArray(JsonObject),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method patch_sync (
    Str                      $tasklist_id,
    JsonBuilder()            $tasklist_properties,
    CArray[JsonObject]       $out_patched_task,
    GCancellable             $cancellable           = GCancellable,
    CArray[Pointer[GError]]  $error                 = gerror,
                            :$all                   = False,
                            :$raw                   = False
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasks_patch_sync(
      $!eds-gds,
      $tasklist_id,
      $tasklist_properties,
      $out_patched_task,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $opt = propReturnObject(
      ppr($out_patched_task),
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $opt = $opt but Evolution::Roles::Extens::JSON::Task unless $raw;

    $all.not ?? $rv !! $opt;
  }

  proto method update_sync (|)
    is also<update-sync>
  { * }

  multi method update_sync (
    Str()                    $tasklist_id,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$raw          = False
  ) {
    samewith(
      $tasklist_id,
      newCArray(JsonObject),
      $cancellable,
      $error
    );
  }
  multi method update_sync (
    Str()                    $tasklist_id,
    CArray[JsonObject]       $out_updated_task,
    GCancellable()           $cancellable           = GCancellable,
    CArray[Pointer[GError]]  $error                 = gerror,
                            :$raw                   = False,
                            :$all                   = False,
  ) {
    clear_error;
    my $rv = so e_gdata_session_tasks_update_sync(
      $!eds-gds,
      $tasklist_id,
      $out_updated_task,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $oul = propReturnObject(
      ppr($out_updated_task),
      $raw,
      |JSON::GLib::Object.getTypePair
    );

    $oul = $oul but Evolution::Roles::Extens::JSON::Task unless $raw;

    $all.not ?? $rv !! $oul;
  }

}
