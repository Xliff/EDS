use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Backend::SummarySetup;


### /usr/include/evolution-data-server/libebook-contacts/e-source-backend-summary-setup.h

sub e_source_backend_summary_setup_get_indexed_fields (
  ESourceBackendSummarySetup $extension,
  CArray[EBookIndexType]     $types,
  gint                       $n_fields   is rw
  )
  returns CArray[EContactField]
  is native(eds)
  is export
{ * }

sub e_source_backend_summary_setup_get_summary_fields (
  ESourceBackendSummarySetup $extension,
  gint                       $n_fields   is rw
)
  returns CArray[EContactField]
  is native(eds)
  is export
{ * }

sub e_source_backend_summary_setup_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

# Var-args
# sub e_source_backend_summary_setup_set_indexed_fields (
#   ESourceBackendSummarySetup $extension
# )
#   is native(eds)
#   is export
# { * }

sub e_source_backend_summary_setup_set_indexed_fieldsv (
  ESourceBackendSummarySetup $extension,
  CArray[EContactField]      $fields,
  CArray[EBookIndexType]     $types,
  gint                       $n_fields
)
  is native(eds)
  is export
{ * }

# Var-args
# sub e_source_backend_summary_setup_set_summary_fields (
#   ESourceBackendSummarySetup $extension
# )
#   is native(eds)
#   is export
# { * }

sub e_source_backend_summary_setup_set_summary_fieldsv (
  ESourceBackendSummarySetup $extension,
  CArray[EContactField]      $fields,
  gint                       $n_fields
)
  is native(eds)
  is export
{ * }
