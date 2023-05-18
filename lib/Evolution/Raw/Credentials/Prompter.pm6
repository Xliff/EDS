use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Credentials::Prompter;

### /usr/src/evolution-data-server-3.48.0/src/libedataserverui/e-credentials-prompter.h

sub e_credentials_prompter_complete_prompt_call (
  ECredentialsPrompter $prompter,
  GSimpleAsyncResult   $async_result,
  ESource              $source,
  ENamedParameters     $credentials,
  GError               $error
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_auto_prompt (ECredentialsPrompter $prompter)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_auto_prompt_disabled_for (
  ECredentialsPrompter $prompter,
  ESource              $source
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_dialog_parent (ECredentialsPrompter $prompter)
  returns GtkWindow
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_dialog_parent_full (
  ECredentialsPrompter $prompter,
  ESource              $auth_source
)
  returns GtkWindow
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_provider (ECredentialsPrompter $prompter)
  returns ESourceCredentialsProvider
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_registry (ECredentialsPrompter $prompter)
  returns ESourceRegistry
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_loop_prompt_sync (
  ECredentialsPrompter               $prompter,
  ESource                            $source,
  ECredentialsPrompterPromptFlags    $flags,
                                     &func (
                                       ECredentialsPrompter    $prompt,
                                       ESource                 $s,
                                       ENamedParameters        $params,
                                       gboolean                $out     is rw,
                                       gpointer                $udata,
                                       GCancellable,           $cancel,
                                       CArray[Pointer[GError]] $e
                                       --> gboolean
                                     ),
  gpointer                           $user_data,
  GCancellable                       $cancellable,
  CArray[Pointer[GError]]            $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_new (ESourceRegistry $registry)
  returns ECredentialsPrompter
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_process_awaiting_credentials (
  ECredentialsPrompter $prompter
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_process_source (
  ECredentialsPrompter $prompter,
  ESource              $source
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_prompt (
  ECredentialsPrompter            $prompter,
  ESource                         $source,
  Str                             $error_text,
  ECredentialsPrompterPromptFlags $flags,
                                  &callback (
                                    ECredentialsPrompter,
                                    GAsyncResult,
                                    gpointer
                                  ),
  gpointer                        $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_prompt_finish (
  ECredentialsPrompter     $prompter,
  GAsyncResult             $result,
  CArray[ESource]          $out_source,
  CArray[ENamedParameters] $out_credentials,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_register_impl (
  ECredentialsPrompter     $prompter,
  Str                      $authentication_method,
  ECredentialsPrompterImpl $prompter_impl
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_set_auto_prompt (
  ECredentialsPrompter $prompter,
  gboolean             $auto_prompt
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_set_auto_prompt_disabled_for (
  ECredentialsPrompter $prompter,
  ESource              $source,
  gboolean             $is_disabled
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_prompter_unregister_impl (
  ECredentialsPrompter     $prompter,
  Str                      $authentication_method,
  ECredentialsPrompterImpl $prompter_impl
)
  is      native(eds)
  is      export
{ * }
