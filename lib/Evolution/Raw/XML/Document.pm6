use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;
use LibXML::Raw;

unit package Evolution::Raw::XML::Document;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-xml-document.h

sub e_xml_document_add_attribute (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name,
  Str          $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_attribute_double (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name,
  gdouble      $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_attribute_int (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name,
  gint64       $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_attribute_time (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name,
  time_t       $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_attribute_time_ical (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name,
  time_t       $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_empty_element (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_add_namespaces (
  EXmlDocument $xml,
  Str          $ns_prefix,
  Str          $ns_href
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_end_element (EXmlDocument $xml)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_get_content (
  EXmlDocument $xml,
  gsize        $out_length
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_xml_document_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_xml_document_get_xmldoc (EXmlDocument $xml)
  returns xmlDoc
  is      native(eds)
  is      export
{ * }

sub e_xml_document_new (
  Str $ns_href,
  Str $root_element
)
  returns EXmlDocument
  is      native(eds)
  is      export
{ * }

sub e_xml_document_start_element (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_start_text_element (
  EXmlDocument $xml,
  Str          $ns_href,
  Str          $name
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_base64 (
  EXmlDocument $xml,
  Str          $value,
  gint         $len
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_buffer (
  EXmlDocument $xml,
  Str          $value,
  gint         $len
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_double (
  EXmlDocument $xml,
  gdouble      $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_int (
  EXmlDocument $xml,
  gint64       $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_string (
  EXmlDocument $xml,
  Str          $value
)
  is      native(eds)
  is      export
{ * }

sub e_xml_document_write_time (
  EXmlDocument $xml,
  time_t       $value
)
  is      native(eds)
  is      export
{ * }
