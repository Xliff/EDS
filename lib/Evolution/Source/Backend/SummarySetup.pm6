use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Backend::SummarySetup;

use Evolution::Source::Extension;

our subset ESourceBackendSummarySetupAncestry is export of Mu
  where ESourceBackendSummarySetup | ESourceExtensionAncestry;

class Evolution::Source::Backend::SummarySetup
  is Evolution::Source::Extension
{
  has ESourceBackendSummarySetup $!ebss;

  proto method get_indexed_fields (|)
  { * }

  multi method get_indexed_fields (@types) {
    samewith( ArrayToCArray(EBookIndexType, @types), $ )
  }
  multi method get_indexed_fields (
    CArray[EBookIndexType] $types,
                           $n_fields is rw
  ) {
    my gint $n = 0;

    my $if = e_source_backend_summary_setup_get_indexed_fields(
      $!ebss,
      $types,
      $n
    );
    $n_fields = $n;

    CArrayToArray($if, $n)
  }

  proto method get_summary_fields (|)
  { * }

  multi method get_summary_fields {
    samewith($);
  }
  multi method get_summary_fields ($n_fields is rw) {
    my gint $n = 0;

    my $it = e_source_backend_summary_setup_get_summary_fields($!ebss, $n);
    $n_fields = $n;
    CArrayToArray($it, $n);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      e_source_backend_summary_setup_get_type,
      $n,
      $t
    );
  }

  proto method set_indexed_fieldsv (|)
  { * }

  # is also<set_index_fields>
  multi method set_indexed_fieldsv (@fields, @types) {
    die "Array size mismatch when setting indexed fields in { self.^name }"
      unless +@fields == +@types;

    samewith(
      ArrayToCArray(EContactField, @fields),
      ArrayToCArray(EBookIndexType, @types),
      @fields.elems;
    );
  }
  multi method set_indexed_fieldsv (
    CArray[EContactField]  $fields,
    CArray[EBookIndexType] $types,
    Int()                  $n_fields
  ) {
    my gint $n = $n_fields;

    e_source_backend_summary_setup_set_indexed_fieldsv(
      $!ebss,
      $fields,
      $types,
      $n
    );
  }

  proto method set_summary_fieldsv (|)
  { * }

  # is also<set_summary_fields>
  multi method set_summary_fieldsv (@fields) {
    samewith(
      ArrayToCArray(EContactField, @fields),
      @fields.elems
    )
  }
  multi method set_summary_fieldsv (
    CArray[EContactField] $fields,
    Int()                 $n_fields
  ) {
    my gint $n = $n_fields;

    e_source_backend_summary_setup_set_summary_fieldsv($!ebss, $fields, $n);
  }

}
