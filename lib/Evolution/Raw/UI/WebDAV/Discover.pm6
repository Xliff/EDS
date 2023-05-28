use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::UI::WebDAV::Discover;

### /usr/src/evolution-data-server-3.48.0/src/libedataserverui/e-webdav-discover-widget.h

sub e_webdav_discover_content_get_base_url (EWebDAVDiscoverContent $content)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_get_multiselect (EWebDAVDiscoverContent $content)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_get_selected (
  EWebDAVDiscoverContent $content,
  gint                   $index,
  CArray[Str]            $out_href,
  guint                  $out_supports      is rw,
  CArray[Str]            $out_display_name,
  CArray[Str]            $out_color,
  guint                  $out_order         is rw
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_get_tree_selection (
  EWebDAVDiscoverContent $content
)
  returns GtkTreeSelection
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_get_user_address (
  EWebDAVDiscoverContent $content
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_new (
  ECredentialsPrompter $credentials_prompter,
  ESource              $source,
  Str                  $base_url,
  guint                $supports_filter
)
  returns EWebDAVDiscoverContent
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_refresh (
  EWebDAVDiscoverContent $content,
  Str                    $display_name,
  GCancellable           $cancellable,
  GAsyncReadyCallback    $callback,
  gpointer               $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_refresh_finish (
  EWebDAVDiscoverContent  $content,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_set_base_url (
  EWebDAVDiscoverContent $content,
  Str                    $base_url
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_set_multiselect (
  EWebDAVDiscoverContent $content,
  gboolean               $multiselect
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_content_show_error (
  EWebDAVDiscoverContent $content,
  GError                 $error
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_dialog_get_content (EWebDAVDiscoverDialog $dialog)
  returns GtkWidget
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_dialog_new (
  GtkWindow            $parent,
  Str                  $title,
  ECredentialsPrompter $credentials_prompter,
  ESource              $source,
  Str                  $base_url,
  guint                $supports_filter
)
  returns EWebDAVDiscoverDialog
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_dialog_refresh (EWebDAVDiscoverDialog $dialog)
  is      native(eds)
  is      export
{ * }
