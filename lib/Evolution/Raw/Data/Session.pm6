use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use JSON::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Data::Session;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-gdata-session.h

sub e_gdata_task_add_completed (JsonBuilder $builder, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_add_due (JsonBuilder $builder, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_add_id (JsonBuilder $builder, Str $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_add_notes (JsonBuilder $builder, Str $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_add_status (
  JsonBuilder      $builder,
  EGDataTaskStatus $value
)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_add_title (JsonBuilder $builder, Str $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_completed (JsonObject $task)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_deleted (JsonObject $task)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_due (JsonObject $task)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_etag (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_hidden (JsonObject $task)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_id (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_notes (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_parent (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_position (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_self_link (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_status (JsonObject $task)
  returns EGDataTaskStatus
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_title (JsonObject $task)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_task_get_updated (JsonObject $task)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_add_id (JsonBuilder $builder, Str $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_add_title (JsonBuilder $builder, Str $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_get_etag (JsonObject $tasklist)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_get_id (JsonObject $tasklist)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_get_self_link (JsonObject $tasklist)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_get_title (JsonObject $tasklist)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_tasklist_get_updated (JsonObject $tasklist)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_new (ESource $source)
  returns EGDataSession
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_delete_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_get_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  CArray[JsonObject]      $out_tasklist,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_insert_sync (
  EGDataSession           $self,
  Str                     $title,
  CArray[JsonObject]      $out_inserted_tasklist,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_list_sync (
  EGDataSession           $self,
  EGDataQuery             $query,
                          &cb (
                            EGDataSession,
                            JsonObject,
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_patch_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  JsonBuilder             $tasklist_properties,
  CArray[JsonObject]      $out_patched_tasklist,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasklists_update_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  JsonBuilder             $tasklist,
  CArray[JsonObject]      $out_updated_tasklist,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_clear_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_delete_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  Str                     $task_id,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_get_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  Str                     $task_id,
  CArray[JsonObject]      $out_task,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_insert_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  JsonBuilder             $task,
  Str                     $parent_task_id,
  Str                     $previous_task_id,
  CArray[JsonObject]      $out_inserted_task,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_list_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  EGDataQuery             $query,
                          &cb (
                            EGDataSession,
                            JsonObject,
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_move_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  Str                     $task_id,
  Str                     $parent_task_id,
  Str                     $previous_task_id,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_patch_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  Str                     $task_id,
  JsonBuilder             $task_properties,
  CArray[JsonObject]      $out_patched_task,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_session_tasks_update_sync (
  EGDataSession           $self,
  Str                     $tasklist_id,
  Str                     $task_id,
  JsonBuilder             $task,
  CArray[JsonObject]      $out_updated_task,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }
