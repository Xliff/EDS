use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend::SExp;

use GLib::Roles::Object;

our subset EBookBackendSExpAncestry is export of Mu
  where EBookBackendSExp | GObject;

class Evolution::Book::Backend::SExp {
  also does GLib::Roles::Object;

  has EBookBackendSExp $!ebbs is implementor;

  submethod BUILD (:$e-book-backend-sexp) {
    self.setEBookBackendSExp($e-book-backend-sexp) if $e-book-backend-sexp;
  }

  method setEBookBackendSExp (EBookBackendSExpAncestry $_) {
    my $to-parent;

    $!ebbs = do {
      when EBookBackendSExp {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackendSExp, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EBookBackendSExp
    is also<EBookBackendSExp>
  { $!ebbs }

  multi method new (
    EBookBackendSExpAncestry  $e-book-backend-sexp,
                             :$ref                  = True
  ) {
    return Nil unless $e-book-backend-sexp;

    my $o = self.bless( :$e-book-backend-sexp );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $exp)  {
    my $e-book-backend-sexp = e_book_backend_sexp_new($exp);

    $e-book-backend-sexp ?? self.bless( :$e-book-backend-sexp ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_backend_sexp_get_type, $n, $t );
  }

  method lock {
    e_book_backend_sexp_lock($!ebbs);
  }

  method match_contact (EContact() $contact) is also<match-contact> {
    so e_book_backend_sexp_match_contact($!ebbs, $contact);
  }

  method match_vcard (Str() $vcard) is also<match-vcard> {
    so e_book_backend_sexp_match_vcard($!ebbs, $vcard);
  }

  method text {
    e_book_backend_sexp_text($!ebbs);
  }

  method unlock {
    e_book_backend_sexp_unlock($!ebbs);
  }

}
