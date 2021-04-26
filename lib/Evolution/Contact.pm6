use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Contact;

use GLib::GList;
use Evolution::VCard;

our subset EContactAncestry is export of Mu
  where EContact | EVCardAncestry;

class Evolution::Contact is Evolution::VCard {
  has EContact $!c;

  submethod BUILD (:$contact) {
    self.setEContact($contact) if $contact;
  }

  method setEContact (EContactAncestry $_) {
    my $to-parent;

    $!c = do {
      when EContact {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EContact, $_);
      }
    }
    self.setEVCard($to-parent);
  }

  method Evolution::Raw::Definitions::EContact
    is also<EContact>
    #is also<EContact>
  { $!c }

  multi method new (EContactAncestry $contact, :$ref = True) {
    return Nil unless $contact;

    my $o = self.bless( :$contact );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $contact = e_contact_new();

    $contact ?? self.bless( :$contact ) !! Nil;
  }

  method new_from_vcard (Str() $vcard) is also<new-from-vcard> {
    my $contact = e_contact_new_from_vcard($!c, $vcard);

    $contact ?? self.bless( :$contact ) !! Nil;
  }

  method new_from_vcard_with_uid (Str() $vcard, Str() $uid)
    is also<new-from-vcard-with-uid>
  {
    my $contact = e_contact_new_from_vcard_with_uid($!c, $vcard, $uid);

    $contact ?? self.bless( :$contact ) !! Nil;
  }

  method duplicate (:$raw = False) {
    my $c = e_contact_duplicate($!c);

    $c ??
      ( $raw ?? $c !! Evolution::Contact.new($c, :!ref) )
      !!
      Nil;
  }

  # cw: As long as we don't have to worry about signs, doubles, or floats!
  method get (Int() $field_id) {
    my EContactField $f  = $field_id;
    my               $pv = e_contact_get($!c, $f);

    return cast(Str, $pv) if Evolution::Contact::Field.is_string($field_id);

    $pv = cast(CArray[uint32], $pv);
    $pv[0];
  }

  method get_attributes (Int() $field_id, :$glist = False, :$raw = False)
    is also<get-attributes>
  {
    my EContactField $f = $field_id;

    returnGList(
      e_contact_get_attributes($!c, $f),
      $glist,
      $raw,
      EVCardAttribute,
      Evolution::VCard::Attribute
    );
  }

  proto method get_attributes_set (|)
      is also<get-attributes-set>
  { * }

  multi method get_attributes_set (
    @field-ids,
    :$glist     = False,
    :$raw       = False
  ) {
    samewith( CArrayToArray(@field-ids, EContactField), :$glist, :$raw );
  }
  multi method get_attributes_set (
    CArray[EContactField] $field_ids,
    Int()                 $size,
                          :$glist     = False,
                          :$raw       = False
  ) {
    my gint          $s = $size;

    returnGList(
      e_contact_get_attributes_set($!c, $field_ids, $s),
      $glist,
      $raw,
      EVCardAttribute,
      Evolution::VCard::Attribute
    );
  }

  method get_const (Int() $field_id) is also<get-const> {
    my EContactField $f = $field_id;

    e_contact_get_const($!c, toPointer($field_id) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_get_type, $n, $t );
  }

  method inline_local_photos (CArray[Pointer[GError]] $error = gerror)
    is also<inline-local-photos>
  {
    clear_error;
    my $rv = so e_contact_inline_local_photos($!c, $error);
    set_error($error);
    $rv;
  }

  method pretty_name is also<pretty-name> {
    e_contact_pretty_name($!c);
  }

  method set (Int() $field_id, $value) {
    my EContactField $f = $field_id;

    e_contact_set( $!c, $f, toPointer($value) );
  }

  method set_attributes (Int() $field_id, GList() $attributes)
    is also<set-attributes>
  {
    my EContactField $f = $field_id;

    e_contact_set_attributes($!c, $field_id, $attributes);
  }

  method vcard_attribute (Evolution::Contact:U: Int() $field_id)
    is also<vcard-attribute>
  {
    my EContactField $f = $field_id;

    e_contact_vcard_attribute($f);
  }

}

# BOXED
class Evolution::Contact::Address {
  has EContactAddress $!ca;

  submethod BUILD (:$address) {
    $!ca = $address;
  }

  multi method new (EContactAddress $address) {
    $address ?? self.bless( :$address ) !! Nil;
  }
  multi method new {
    my $address = e_contact_address_new();

    $address ?? self.bless( :$address ) !! Nil;
  }

  method free {
    e_contact_address_free($!ca);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_address_get_type, $n, $t );
  }

}

class Evolution::Contact::AttrList does GLib::Roles::StaticClass {

  # method new (EContactAttrList $list) {
  #   $list ?? self.bless( :$list ) !! Nil;
  # }

  method copy (GList() $list, :$glist = False, :$raw = False)  {
    e_contact_attr_list_copy($list);

    # Finish this!
  }

  method free (GList() $list) {
    e_contact_attr_list_free($list);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_attr_list_get_type, $n, $t );
  }
}

class Evolution::Contact::Cert {
  has EContactCert $!cert;

  submethod BUILD ($cert) {
    $!cert = $cert;
  }

  method Evolution::Raw::Structs::EContactCert
    is also<EContactCert>
  { $!cert }

  multi method new (EContactCert $cert) {
    $cert ?? self.bless( :$cert ) !! Nil;
  }
  multi method new {
    my $cert = e_contact_cert_new();

    $cert ?? self.bless( :$cert ) !! Nil;
  }

  method free {
    e_contact_cert_free($!cert);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_cert_get_type, $n, $t );
  }

}

class Evolution::Contact::Date {
  has EContactDate $!date;

