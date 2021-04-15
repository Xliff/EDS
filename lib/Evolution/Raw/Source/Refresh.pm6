use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Refresh;

### /usr/include/evolution-data-server/libedataserver/e-source-refresh.h

sub e_source_refresh_add_timeout (
	ESource        $source,
	GMainContext   $context,
	               &callback (ESource, gpointer),
	gpointer       $user_data,
	               &notify (gpointer)
)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_refresh_force_timeout (ESource $source)
  is native(eds)
  is export
{ * }

sub e_source_refresh_get_enabled (ESourceRefresh $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_refresh_get_interval_minutes (ESourceRefresh $extension)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_refresh_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_refresh_remove_timeout (
	ESource $source,
	guint   $refresh_timeout_id
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_refresh_remove_timeouts_by_data (
	ESource  $source,
	gpointer $user_data
)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_refresh_set_enabled (
	ESourceRefresh $extension,
	gboolean       $enabled
)
  is native(eds)
  is export
{ * }

sub e_source_refresh_set_interval_minutes (
	ESourceRefresh $extension,
	guint          $interval_minutes
)
  is native(eds)
  is export
{ * }
