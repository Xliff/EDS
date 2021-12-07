use v6.c;

use Method::Also;

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

  submethod BUILD ( :$e-source-summary-setup ) {
    self.setESourceBackendSummarySetup($e-source-summary-setup)
      if $e-source-summary-setup;
  }

  method setESourceBackendSummarySetup (
    ESourceBackendSummarySetupAncestry $_
  ) {
    my $to-parent;

    $!ebss = do {
      when ESourceBackendSummarySetup {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceBackendSummarySetup, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceBackendSummarySetup
    is also<ESourceBackendSummarySetup>
  { $!ebss }

  method new (
    ESourceBackendSummarySetupAncestry  $e-source-summary-setup,
                                       :$ref                     = True
  ) {
    return Nil unless $e-source-summary-setup;

    my $o = self.bless( :$e-source-summary-setup );
    $o.ref if $ref;
    $o;
  }

  proto method get_indexed_fields (|)
    is also<get-indexed-fields>
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
    is also<get-summary-fields>
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

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      e_source_backend_summary_setup_get_type,
      $n,
      $t
    );
  }

  proto method set_indexed_fieldsv (|)
    is also<set-indexed-fieldsv>
  { * }

  multi method set_indexed_fieldsv (@fields, @types)
    is also<
      set_index_fields
      set-index-fields
    >
  {
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
    is also<set-summary-fieldsv>
  { * }

  # is also<set_summary_fields>
  multi method set_summary_fieldsv (@fields)
    is also<
      set_summary_fields
      set-summary-fields
    >
  {
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
