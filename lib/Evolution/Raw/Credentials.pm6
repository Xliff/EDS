use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Credentials;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-credentials.h

sub e_credentials_clear (ECredentials $credentials)
  is      native(eds)
  is      export
{ * }

sub e_credentials_clear_peek (ECredentials $credentials)
  is      native(eds)
  is      export
{ * }

sub e_credentials_equal (
  ECredentials $credentials1,
  ECredentials $credentials2
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_equal_keys (
  ECredentials $credentials1,
  ECredentials $credentials2,
  Str          $key1
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_free (ECredentials $credentials)
  is      native(eds)
  is      export
{ * }

sub e_credentials_get (
  ECredentials $credentials,
  Str          $key
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_credentials_has_key (
  ECredentials $credentials,
  Str          $key
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_credentials_keys_size (ECredentials $credentials)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_credentials_list_keys (ECredentials $credentials)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_credentials_new
  returns ECredentials
  is      native(eds)
  is      export
{ * }

sub e_credentials_new_args (Str $key)
  returns ECredentials
  is      native(eds)
  is      export
{ * }

sub e_credentials_new_clone (ECredentials $credentials)
  returns ECredentials
  is      native(eds)
  is      export
{ * }

sub e_credentials_new_strv (CArray[Str] $strv)
  returns ECredentials
  is      native(eds)
  is      export
{ * }

sub e_credentials_peek (
  ECredentials $credentials,
  Str          $key
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_credentials_set (
  ECredentials $credentials,
  Str          $key,
  Str          $value
)
  is      native(eds)
  is      export
{ * }

sub e_credentials_to_strv (ECredentials $credentials)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_credentials_util_prompt_flags_to_string (guint $prompt_flags)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_credentials_util_safe_free_string (Str $str)
  is      native(eds)
  is      export
{ * }

sub e_credentials_util_string_to_prompt_flags (Str $prompt_flags_string)
  returns guint
  is      native(eds)
  is      export
{ * }
