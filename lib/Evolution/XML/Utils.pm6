use v6.c;

use GLib::Raw::Traits;
use LibXML::Raw;
use Evolution::Raw::Types;
use Evolution::Raw::XML::Utils;
use Evolution::Raw::Subs;

use GLib::Roles::StaticClass;

our role Evolution::XML::Utils::Node {

  method dup_node_content {
    e_xml_dup_node_content(self.raw);
  }

  method find_child (Str() $ns_href, Str() $name, :$raw = False) {
    propReturnObject(
      e_xml_find_child(self.raw, $ns_href, $name),
      $raw,
      xmlDoc,
      construct => &create-xml-node
    );
  }

  method find_child_and_dup_content (
    Str()  $ns_href,
    Str()  $name,
          :$raw       = False
  ) {
    propReturnObject(
      e_xml_find_child_and_dup_content(self.raw, $ns_href, $name),
      $raw,
      xmlDoc,
      construct => &create-xml-node
    );
  }

  method find_child_and_get_text (Str() $ns_href, Str() $name) {
    e_xml_find_child_and_get_text(self.raw, $ns_href, $name);
  }

  # method find_children_nodes (Int() $count, ...) {
  #   my guint $c =$count,
  #
  #   e_xml_find_children_nodes($parent, $c);
  # }

  method find_in_hierarchy (
    Str()  $child_ns_href,
    Str()  $child_name,
          :$raw            = False
  ) {
    propReturnObject(
      e_xml_find_in_hierarchy(
        self.raw,
        $child_ns_href,
        $child_name,
        Str,
        Str
      ),
      $raw,
      xmlDoc,
      construct => &create-xml-node
    );
  }

  method find_next_sibling (Str() $ns_href, Str() $name, :$raw = False) {
    propReturnObject(
      e_xml_find_next_sibling(self.raw, $ns_href, $name),
      $raw,
      xmlDoc,
      construct => &create-xml-node
    );
  }

  method find_sibling (Str() $ns_href, Str() $name, :$raw = False) {
    propReturnObject(
      e_xml_find_sibling(self.raw, $ns_href, $name),
      $raw,
      xmlDoc,
      construct => &create-xml-node
    );
  }

  method get_child_by_name (Str() $child_name) {
    e_xml_get_child_by_name(self.raw, $child_name);
  }

  method get_node_text {
    e_xml_get_node_text(self.raw);
  }

  method is_element_name (Str() $ns_href, Str() $name) {
    so e_xml_is_element_name(self.raw, $ns_href, $name);
  }

}

class Evolution::XML::Utils does GLib::Roles::StaticClass {
  method init {
    e_xml_initialize_in_main();
  }
}


our role Evolution::XML::Utils::Doc {

  method new_xpath_context_with_namespaces (*@prefix-href, :$raw = False) {
    my $o = propReturnObject(
      e_xml_new_xpath_context_with_namespaces(self.raw),
      $raw,
      xmlXPathContext,

      construct => &create-xml-xpath-context
    );

    $o.register_namespaces( |$_ ) for @prefix-href.rotor(2)
  }

  method parse_data (gpointer $data, Int() $length, :$raw = False)
    is static
  {
    my gsize $l = $length;

    propReturnObject(
      e_xml_parse_data($data, $l),
      $raw,
      xmlDoc,

      construct => &create-xml-doc
    )
  }

  method parse_file (Str() $filename, :$raw = False) is static {
    propReturnObject(
      e_xml_parse_file($filename),
      $raw,
      xmlDoc,

      construct => &create-xml-doc
    );
  }

  method save_file (Str $filename, xmlDoc() $doc) is static {
    so e_xml_save_file($filename, $doc);
  }

}

our role Evolution::XML::Utils::Path::Context {

  method register_namespaces (Str() $prefix, Str() $href) {
    e_xml_xpath_context_register_namespaces(self.raw, $prefix, $href);
  }

  method eval (Str() $format, :$raw = False) {
    propReturnObject(
      e_xml_xpath_eval(self.raw, $format, Str),
      $raw,
      xmlXPathObject,
      construct       => &create-xml-xpath-object
    );
  }

  method eval_as_string (Str() $format) {
    e_xml_xpath_eval_as_string(self.raw, $format);
  }

  method eval_exists (Str() $format) {
    e_xml_xpath_eval_exists(self.raw, $format);
  }

}
