use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::UserPrompter;

### /usr/include/evolution-data-server/libebackend/e-user-prompter.h

sub e_user_prompter_extension_prompt (
  EUserPrompter    $prompter,
  Str              $dialog_name,
  ENamedParameters $in_parameters,
  GCancellable     $cancellable,
                   &callback (EUserPrompter, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_extension_prompt_finish (
  EUserPrompter           $prompter,
  GAsyncResult            $result,
  ENamedParameters        $out_values,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_extension_prompt_sync (
  EUserPrompter           $prompter,
  Str                     $dialog_name,
  ENamedParameters        $in_parameters,
  ENamedParameters        $out_values,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_new ()
  returns EUserPrompter
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_prompt (
  EUserPrompter $prompter,
  Str           $type,
  Str           $title,
  Str           $primary_text,
  Str           $secondary_text,
  gboolean      $use_markup,
  GList         $button_captions,
  GCancellable  $cancellable,
                &callback (EUserPrompter, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_prompt_finish (
  EUserPrompter           $prompter,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebackend)
  is export
{ * }

sub e_user_prompter_prompt_sync (
  EUserPrompter           $prompter,
  Str                     $type,
  Str                     $title,
  Str                     $primary_text,
  Str                     $secondary_text,
  gboolean                $use_markup,
  GList                   $button_captions,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebackend)
  is export
{ * }
