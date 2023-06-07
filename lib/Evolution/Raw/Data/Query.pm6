use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Data::Query;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-gdata-query.h

sub e_gdata_query_get_completed_max (EGDataQuery $self, gboolean $out_exists)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_completed_min (EGDataQuery $self, gboolean $out_exists)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_due_max (EGDataQuery $self, gboolean $out_exists)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_due_min (EGDataQuery $self, gboolean $out_exists)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_max_results (EGDataQuery $self, gboolean $out_exists)
  returns gint
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_show_completed (EGDataQuery $self, gboolean $out_exists)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_show_deleted (EGDataQuery $self, gboolean $out_exists)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_show_hidden (EGDataQuery $self, gboolean $out_exists)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_get_updated_min (EGDataQuery $self, gboolean $out_exists)
  returns gint64
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_new
  returns EGDataQuery
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_ref (EGDataQuery $self)
  returns EGDataQuery
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_completed_max (EGDataQuery $self, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_completed_min (EGDataQuery $self, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_due_max (EGDataQuery $self, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_due_min (EGDataQuery $self, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_max_results (EGDataQuery $self, gint $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_show_completed (EGDataQuery $self, gboolean $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_show_deleted (EGDataQuery $self, gboolean $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_show_hidden (EGDataQuery $self, gboolean $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_set_updated_min (EGDataQuery $self, gint64 $value)
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_to_string (EGDataQuery $self)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_gdata_query_unref (EGDataQuery $self)
  is      native(eds)
  is      export
{ * }
