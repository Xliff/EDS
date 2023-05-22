use v6.c;

use NativeCall;

use LibXML::Raw;
use LibXML::Raw::Defs :xmlCharP;
use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-xml-utils.h

sub e_xml_dup_node_content (xmlNode $node)
  returns xmlCharP
  is      native(eds)
  is      export
{ * }

sub e_xml_find_child (xmlNode $parent, Str $ns_href, Str $name)
  returns xmlNode
  is      native(eds)
  is      export
{ * }

sub e_xml_find_child_and_dup_content (xmlNode, Str, Str)
  returns xmlCharP
  is      native(eds)
  is      export
{ * }

sub e_xml_find_child_and_get_text (xmlNode $parent, Str $ns_href, Str $name)
  returns xmlCharP
  is      native(eds)
  is      export
{ * }

sub e_xml_find_children_nodes (xmlNode $parent, guint $count)
  is      native(eds)
  is      export
{ * }

sub e_xml_find_in_hierarchy (
  xmlNode $parent,
  Str     $child_ns_href,
  Str     $child_name,
  # Null termination
  Str,
  Str
)
  returns xmlNode
  is      native(eds)
  is      export
{ * }

sub e_xml_find_next_sibling (xmlNode $sibling, Str $ns_href, Str $name)
  returns xmlNode
  is      native(eds)
  is      export
{ * }

sub e_xml_find_sibling (xmlNode $sibling, Str $ns_href, Str $name)
  returns xmlNode
  is      native(eds)
  is      export
{ * }

sub e_xml_get_child_by_name (xmlNode $parent, xmlCharP $child_name)
  returns xmlNode
  is      native(eds)
  is      export
{ * }

sub e_xml_get_node_text (xmlNode $node)
  returns xmlCharP
  is      native(eds)
  is      export
{ * }

sub e_xml_initialize_in_main
  is      native(eds)
  is      export
{ * }

sub e_xml_is_element_name (xmlNode $node, Str $ns_href, Str $name)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_xml_new_xpath_context_with_namespaces (xmlDoc $doc)
  returns xmlXPathContext
  is      native(eds)
  is      export
{ * }

sub e_xml_parse_data (gpointer $data, gsize $length)
  returns xmlDoc
  is      native(eds)
  is      export
{ * }

sub e_xml_parse_file (Str $filename)
  returns xmlDoc
  is      native(eds)
  is      export
{ * }

sub e_xml_save_file (Str $filename, xmlDoc $doc)
  returns gint
  is      native(eds)
  is      export
{ * }

sub e_xml_xpath_context_register_namespaces (
  xmlXPathContext $xpath_ctx,
  Str             $prefix,
  Str             $href
)
  is      native(eds)
  is      export
{ * }

sub e_xml_xpath_eval (xmlXPathContext $xpath_ctx, Str $format, Str)
  returns xmlXPathObject
  is      native(eds)
  is      export
{ * }

sub e_xml_xpath_eval_as_string (xmlXPathContext $xpath_ctx, Str $format)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_xml_xpath_eval_exists (xmlXPathContext $xpath_ctx, Str $format)
  returns uint32
  is      native(eds)
  is      export
{ * }
