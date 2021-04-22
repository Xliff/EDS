use v6.c;

use GLib::Raw::Types;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::VCard;

### /usr/include/evolution-data-server/libebook-contactss/e-vcard.h

sub e_vcard_add_attribute (EVCard $evc, EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_add_attribute_with_value (
  EVCard          $evcard,
  EVCardAttribute $attr,
  Str             $value
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_add_attribute_with_values (EVCard $evcard, EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_append_attribute (EVCard $evc, EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_append_attribute_with_value (
  EVCard          $evcard,
  EVCardAttribute $attr,
  Str $value
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_append_attribute_with_values (
  EVCard          $evcard,
  EVCardAttribute $attr
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_param (
  EVCardAttribute      $attr,
  EVCardAttributeParam $param
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_param_with_value (
  EVCardAttribute      $attr,
  EVCardAttributeParam $param,
  Str                  $value
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_param_with_values (
  EVCardAttribute      $attr,
  EVCardAttributeParam $param
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_value (EVCardAttribute $attr, Str $value)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_value_decoded (
  EVCardAttribute $attr,
  Str             $value,
  gint            $len
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_add_values (EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_copy (EVCardAttribute $attr)
  returns EVCardAttribute
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_free (EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_group (EVCardAttribute $attr)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_name (EVCardAttribute $attr)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_param (EVCardAttribute $attr, Str $name)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_params (EVCardAttribute $attr)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_value (EVCardAttribute $attr)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_value_decoded (EVCardAttribute $attr)
  returns GString
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_values (EVCardAttribute $attr)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_get_values_decoded (EVCardAttribute $attr)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_has_type (EVCardAttribute $attr, Str $typestr)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_is_single_valued (EVCardAttribute $attr)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_new (Str $attr_group, Str $attr_name)
  returns EVCardAttribute
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_add_value (EVCardAttributeParam $param, Str $value)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_add_values (EVCardAttributeParam $param)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_copy (EVCardAttributeParam $param)
  returns EVCardAttributeParam
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_free (EVCardAttributeParam $param)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_get_name (EVCardAttributeParam $param)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_get_values (EVCardAttributeParam $param)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_new (Str $name)
  returns EVCardAttributeParam
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_param_remove_values (EVCardAttributeParam $param)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_remove_param (EVCardAttribute $attr, Str $param_name)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_remove_param_value (
  EVCardAttribute $attr,
  Str             $param_name,
  Str             $s
)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_remove_params (EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_remove_value (EVCardAttribute $attr, Str $s)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_attribute_remove_values (EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_construct (EVCard $evc, Str $str)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_construct_full (EVCard $evc, Str $str, gssize $len, Str $uid)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_construct_with_uid (EVCard $evc, Str $str, Str $uid)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_dump_structure (EVCard $evc)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_escape_string (Str $s)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_get_attribute (EVCard $evc, Str $name)
  returns EVCardAttribute
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_get_attribute_if_parsed (EVCard $evc, Str $name)
  returns EVCardAttribute
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_get_attributes (EVCard $evcard)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_is_parsed (EVCard $evc)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_new ()
  returns EVCard
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_new_from_string (Str $str)
  returns EVCard
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_remove_attribute (EVCard $evc, EVCardAttribute $attr)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_remove_attributes (EVCard $evc, Str $attr_group, Str $attr_name)
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_to_string (EVCard $evc, EVCardFormat $format)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_unescape_string (Str $s)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_util_dup_x_attribute (EVCard $vcard, Str $x_name)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_vcard_util_set_x_attribute (EVCard $vcard, Str $x_name, Str $value)
  is native(ebook-contacts)
  is export
{ * }
