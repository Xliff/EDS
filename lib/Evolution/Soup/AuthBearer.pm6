use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use SOUP::Auth;

our subset ESoupAuthBearerAncestry is export of Mu
  where ESoupAuthBearer | SoupAuth;

class Evolution::SOUP::AuthBearer is SOUP::Auth {
  has ESoupAuthBearer $!esab;

  submethod BUILD (:$auth-bearer) {
    self.setESoupAuthBearer($auth-bearer) if $auth-bearer;
  }

  method setESoupAuthBearer (ESoupAuthBearerAncestry $_) {
    my $to-parent;

    $!esab = do {
      when ESoupAuthBearer {
        $to-parent = cast(SoupAuth, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESoupAuthBearer, $_);
      }
    }
    self.setSoupAuth($to-parent);
  }

  method Evolution::Raw::Structs::ESoupAuthBearer
  { $!esab }

  method new (ESoupAuthBearerAncestry $auth-bearer, :$ref = True) {
    return Nil unless $auth-bearer;

    my $o = self.bless( :$auth-bearer );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_soup_auth_bearer_get_type, $n, $t );
  }

  method is_expired {
    so e_soup_auth_bearer_is_expired($!esab);
  }

  method set_access_token (Str() $access_token, Int() $expires_in_seconds) {
    my gint $e = $expires_in_seconds;

    so e_soup_auth_bearer_set_access_token($!esab, $access_token, $e);
  }

}

### /usr/include/evolution-data-server/libedataserver/e-soup-auth-bearer.h

sub e_soup_auth_bearer_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_soup_auth_bearer_is_expired (ESoupAuthBearer $bearer)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_soup_auth_bearer_set_access_token (
  ESoupAuthBearer $bearer,
  Str             $access_token,
  gint            $expires_in_seconds
)
  is native(eds)
  is export
{ * }
