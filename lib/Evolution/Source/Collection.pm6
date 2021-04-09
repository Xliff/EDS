use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Collection;

use Evolution::Source::Backend;

our subset ESourceCollectionAncestry is export of Mu
  where ESourceCollection | ESourceBackendAncestry;

class Evolution::Source::Collection is Evolution::Source::Backend {
  has ESourceCollection $!esc;

  submethod BUILD (:$backend) {
    self.setESourceCollection($backend) if $backend;
  }

  method setESourceCollection (ESourceCollectionAncestry $_) {
    my $to-parent;

    $!esc = do {
      when ESourceCollection {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceCollection, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceCollection
  { $!esc }

  multi method new (ESourceCollectionAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }

  method allow_sources_rename is rw {
    Proxy.new:
      FETCH => -> $     { self.get_allow_sources_rename    },
      STORE => -> $, \v { self.set_allow_sources_rename(v) }
  }

  method calendar_enabled is rw {
    Proxy.new:
      FETCH => -> $     { self.get_calendar_enabled    },
      STORE => -> $, \v { self.set_calendar_enabled(v) }
  }

  method calendar_url is rw {
    Proxy.new:
      FETCH => -> $     { self.get_calendar_url    },
      STORE => -> $, \v { self.set_calendar_url(v) }
  }

  method contacts_enabled is rw {
    Proxy.new:
      FETCH => -> $     { self.get_contacts_enabled    },
      STORE => -> $, \v { self.set_contacts_enabled(v) }
  }

  method contacts_url is rw {
    Proxy.new:
      FETCH => -> $     { self.get_contacts_url    },
      STORE => -> $, \v { self.set_contacts_url(v) }
  }

  method identity is rw {
    Proxy.new:
      FETCH => -> $     { self.get_identity    },
      STORE => -> $, \v { self.set_identity(v) }
  }

  method mail_enabled is rw {
    Proxy.new:
      FETCH => -> $     { self.get_mail_enabled    },
      STORE => -> $, \v { self.set_mail_enabled(v) }
  }

  method dup_calendar_url {
    e_source_collection_dup_calendar_url($!esc);
  }

  method dup_contacts_url {
    e_source_collection_dup_contacts_url($!esc);
  }

  method dup_identity {
    e_source_collection_dup_identity($!esc);
  }

  method get_allow_sources_rename {
    e_source_collection_get_allow_sources_rename($!esc);
  }

  method get_calendar_enabled {
    so e_source_collection_get_calendar_enabled($!esc);
  }

  method get_calendar_url {
    e_source_collection_get_calendar_url($!esc);
  }

  method get_contacts_enabled {
    so e_source_collection_get_contacts_enabled($!esc);
  }

  method get_contacts_url {
    e_source_collection_get_contacts_url($!esc);
  }

  method get_identity {
    e_source_collection_get_identity($!esc);
  }

  method get_mail_enabled {
    so e_source_collection_get_mail_enabled($!esc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_collection_get_type, $n, $t );
  }

  method set_allow_sources_rename (Int() $allow_sources_rename) {
    my gboolean $a = $allow_sources_rename.so.Int;

    e_source_collection_set_allow_sources_rename($!esc, $a);
  }

  method set_calendar_enabled (Int() $calendar_enabled) {
    my gboolean $c = $calendar_enabled.so.Int;

    e_source_collection_set_calendar_enabled($!esc, $c);
  }

  method set_calendar_url (Str()  $calendar_url) {
    e_source_collection_set_calendar_url($!esc, $calendar_url);
  }

  method set_contacts_enabled (Int() $contacts_enabled) {
    my gboolean $c = $contacts_enabled.so.Int;

    e_source_collection_set_contacts_enabled($!esc, $c);
  }

  method set_contacts_url (Str() $contacts_url) {
    e_source_collection_set_contacts_url($!esc, $contacts_url);
  }

  method set_identity (Str() $identity) {
    e_source_collection_set_identity($!esc, $identity);
  }

  method set_mail_enabled (Int() $mail_enabled) {
    my gboolean $m = $mail_enabled.so.Int;

    e_source_collection_set_mail_enabled($!esc, $m);
  }

}
