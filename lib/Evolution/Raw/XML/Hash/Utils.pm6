use v6.c;

use NativeCall;

use LibXML::Raw;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::XML::Hash::Utils;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-xml-hash-utils.h

sub e_xmlhash_add (EXmlHash $hash, Str $key, Str $data)
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_compare (EXmlHash $hash, Str $key, Str $compare_data)
  returns EXmlHashStatus
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_destroy (EXmlHash $hash)
  is      native(eds)
  is      export
{ * }

sub e_xml_destroy_hash (GHashTable $hash)
  is      native(eds)
  is      export
{ * }

sub e_xml_from_hash (GHashTable $hash, EXmlHashType $type, Str $root_name)
  returns xmlDoc
  is      native(eds)
  is      export
{ * }

sub e_xml_to_hash (xmlDoc $doc, EXmlHashType $type)
  returns GHashTable
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_foreach_key (
  EXmlHash $hash,
           &func (Str, Str, gpointer),
  gpointer $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_foreach_key_remove (
  EXmlHash $hash,
           &func (Str, Str, gpointer --> gboolean),
  gpointer $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_new (Str $filename)
  returns EXmlHash
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_remove (EXmlHash $hash, Str $key)
  is      native(eds)
  is      export
{ * }

sub e_xmlhash_write (EXmlHash $hash)
  is      native(eds)
  is      export
{ * }
