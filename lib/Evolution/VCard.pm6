use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::VCard;

use GLib::GList;

use GLib::Roles::Object;

class Evolution::VCard::Attribute        { ... }
class Evolution::VCard::Attribute::Param { ... }

sub checkListCompatible (@values, \T) {
  @values.map({
    do unless $_ ~~ T {
      my $TN = T.^name;
      do if   .^lookup($TN) -> $m { $m($_) }
         else                     { die "@values must be { $TN }-compatible!" }
    }
  });
}

our subset EVCardAncestry is export of Mu
  where EVCard | GObject;

class Evolution::VCard {
  also does GLib::Roles::Object;

  has EVCard $!evc;

  submethod BUILD (:$vcard) {
    self.setEVCard($vcard) if $vcard;
  }

  method setEVCard (EVCardAncestry $_) {
    my $to-parent;

    $!evc = do {
      when EVCard {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EVCard, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EVCard
    is also<EVCard>
  { $!evc }

  multi method new (EVCardAncestry $evcard, :$ref = True) {
    return Nil unless $evcard;

    my $o = self.bless( :$evcard );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $evcard = e_vcard_new();

    $evcard ?? self.bless( :$evcard ) !! Nil;
  }

  method new_from_string (Str() $str) is also<new-from-string> {
    my $evcard = e_vcard_new_from_string($str);

    $evcard ?? self.bless( :$evcard ) !! Nil;
  }

  method !checkAttr ($a) {
    X::Evolution::VCard::AttributeVersionMismatch.new(
      .getVersion,
      $a.version
    ).throw unless $a.version == self.getVersion;
  }

  method add_attribute (EVCardAttribute() $attr) is also<add-attribute> {
    self!checkAttr($attr);
    e_vcard_add_attribute($!evc, $attr);
  }

  method add_attribute_with_value (EVCardAttribute() $attr, Str() $value)
    is also<add-attribute-with-value>
  {
    self!checkAttr($attr);
    e_vcard_add_attribute_with_value($!evc, $attr, $value);
  }

  method add_attribute_with_values (EVCardAttribute() $attr, *@values)
    is also<add-attribute-with-values>
  {
    self!checkAttr($attr);
    #e_vcard_add_attribute_with_values($!evc, $attr);
    $attr.add_value($_) for checkListCompatible(@values, Str);
    self.add_attribute($attr);
  }

  method append_attribute (EVCardAttribute() $attr) is also<append-attribute> {
    self!checkAttr($attr);
    e_vcard_append_attribute($!evc, $attr);
  }

  method append_attribute_with_value (EVCardAttribute() $attr, Str() $value)
    is also<append-attribute-with-value>
  {
    self!checkAttr($attr);
    e_vcard_append_attribute_with_value($!evc, $attr, $value);
  }

  method append_attribute_with_values (EVCardAttribute $attr, *@values)
    is also<append-attribute-with-values>
  {
    self!checkAttr($attr);
    #e_vcard_append_attribute_with_values($!evc, $attr);
    $attr.add_value($_) for checkListCompatible(@values, Str);
    self.append_attribute($attr);
  }

  method construct (Str() $str) {
    e_vcard_construct($!evc, $str);
  }

  proto method construct_full (|)
      is also<construct-full>
  { * }

  multi method construct_full (Str() $str, Str() $uid) {
    samewith($str, -1, $uid);
  }
  multi method construct_full (Str() $str, Int() $len, Str() $uid) {
    my gssize $l = $len;

    e_vcard_construct_full($!evc, $str, $len, $uid);
  }

  method construct_with_uid (Str() $str, Str() $uid)
    is also<construct-with-uid>
  {
    e_vcard_construct_with_uid($!evc, $str, $uid);
  }

  method dump_structure is also<dump-structure> {
    e_vcard_dump_structure($!evc);
  }

  method escape_string (Evolution::VCard:U: Str() $string)
    is also<escape-string>
  {
    e_vcard_escape_string($string);
  }

  method get_attribute (Str() $name, :$raw = False) is also<get-attribute> {
    my $a = e_vcard_get_attribute($!evc, $name);

    $a ??
      ( $raw ?? $a !! Evolution::VCard::Attribute.new($a) )
      !!
      Nil;
  }

  method get_attribute_if_parsed (Str() $name, :$raw = False)
    is also<get-attribute-if-parsed>
  {
    my $a = e_vcard_get_attribute_if_parsed($!evc, $name);

    $a ??
      ( $raw ?? $a !! Evolution::VCard::Attribute.new($a) )
      !!
      Nil;
  }

  method get_attributes (:$glist = False, :$raw = False)
    is also<get-attributes>
  {
    returnGList(
      e_vcard_get_attributes($!evc),
      $glist,
      $raw,
      EVCardAttribute,
      Evolution::VCard::Attribute
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_vcard_get_type, $n, $t );
  }

  method getVersion {
    my $v = self.get-attribute('version') // self.get-attribute('VERSION');
    given $v {
      when    '2.1' { ver2_1 }
      when    '3.0' { ver3   }
      when    '4.0' { ver4   }

      default       { ver3   }
    }
  }

  method is_parsed is also<is-parsed> {
    so e_vcard_is_parsed($!evc);
  }

  method remove_attribute (EVCardAttribute() $attr) is also<remove-attribute> {
    e_vcard_remove_attribute($!evc, $attr);
  }

  method remove_attributes (Str() $attr_group, Str() $attr_name)
    is also<remove-attributes>
  {
    e_vcard_remove_attributes($!evc, $attr_group, $attr_name);
  }

  method to_string (Int() $format = EVC_FORMAT_VCARD_30)
    is also<
      to-string
      Str
    >
  {
    my EVCardFormat $f = $format;

    e_vcard_to_string($!evc, $f);
  }

  method unescape_string (Evolution::VCard:U: Str() $string)
    is also<unescape-string>
  {
    e_vcard_unescape_string($string);
  }

  method util_dup_x_attribute (Str() $x_name) is also<util-dup-x-attribute> {
    e_vcard_util_dup_x_attribute($!evc, $x_name);
  }

  method util_set_x_attribute (Str() $x_name, Str() $value)
    is also<util-set-x-attribute>
  {
    e_vcard_util_set_x_attribute($!evc, $x_name, $value);
  }

}

# Boxed
class Evolution::VCard::Attribute {
  # Attribute default encodings...
  # As per https://android.stackexchange.com/questions/106888/what-vcard-formats-versions-and-encodings-are-supported-for-import
  # 2.1 => ASCII
  # 3.0 => Speficied as charset in attribuet,
  # 4.0 => UTF8
  #
  # As of this writing, we are supporting 2.1 and 3.0
  #
  # Note that VCards and VCard attributes are DECOUPLED! There is no mechanism
  # for an attribute to query its parent version, so this mechanism must be
  # created.
  #
  # As of this writing, the default version will be 3.0. Attributes can reset
  # their version at CREATION TIME via a named parameter
  #
  # Attribues added to VCards must now have a version check with an exception
  # thrown if versions mismatch.
  has EVCardAttribute $!evca;
  has                 $.version;

  submethod BUILD (:$attribute, :$!version = ver3) {
    $!evca = $attribute;

    if $!version == ver3 {
      my $param = Evolution::VCard::Attribute::Param.new_with_value(
        'charset',
        self.getAttrCharset
      );
      self.add-param($param);
    }
  }

  method EVolution::Raw::Structs::EVCardAttribute
    is also<EVCardAttribute>
  { $!evca }

  multi method new (Str() $attr-name, :$name is required) {
    samewith(Str, $attr-name);
  }
  multi method new (Str() $group, Str() $attr_name) {
    my $attribute = e_vcard_attribute_new($group, $attr_name);

    $attribute ?? self.bless( :$attribute ) !! Nil;
  }
  multi method new (EVCardAttribute $attribute) {
    $attribute ?? self.bless( :$attribute ) !! Nil;
  }

  method getAttrCharset {
    do given $!version {
      when ver2_1 { 'ASCII' }
      when ver4   { 'utf8' }

      when ver3   {
        my $cs = self.get_param('charset') // self.get_param('CHARSET');
        # Default unspecified, choose previous versions!
        $cs ?? $cs !! 'ASCII'
      }
    }
  }

  method add_param (EVCardAttributeParam() $param) is also<add-param> {
    e_vcard_attribute_add_param($!evca, $param);
  }

  method add_param_with_value (EVCardAttributeParam() $param, Str() $value)
    is also<add-param-with-value>
  {
    e_vcard_attribute_add_param_with_value($!evca, $param, $value);
  }

  method add_param_with_values (EVCardAttributeParam $param, *@values)
    is also<add-param-with-values>
  {
    $param.add_value($_) for checkListCompatible(@values, Str);
    self.add_param($param);
  }

  method add_value (Str() $value) is also<add-value> {
    e_vcard_attribute_add_value($!evca, $value);
  }

  method add_value_decoded (
    Str() $value,
    Int() $len    = -1
  )
    is also<add-value-decoded>
  {
    my gint $l = $len;

    if $l == -1 {
      # cw: See comment at the top of the class definition.
      $l = $value.encode(self.getAttrCharset).bytes
    }

    e_vcard_attribute_add_value_decoded($!evca, $value, $l);
  }

  method add_values (*@values) is also<add-values> {
    self.add_value($_) for checkListCompatible(@values, Str);
  }

  method copy (:$raw = False) {
    my $copy = e_vcard_attribute_copy($!evca);

    $copy ??
      ( $raw ?? $copy !! Evolution::VCard::Attribute.new($copy, :!ref) )
      !!
      Nil;
  }

  method free {
    e_vcard_attribute_free($!evca);
  }

  method get_group is also<get-group> {
    e_vcard_attribute_get_group($!evca);
  }

  method get_name is also<get-name> {
    e_vcard_attribute_get_name($!evca);
  }

  method get_param (Str() $name, :$glist = False, :$raw = False)
    is also<get-param>
  {
    returnGList(
      e_vcard_attribute_get_param($!evca, $name),
      $glist,
      $raw
    );
  }

  method get_params (:$glist = False, :$raw = False) is also<get-params> {
    returnGList(
      e_vcard_attribute_get_params($!evca),
      $glist,
      $raw,
      EVCardAttributeParam,
      Evolution::VCard::Attribute::Param
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_vcard_attribute_get_type, $n, $t );
  }

  method get_value is also<get-value> {
    e_vcard_attribute_get_value($!evca);
  }

  method get_value_decoded is also<get-value-decoded> {
    e_vcard_attribute_get_value_decoded($!evca);
  }

  method get_values (:$glist = False, :$raw = False) is also<get-values> {
    returnGList(
      e_vcard_attribute_get_values($!evca),
      $glist,
      $raw
    )
  }

  method get_values_decoded (:$glist = False, :$raw = False)
    is also<get-values-decoded>
  {
    returnGList(
      e_vcard_attribute_get_values_decoded($!evca),
      $glist,
      $raw
    );
  }

  method has_type (Str() $typestr) is also<has-type> {
    so e_vcard_attribute_has_type($!evca, $typestr);
  }

  method is_single_valued is also<is-single-valued> {
    so e_vcard_attribute_is_single_valued($!evca);
  }

  method remove_param (Str() $param_name) is also<remove-param> {
    e_vcard_attribute_remove_param($!evca, $param_name);
  }

  method remove_param_value (Str() $param_name, Str() $s)
    is also<remove-param-value>
  {
    e_vcard_attribute_remove_param_value($!evca, $param_name, $s);
  }

  method remove_params is also<remove-params> {
    e_vcard_attribute_remove_params($!evca);
  }

  method remove_value (Str() $s) is also<remove-value> {
    e_vcard_attribute_remove_value($!evca, $s);
  }

  method remove_values is also<remove-values> {
    e_vcard_attribute_remove_values($!evca);
  }

}

# BOXED
class Evolution::VCard::Attribute::Param {
  has EVCardAttributeParam $!evcap;

  submethod BUILD (:$param) {
    $!evcap = $param;
  }

  method Evolution::Raw::Structs::EVCardAttributeParam
    is also<EVCardAttributeParam>
  { $!evcap }

  multi method new (Str() $name) {
    my $param = e_vcard_attribute_param_new($name);

    $param ?? self.bless( :$param ) !! Nil;
  }
  multi method new (EVCardAttributeParam $param) {
    $param ?? self.bless( :$param ) !! Nil;
  }

  method new_with_value (Str() $name, Str() $value) is also<new-with-value> {
    my $o = Evolution::VCard::Attribute::Param.new($name);

    return Nil unless $o;

    $o.add-value($value);
    $o;
  }

  method add_value (Str() $value) is also<add-value> {
    e_vcard_attribute_param_add_value($!evcap, $value);
  }

  method add_values (*@values) is also<add-values> {
    #e_vcard_attribute_param_add_values($!evcap);
    self.add_value($_) for checkListCompatible(@values, Str);
  }

  method copy (:$raw = False) {
    my $copy = e_vcard_attribute_param_copy($!evcap);

    $copy ??
      ( $raw ?? $copy !! Evolution::VCard::Attribute::Param.new($copy, :!ref) )
      !!
      Nil;
  }

  method free {
    e_vcard_attribute_param_free($!evcap);
  }

  method get_name is also<get-name> {
    e_vcard_attribute_param_get_name($!evcap);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_vcard_attribute_param_get_type, $n, $t );
  }

  method get_values is also<get-values> {
    e_vcard_attribute_param_get_values($!evcap);
  }

  method remove_values is also<remove-values> {
    e_vcard_attribute_param_remove_values($!evcap);
  }

}
