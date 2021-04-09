use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Goa;

use Evolution::Source::Extension;

our subset ESourceGoaAncestry is export of Mu
  where ESourceGoa | ESourceExtensionAncestry;

class Evolution::Source::Goa is Evolution::Source::Extension {
  has ESourceGoa $!esg;

  submethod BUILD (:$goa) {
    self.setESourceGoa($goa) if $goa;
  }

  method setESourceGoa (ESourceGoaAncestry $_) {
    my $to-parent;

    $!esg = do {
      when ESourceGoa {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceGoa, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceGoa
  { $!esg }

  multi method new (ESourceGoaAncestry $goa, :$ref = True) {
    return Nil unless $goa;

    my $o = self.bless( :$goa );
    $o.ref if $ref;
    $o;
  }

  method account_id is rw {
    Proxy.new:
      FETCH => -> $     { self.get_account_id    },
      STORE => -> $, \v { self.set_account_id(v) }
  }

  method address is rw {
    Proxy.new:
      FETCH => -> $     { self.get_address    },
      STORE => -> $, \v { self.set_address(v) }
  }

  method calendar_url is rw {
    Proxy.new:
      FETCH => -> $     { self.get_calendar_url    },
      STORE => -> $, \v { self.set_calendar_url(v) }
  }

  method contacts_url is rw {
    Proxy.new:
      FETCH => -> $     { self.get_contacts_url    },
      STORE => -> $, \v { self.set_contacts_url(v) }
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method dup_account_id {
    e_source_goa_dup_account_id($!esg);
  }

  method dup_address {
    e_source_goa_dup_address($!esg);
  }

  method dup_calendar_url {
    e_source_goa_dup_calendar_url($!esg);
  }

  method dup_contacts_url {
    e_source_goa_dup_contacts_url($!esg);
  }

  method dup_name {
    e_source_goa_dup_name($!esg);
  }

  method get_account_id {
    e_source_goa_get_account_id($!esg);
  }

  method get_address {
    e_source_goa_get_address($!esg);
  }

  method get_calendar_url {
    e_source_goa_get_calendar_url($!esg);
  }

  method get_contacts_url {
    e_source_goa_get_contacts_url($!esg);
  }

  method get_name {
    e_source_goa_get_name($!esg);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_goa_get_type, $n, $t );
  }

  method set_account_id (Str() $account_id) {
    e_source_goa_set_account_id($!esg, $account_id);
  }

  method set_address (Str() $address) {
    e_source_goa_set_address($!esg, $address);
  }

  method set_calendar_url (Str() $calendar_url) {
    e_source_goa_set_calendar_url($!esg, $calendar_url);
  }

  method set_contacts_url (Str() $contacts_url) {
    e_source_goa_set_contacts_url($!esg, $contacts_url);
  }

  method set_name (Str() $name) {
    e_source_goa_set_name($!esg, $name);
  }
}
