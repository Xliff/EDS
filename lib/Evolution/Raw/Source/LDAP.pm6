use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::LADP;

### /usr/include/evolution-data-server/libedataserver/e-source-ldap.h

sub e_source_ldap_dup_filter (ESourceLDAP $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_ldap_dup_root_dn (ESourceLDAP $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_authentication (ESourceLDAP $extension)
  returns ESourceLDAPAuthentication
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_can_browse (ESourceLDAP $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_filter (ESourceLDAP $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_limit (ESourceLDAP $extension)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_root_dn (ESourceLDAP $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_scope (ESourceLDAP $extension)
  returns ESourceLDAPScope
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_security (ESourceLDAP $extension)
  returns ESourceLDAPSecurity
  is native(eds)
  is export
{ * }

sub e_source_ldap_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_authentication (
  ESourceLDAP               $extension,
  ESourceLDAPAuthentication $authentication
)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_can_browse (ESourceLDAP $extension, gboolean $can_browse)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_filter (ESourceLDAP $extension, Str $filter)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_limit (ESourceLDAP $extension, guint $limit)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_root_dn (ESourceLDAP $extension, Str $root_dn)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_scope (ESourceLDAP $extension, ESourceLDAPScope $scope)
  is native(eds)
  is export
{ * }

sub e_source_ldap_set_security (
  ESourceLDAP         $extension,
  ESourceLDAPSecurity $security
)
  is native(eds)
  is export
{ * }
