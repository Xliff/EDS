use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend::Summary;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset EBookBackendSummaryAncestry is export of Mu
  where EBookBackendSummary | GObject;

class Evolution::Book::Backend::Summary {
  also does GLib::Roles::Object;

  has EBookBackendSummary $!eds-ebbs is implementor;

  submethod BUILD ( :$e-book-summary ) {
    self.setEBookBackendSummary($e-book-summary)
      if $e-book-summary
  }

  method setEBookBackendSummary (EBookBackendSummaryAncestry $_) {
    my $to-parent;

    $!eds-ebbs = do {
      when EBookBackendSummary {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackendSummary, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EBookBackendSummary
    is also<EBookBackendSummary>
  { $!eds-ebbs }

  multi method new (
    $e-book-summary where * ~~ EBookBackendSummaryAncestry,

    :$ref = True
  ) {
    return unless $e-book-summary;

    my $o = self.bless( :$e-book-summary );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $summary_path, Int() $flush_timeout_millis) {
    my gint $f = $flush_timeout_millis;

    my $e-book-summary = e_book_backend_summary_new($summary_path, $f);

    $e-book-summary ?? self.bless( :$e-book-summary ) !! Nil;
  }

  method add_contact (EContact() $contact) is also<add-contact> {
    e_book_backend_summary_add_contact($!eds-ebbs, $contact);
  }

  method check_contact (Str() $id) is also<check-contact> {
    e_book_backend_summary_check_contact($!eds-ebbs, $id);
  }

  method get_summary_vcard (Str() $id) is also<get-summary-vcard> {
    e_book_backend_summary_get_summary_vcard($!eds-ebbs, $id);
  }

  method is_summary_query (Str() $query) is also<is-summary-query> {
    e_book_backend_summary_is_summary_query($!eds-ebbs, $query);
  }

  method is_up_to_date (Int() $time) is also<is-up-to-date> {
    my time_t $t = $time;

    e_book_backend_summary_is_up_to_date($!eds-ebbs, $t);
  }

  method load {
    e_book_backend_summary_load($!eds-ebbs);
  }

  method remove_contact (Str() $id) is also<remove-contact> {
    e_book_backend_summary_remove_contact($!eds-ebbs, $id);
  }

  method save {
    e_book_backend_summary_save($!eds-ebbs);
  }

  method search (Str() $query, :$raw = False) {
    my $a = e_book_backend_summary_search($!eds-ebbs, $query);
    return $a if $raw;
    GLib::Array::String.new($a).Array;
  }

  method touch {
    e_book_backend_summary_touch($!eds-ebbs);
  }
}
