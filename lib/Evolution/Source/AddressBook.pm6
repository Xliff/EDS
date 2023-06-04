use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source;


our subset ESourceAddressBookAncestry is export of Mu
  where ESourceAddressBook | ESourceAncestry;

class Evolution::Source::AddressBook is Evolution::Source {
  has ESourceAddressBook $!eds-esab is implementor;

  submethod BUILD ( :$e-source-addrbook ) {
    self.setESourceAddressBook($e-source-addrbook) if $e-source-addrbook
  }

  method setESourceAddressBook (ESourceAddressBookAncestry $_) {
    my $to-parent;

    $!eds-esab = do {
      when ESourceAddressBook {
        $to-parent = cast(ESource, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceAddressBook, $_);
      }
    }
    self.setESource($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceAddressBook
    is also<ESourceAddressBook>
  { $!eds-esab }

  multi method new (
     $e-source-addrbook where * ~~ ESourceAddressBookAncestry,

    :$ref = True
  ) {
    return unless $e-source-addrbook;

    my $o = self.bless( :$e-source-addrbook );
    $o.ref if $ref;
    $o;
  }

  method get_order is also<get-order> {
    e_source_address_book_get_order($!eds-esab);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_address_book_get_type, $n, $t );
  }

  method set_order (Int() $order) is also<set-order> {
    my guint $o = $order;

    e_source_address_book_set_order($!eds-esab, $o);
  }
}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-address-book.h

sub e_source_address_book_get_order (ESourceAddressBook $extension)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_source_address_book_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_source_address_book_set_order (
  ESourceAddressBook $extension,
  guint              $order
)
  is      native(eds)
  is      export
{ * }
