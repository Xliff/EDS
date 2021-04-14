use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::LDAP;

use Evolution::Source::Extension;

our subset ESourceLDAPAncestry is export of Mu
  where ESourceLDAP | ESourceExtensionAncestry;

class Evolution::Source::LDAP is Evolution::Source::Extension {
  has ESourceLDAP $!esl is implementor;

  submethod BUILD (:$ldap) {
    self.setESourceLDAP($ldap) if $ldap;
  }

  method setESourceLDAP (ESourceLDAPAncestry $_) {
    my $to-parent;

    $!esl = do {
      when ESourceLDAP {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceLDAP, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceLDAP
  { $!esl }

  method new (ESourceLDAPAncestry $ldap, :$ref = True) {
    return Nil unless $ldap;

    my $o = self.bless( :$ldap );
    $o.ref if $ref;
    $o;
  }

  method authentication is rw {
    Proxy.new:
      FETCH => -> $     { self.get_authentication    },
      STORE => -> $, \v { self.set_authentication(v) }
  }

  method can_browse is rw {
    Proxy.new:
      FETCH => -> $     { self.get_can_browse    },
      STORE => -> $, \v { self.set_can_browse(v) }
  }

  method filter is rw {
    Proxy.new:
      FETCH => -> $     { self.get_filter    },
      STORE => -> $, \v { self.set_filter(v) }
  }

  method limit is rw {
    Proxy.new:
      FETCH => -> $     { self.get_limit    },
      STORE => -> $, \v { self.set_limit(v) }
  }

  method root_dn is rw {
    Proxy.new:
      FETCH => -> $     { self.get_root_dn    },
      STORE => -> $, \v { self.set_root_dn(v) }
  }

  method scope is rw {
    Proxy.new:
      FETCH => -> $     { self.get_scope    },
      STORE => -> $, \v { self.set_scope(v) }
  }

  method security is rw {
    Proxy.new:
      FETCH => -> $     { self.get_security    },
      STORE => -> $, \v { self.set_security(v) }
  }

  method dup_filter {
    e_source_ldap_dup_filter($!esl);
  }

  method dup_root_dn {
    e_source_ldap_dup_root_dn($!esl);
  }

  method get_authentication {
    ESourceLDAPAuthenticationEnum( e_source_ldap_get_authentication($!esl) );
  }

  method get_can_browse {
    e_source_ldap_get_can_browse($!esl);
  }

  method get_filter {
    e_source_ldap_get_filter($!esl);
  }

  method get_limit {
    e_source_ldap_get_limit($!esl);
  }

  method get_root_dn {
    e_source_ldap_get_root_dn($!esl);
  }

  method get_scope {
    ESourceLDAPScopeEnum( e_source_ldap_get_scope($!esl) );
  }

  method get_security {
    ESourceLDAPSecurityEnum( e_source_ldap_get_security($!esl) );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_ldap_get_type, $n, $t );
  }

  method set_authentication (Int() $ldap) {
    my ESourceLDAPAuthentication $a = $ldap;

    e_source_ldap_set_authentication($!esl, $a);
  }

  method set_can_browse (gboolean $can_browse) {
    my gboolean $c = $can_browse.so.Int;

    e_source_ldap_set_can_browse($!esl, $c);
  }

  method set_filter (Str() $filter) {
    e_source_ldap_set_filter($!esl, $filter);
  }

  method set_limit (Int() $limit) {
    my guint $l = $limit;

    e_source_ldap_set_limit($!esl, $l);
  }

  method set_root_dn (Str() $root_dn) {
    e_source_ldap_set_root_dn($!esl, $root_dn);
  }

  method set_scope (Int() $scope) {
    my ESourceLDAPScope $s = $scope;

    e_source_ldap_set_scope($!esl, $s);
  }

  method set_security (Int() $security) {
    my ESourceLDAPSecurity $s = $security;

    e_source_ldap_set_security($!esl, $s);
  }

}
