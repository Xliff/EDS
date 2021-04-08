use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceBackendAncestry is export of Mu
  where ESourceBackend | ESourceExtensionAncestry;

class Evolution::Source::Backend is Evolution::Source::Extension {
  has ESourceBackend $!esb is implementor;

  submethod BUILD (:$backend) {
    self.setESourceBackend($backend) if $backend;
  }

  method setESourceBackend (ESourceBackendAncestry $_) {
    my $to-parent;

    $!esb = do {
      when ESourceBackend {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceBackend, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method EDS::Raw::Definitions::ESourceBackend
  { $!esb }

  multi method new (ESourceBackendAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }

  method dup_backend_name {
    e_source_backend_dup_backend_name($!esb);
  }

  method get_backend_name {
    e_source_backend_get_backend_name($!esb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_backend_get_type, $n, $t );
  }

  method set_backend_name (Str() $backend_name) {
    e_source_backend_set_backend_name($!esb, $backend_name);
  }

}

our subset ESourceAddressBookAncestry is export of Mu
  where ESourceAddressBook | ESourceBackendAncestry;

class Evolution::Source::AddressBook is Evolution::Source::Backend {
  has ESourceAddressBook $!esa;

  submethod (:$address-book) {
    self.setESourceAddressBook($address-book) if $address-book;
  }

  method setESourceAddressBook (ESourceAddressBookAncestry $_) {
    my $to-parent;

    $!esa = do {
      when ESourceAddressBook {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceAddressBook, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceAddressBook
  { $!esa }

  multi method new (ESourceAddressBookAncestry $address-book, :$ref = True) {
    return Nil unless $address-book;

    my $o = self.bless( :$address-book );
    $o.ref if $ref;
    $o;
  }

}

our subset ESourceMailTransportAncestry is export of Mu
  where ESourceMailTransport | ESourceBackendAncestry;

class Evolution::Source::MailTransportAncestry is Evolution::Source::Backend {
  has ESourceMailTransport $!emt is implementor;

  submethod (:$mail-transport) {
    self.setESourceMailTransport($mail-transport) if $mail-transport;
  }

  method setESourceMailTransport (ESourceMailTransportAncestry $_) {
    my $to-parent;

    $!emt = do {
      when ESourceAddressBook {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailTransport, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailTransport
  { $!emt }

  multi method new (ESourceMailTransportAncestry $mail-transport, :$ref = True) {
    return Nil unless $mail-transport;

    my $o = self.bless( :$mail-transport );
    $o.ref if $ref;
    $o;
  }

}

### /usr/include/evolution-data-server/libedataserver/e-source-backend.h

sub e_source_backend_dup_backend_name (ESourceBackend $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_backend_get_backend_name (ESourceBackend $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_backend_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_backend_set_backend_name (
  ESourceBackend $extension,
  Str            $backend_name
)
  is native(eds)
  is export
{ * }
