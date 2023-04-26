use v6.c;

use LibXML::Raw;
use Evolution::Raw::Types;
use Evolution::Raw::XML::Document;

use GLib::Roles::Object;
use GLib::Roles::Implementor;


our subset EXmlDocumentAncestry is export of Mu
  where EXmlDocument | GObject;

class Evolution::XML::Document {
  also does GLib::Roles::Object;

  has EXmlDocument $!eds-xd is implementor;

  submethod BUILD ( :$e-xml-doc ) {
    self.setEXmlDocument($e-xml-doc) if $e-xml-doc
  }

  method setEXmlDocument (EXmlDocumentAncestry $_) {
    my $to-parent;

    $!eds-xd = do {
      when EXmlDocument {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EXmlDocument, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EXmlDocument
  { $!eds-xd }

  multi method new (
    $e-xml-doc where * ~~ EXmlDocumentAncestry,

    :$ref = True
  ) {
    return unless $e-xml-doc;

    my $o = self.bless( :$e-xml-doc );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $ns_href, Str() $root_element) {
    my $e-xml-doc = e_xml_document_new($ns_href, $root_element);

    $e-xml-doc ?? self.bless( :$e-xml-doc ) !! Nil;
  }

  method add_attribute (Str() $ns_href, Str() $name, Str() $value) {
    e_xml_document_add_attribute($!eds-xd, $ns_href, $name, $value);
  }

  method add_attribute_double (Str() $ns_href, Str() $name, Num() $value) {
    my gdouble $v = $value;

    e_xml_document_add_attribute_double($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_int (Str() $ns_href, Str() $name, Int() $value) {
    my gint64 $v = $value;

    e_xml_document_add_attribute_int($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_time (Str() $ns_href, Str() $name, Int() $value) {
    my time_t $v = $value;

    e_xml_document_add_attribute_time($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_time_ical (Str() $ns_href, Str() $name, Int() $value) {
    my time_t $v = $value;

    e_xml_document_add_attribute_time_ical($!eds-xd, $ns_href, $name, $v);
  }

  method add_empty_element (Str() $ns_href, Str() $name) {
    e_xml_document_add_empty_element($!eds-xd, $ns_href, $name);
  }

  method add_namespaces (Str() $ns_prefix, Str() $ns_href) {
    e_xml_document_add_namespaces($!eds-xd, $ns_prefix, $ns_href);
  }

  method end_element {
    e_xml_document_end_element($!eds-xd);
  }

  method get_content (Int() $out_length) {
    my gsize $o = $out_length;

    e_xml_document_get_content($!eds-xd, $o);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_xml_document_get_type, $n, $t );
  }

  method get_xmldoc ( :$raw = False ) {
    propReturnObject(
      e_xml_document_get_xmldoc($!eds-xd),
      $raw,
      xmlDoc,
      LibXML::Document,

      construct => -> $raw, :$ref {
        my $o = LibXML::Document.new( :$raw ),
        $o.ref if $ref,
        $o
      }
    )
  }

  method start_element (Str() $ns_href, Str() $name) {
    e_xml_document_start_element($!eds-xd, $ns_href, $name);
  }

  method start_text_element (Str() $ns_href, Str() $name) {
    e_xml_document_start_text_element($!eds-xd, $ns_href, $name);
  }

  method write_base64 (Str() $value, Int() $len) {
    my gint $l = $len;

    e_xml_document_write_base64($!eds-xd, $value, $l);
  }

  method write_buffer (Str() $value, Int() $len) {
    my gint $l = $len;

    e_xml_document_write_buffer($!eds-xd, $value, $l);
  }

  method write_double (Num() $value) {
    my gdouble $v = $value;

    e_xml_document_write_double($!eds-xd, $v);
  }

  method write_int (Int() $value) {
    my gint64 $v = $value;

    e_xml_document_write_int($!eds-xd, $v);
  }

  method write_string (Str() $value) {
    e_xml_document_write_string($!eds-xd, $value);
  }

  method write_time (Int() $value) {
    my time_t $v = $value;

    e_xml_document_write_time($!eds-xd, $v);
  }

}
