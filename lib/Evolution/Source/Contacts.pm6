use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceContactsAncestry is export of Mu
  where ESourceContacts | ESourceExtensionAncestry;

class Evolution::Source::Contacts is Evolution::Source::Extension {
  has ESourceContacts $!esc;

  submethod BUILD (:$Contacts) {
    self.setESourceContacts($Contacts) if $Contacts;
  }

  method setESourceContacts (ESourceContactsAncestry $_) {
    my $to-parent;

    $!esc = do {
      when ESourceContacts {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceContacts, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceContacts
  { $!esc }

  method new (
    ESourceContactsAncestry $Contacts,
                            :$ref   = True
  ) {
    return Nil unless $Contacts;

    my $o = self.bless( :$Contacts );
    $o.ref if $ref;
    $o;
  }

  method include_me is rw {
    Proxy.new:
      FETCH => -> $     { self.get_include_me    },
      STORE => -> $, \v { self.set_include_me(v) }
  }

  method get_include_me {
    so e_source_contacts_get_include_me($!esc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_contacts_get_type, $n, $t );
  }

  method set_include_me (Int() $include_me) {
    my gboolean $i = $include_me.so.Int;

    e_source_contacts_set_include_me($!esc, $include_me);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-contacts.h

sub e_source_contacts_get_include_me (ESourceContacts $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_contacts_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_contacts_set_include_me (ESourceContacts $extension, gboolean $include_me)
  is native(eds)
  is export
{ * }