  submethod BUILD (:$!date) { }

  method Evolution::Raw::Struct::EContactDate
    is also<EContactDate>
  { $!date }

  multi method new (EContactDate $date) {
    $date ?? self.bless( :$date ) !! Nil;
  }
  multi method new {
    my $date = e_contact_date_new();

    $date ?? self.bless( :$date ) !! Nil;
  }

  method new_from_string (Str() $string) is also<new-from-string> {
    Evolution::Contact::Date.from-string($string);
  }

  method from_string (
    Evolution::Contact::Date:U:
    Str()                       $string,
                                :$raw    = False
  )
    is also<from-string>
  {
    my $date = e_contact_date_from_string($string);

    $date ??
      ( $raw ?? $date !! Evolution::Contact::Date.new($date, :!ref) )
      !!
      Nil;
  }

  multi method equal (EContactDate() $dt2) {
    Evolution::Contact::Date.equal($!date, $dt2);
  }
  multi method equal (
    Evolution::Contact::Date:U:
    EContactDate               $d1,
    EContactDate               $d2
  ) {
    so e_contact_date_equal($d1, $d2);
  }

  method free {
    e_contact_date_free($!date);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_date_get_type, $n, $t );
  }

  method to_string is also<to-string> {
    e_contact_date_to_string($!date);
  }

}

multi sub infix:<==> (EContactDate $d1, EContactDate $d2) is export {
  Evolution::Contact::Date.equal($d1, $d2);
}

class Evolution::Contact::Field is GLib::Roles::StaticClass {

  method id_from_vcard (Str() $field) is also<id-from-vcard> {
    EContactFieldEnum( e_contact_field_id_from_vcard($field) );
  }

  method id (Int() $field) {
    EContactFieldEnum( e_contact_field_id($field) );
  }

  method is_string (Int() $field) is also<is-string> {
    my EContactField $f = $field;

    so e_contact_field_is_string($f);
  }

  method name (Int() $field) {
    my EContactField $f = $field;

    e_contact_field_name($f);
  }

  method type (Int() $field) {
    my EContactField $f = $field;

    e_contact_field_type($f);
  }

}

# BOXED
class Evolution::Contact::Name {
  has EContactName $!name;

  submethod BUILD (:$name) {
    $!name = $name;
  }

  multi method new (EContactName $date) {
    $date ?? self.bless( :$date ) !! Nil;
  }
  multi method new {
    my $name = e_contact_name_new();

    $name ?? self.bless( :$name ) !! Nil;
  }

  method new_from_string (Str() $string) is also<new-from-string> {
    Evolution::Contact::Name.new($string);
  }

  method from_string (Str() $string, :$raw = False) is also<from-string> {
    my $name = e_contact_name_from_string($string);

    $name ??
      ( $raw ?? $name !! Evolution::Contact::Name.new($name, :!ref) )
      !!
      Nil;
  }

  method copy (:$raw = False) {
    my $copy = e_contact_name_copy($!name);

    $copy ??
      ( $raw ?? $copy !! Evolution::Contact::Name.new($copy, :!ref) )
      !!
      Nil;
  }

  method free {
    e_contact_name_free($!name);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_name_get_type, $n, $t );
  }

  method to_string is also<to-string> {
    e_contact_name_to_string($!name);
  }

}

# BOXED
class Evolution::Contact::Geo {
  has EContactGeo $!geo;

  submethod BUILD ($!geo) { }

  method new {
    my $geo = e_contact_geo_new();

    $geo ?? self.bless( :$geo ) !! Nil;
  }

  method free {
    e_contact_geo_free($!geo);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_geo_get_type, $n, $t );
  }

}

# BOXED
class Evolution::Contact::Photo {
  has EContactPhoto $!photo;

  submethod BUILD (:$!photo) { }

  multi method new (EContactPhoto $photo, :$ref = True) {
    $photo ?? self.bless( :$photo ) !! Nil;
  }
  multi method new {
    my $photo = e_contact_photo_new();

    $photo ?? self.bless( :$photo ) !! Nil;
  }

  method mime_type is rw is also<mime-type> {
    Proxy.new:
      FETCH => -> $     { self.get_mime_type    },
      STORE => -> $, \v { self.set_mime_type(v) };
  }

  method uri is rw {
    Proxy.new:
      FETCH => -> $     { self.get_uri    },
      STORE => -> $, \v { self.set_uri(v) };
  }

  method copy (:$raw = False) {
    my $copy = e_contact_photo_copy($!photo);

    $copy ??
      ( $raw ?? $copy !! Evolition::Contact::Photo.new($copy, :!ref) )
      !!
      Nil;
  }

  method free {
    e_contact_photo_free($!photo);
  }

  proto method get_inlined (|)
      is also<get-inlined>
  { * }

  multi method get_inlined {
    samewith($, :all);
  }
  multi method get_inlined ($len is rw, :$all = False) {
    my gsize $l = 0;

    my $data = e_contact_photo_get_inlined($!photo, $l);
    $len = $l;

    return $data unless $all;

    ($data, $len);
  }

  method get_mime_type is also<get-mime-type> {
    e_contact_photo_get_mime_type($!photo);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_contact_photo_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    e_contact_photo_get_uri($!photo);
  }

  method set_inlined (Str() $data, Int() $len = $data.chars)
    is also<set-inlined>
  {
    my gsize $l = $len;

    e_contact_photo_set_inlined($!photo, $data, $l);
  }

  method set_mime_type (Str() $mime_type) is also<set-mime-type> {
    e_contact_photo_set_mime_type($!photo, $mime_type);
  }

  method set_uri (Str() $uri) is also<set-uri> {
    e_contact_photo_set_uri($!photo, $uri);
  }

}
