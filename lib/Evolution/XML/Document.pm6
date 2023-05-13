use v6.c;

use Method::Also;

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
    is also<EXmlDocument>
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

  method add_attribute (Str() $ns_href, Str() $name, Str() $value)
    is also<add-attribute>
  {
    e_xml_document_add_attribute($!eds-xd, $ns_href, $name, $value);
  }

  method add_attribute_double (Str() $ns_href, Str() $name, Num() $value)
    is also<add-attribute-double>
  {
    my gdouble $v = $value;

    e_xml_document_add_attribute_double($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_int (Str() $ns_href, Str() $name, Int() $value)
    is also<add-attribute-int>
  {
    my gint64 $v = $value;

    e_xml_document_add_attribute_int($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_time (Str() $ns_href, Str() $name, Int() $value)
    is also<add-attribute-time>
  {
    my time_t $v = $value;

    e_xml_document_add_attribute_time($!eds-xd, $ns_href, $name, $v);
  }

  method add_attribute_time_ical (Str() $ns_href, Str() $name, Int() $value)
    is also<add-attribute-time-ical>
  {
    my time_t $v = $value;

    e_xml_document_add_attribute_time_ical($!eds-xd, $ns_href, $name, $v);
  }

  method add_empty_element (Str() $ns_href, Str() $name)
    is also<add-empty-element>
  {
    e_xml_document_add_empty_element($!eds-xd, $ns_href, $name);
  }

  method add_namespaces (Str() $ns_prefix, Str() $ns_href)
    is also<add-namespaces>
  {
    e_xml_document_add_namespaces($!eds-xd, $ns_prefix, $ns_href);
  }

  method end_element is also<end-element> {
    e_xml_document_end_element($!eds-xd);
  }

  proto method get_content (|)
    is also<get-content>
  { * }

  multi method get_content {
    samewith($);
  }
  multi method get_content ($out_length is rw) {
    my gsize $o = 0;

    e_xml_document_get_content($!eds-xd, $o);
    $out_length = $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_xml_document_get_type, $n, $t );
  }

  method get_xmldoc ( :$raw = False ) is also<get-xmldoc> {
    propReturnObject(
      e_xml_document_get_xmldoc($!eds-xd),
      $raw,
      xmlDoc,
      LibXML::Document,
      construct         => &create-xml-document
    )
  }

  method start_element (Str() $ns_href, Str() $name) is also<start-element> {
    e_xml_document_start_element($!eds-xd, $ns_href, $name);
  }

  method start_text_element (Str() $ns_href, Str() $name)
    is also<start-text-element>
  {
    e_xml_document_start_text_element($!eds-xd, $ns_href, $name);
  }

  method write_base64 (Str() $value, Int() $len) is also<write-base64> {
    my gint $l = $len;

    e_xml_document_write_base64($!eds-xd, $value, $l);
  }

  method write_buffer (Str() $value, Int() $len) is also<write-buffer> {
    my gint $l = $len;

    e_xml_document_write_buffer($!eds-xd, $value, $l);
  }

  method write_double (Num() $value) is also<write-double> {
    my gdouble $v = $value;

    e_xml_document_write_double($!eds-xd, $v);
  }

  method write_int (Int() $value) is also<write-int> {
    my gint64 $v = $value;

    e_xml_document_write_int($!eds-xd, $v);
  }

  method write_string (Str() $value) is also<write-string> {
    e_xml_document_write_string($!eds-xd, $value);
  }

  method write_time (Int() $value) is also<write-time> {
    my time_t $v = $value;

    e_xml_document_write_time($!eds-xd, $v);
  }

}
