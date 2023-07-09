use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::File::Cache;

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-file-cache.h

sub e_file_cache_add_object (EFileCache $cache, Str $key, Str $value)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_clean (EFileCache $cache)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_freeze_changes (EFileCache $cache)
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_get_filename (EFileCache $cache)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_get_keys (EFileCache $cache)
  returns GSList
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_get_object (EFileCache $cache, Str $key)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_get_objects (EFileCache $cache)
  returns GSList
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_get_type ()
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_new (Str $filename)
  returns EFileCache
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_remove (EFileCache $cache)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_remove_object (EFileCache $cache, Str $key)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_replace_object (EFileCache $cache, Str $key, Str $new_value)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_file_cache_thaw_changes (EFileCache $cache)
  is      native(ebackend)
  is      export
{ * }
