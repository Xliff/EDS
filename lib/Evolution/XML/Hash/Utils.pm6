use v6.c;

use LibXML::Raw;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::XML::Hash::Utils;

use GLib::Roles::Implementor;

class Evolution::XML::Hash::Utils {
  has EXmlHash $!eds-xh is implementor;

  method new (Str() $filename) {
    my $e-xml-hash = e_xmlhash_new($filename);

    $e-xml-hash ?? self.bless( :$e-xml-hash ) !! Nil;
  }

  method add (Str() $key, Str() $data) {
    e_xmlhash_add($!eds-xh, $key, $data);
  }

  method compare (Str() $key, Str() $compare_data) {
    so e_xmlhash_compare($!eds-xh, $key, $compare_data);
  }

  method destroy {
    e_xmlhash_destroy($!eds-xh);
  }

  method destroy_hash (GHashTable() $hash) is static {
    e_xml_destroy_hash($hash);
  }

  proto method xml_from_hash (|)
    is static
  { * }

  multi method xml_from_hash (
           %hash,
    Int()  $type,
    Str()  $root_name,
          :$raw        = False
  ) {
    samewith( GLib::HashTable.new(%hash), $type, $root_name, :$raw );
  }
  multi method xml_from_hash (
    GHashTable()  $hash,
    Int()         $type,
    Str()         $root_name,
                 :$raw        = False
  ) {
    my EXmlHashType $t = $type;

    propReturnObject(
      e_xml_from_hash($hash, $t, $root_name),
      $raw,
      xmlDoc,
      LibXML::Doc,
      construct => &create-xml-doc
    )
  }

  proto method xml_to_hash (|)
    is static
  { * }

  multi method xml_to_hash (
           $doc   where *.^can('xmlDoc'),
    Int()  $type,
          :$raw                           = False,
          :$hash                          = True;
  ) {
    my $d = $doc;
    $d .= xmlDoc unless $d ~~ xmlDoc;

    my EXmlHashType $t = $type;

    my $gh = propReturnObject(
      e_xml_to_hash($d, $t),
      $raw,
      |GLib::HashTable.getTypePair
    );
    return $gh unless $hash;
    $gh.Hash;
  }
  multi method xml_to_hash ($doc, $type) {
    X::GLib::UnknownType.new(
      "Evolution::XML::Hash.xml-to-hash does not know how to handle a {
        $doc.^name }. Must be xmlDoc-compatible!";
    ).throw;
  }

  method foreach_key (&func, gpointer $user_data = gpointer) {
    e_xmlhash_foreach_key($!eds-xh, &func, $user_data);
  }

  method foreach_key_remove (&func, gpointer $user_data = gpointer) {
    e_xmlhash_foreach_key_remove($!eds-xh, &func, $user_data);
  }

  method remove (Str() $key) {
    e_xmlhash_remove($!eds-xh, $key);
  }

  method write {
    e_xmlhash_write($!eds-xh);
  }

}
