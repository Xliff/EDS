use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Destination;

use GLib::GList;

use GLib::Roles::Object;

our subset EDestinationAncestry is export of Mu
  where EDestination | GObject;

class Evolution::Destination {
  also does GLib::Roles::Object;

  has EDestination $!ed;

  submethod BUILD (:$destination) {
    self.setEDestination($destination) if $destination;
  }

  method setEDestination (EDestinationAncestry $_) {
    my $to-parent;

    $!ed = do {
      when EDestination {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDestination, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EDestination
  { $!ed }

  multi method new (EDestinationAncestry $destination, :$ref = True) {
    return Nil unless $destination;

    my $o = self.bless( :$destination );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $destination = e_destination_new();

    $destination ?? self.bless( :$destination ) !! Nil;
  }

  method copy (:$raw = False) {
    my $d = e_destination_copy($!ed);

    # Transfer: full (newly created)
    $d ??
      ( $raw ?? $d !! Evolution::Destination.new($d, :!ref) )
      !!
      Nil
  }

  method empty {
    e_destination_empty($!ed);
  }

  multi method equal (Evolution::Destination:U: EDestination() $b) {
    Evolution::Destination.equal($!ed, $b);
  }
  multi method equal (
    Evolution::Destination:U:

    EDestination() $a,
    EDestination() $b
  ) {
    e_destination_equal($a, $b);
  }

  method export {
    e_destination_export($!ed);
  }

  method export_to_vcard_attribute (EVCardAttribute() $attr) {
    e_destination_export_to_vcard_attribute($!ed, $attr);
  }

  multi method exportv (Evolution::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations ) );
  }
  multi method exportv (
    Evolution::Destination:U:

    CArray[Pointer[EDestination]] $d
  ) {
    e_destination_exportv($!ed);
  }

  multi method freev (Evolution::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations ) );
  }
  multi method freev (
    Evolution::Destination:U:

    CArray[Pointer[EDestination]] $d
  ) {
    e_destination_freev($d);
  }

  method get_address {
    e_destination_get_address($!ed);
  }

  method get_contact {
    e_destination_get_contact($!ed);
  }

  method get_contact_uid {
    e_destination_get_contact_uid($!ed);
  }

  method get_email {
    e_destination_get_email($!ed);
  }

  method get_email_num {
    e_destination_get_email_num($!ed);
  }

  method get_html_mail_pref {
    e_destination_get_html_mail_pref($!ed);
  }

  method get_name {
    e_destination_get_name($!ed);
  }

  method get_source_uid {
    e_destination_get_source_uid($!ed);
  }

  method get_textrep (Int() $include_email) {
    my gboolean $i = $include_email.so.Int;

    e_destination_get_textrep($!ed, $i);
  }

  multi method get_textrepv (Evolution::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations) );
  }
  multi method get_textrepv (
    Evolution::Destination:U:

    CArray[Pointer[EDestination]] $d
  ) {
    e_destination_get_textrepv($d);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_destination_get_type, $n, $t );
  }

  method import (Evolution::Destination:U: Str() $xml, :$raw = False) {
    my $d = e_destination_import($xml);

    # Transfer: full (newly created)
    $d ??
      ( $raw ?? $d !! Evolution::Destination.new($d, :!ref) )
      !!
      Nil
  }

  method importv (
    Evolution::Destination:U:

    Str() $xml,
          :$carray = False,
          :$raw    = False
  ) {
    my $a = e_destination_importv($xml);

    return $a if $carray;

    $a = CArrayToArray($a);
    return $a if $raw;

    $a.map({ Evolution::Destination.new($_, :!ref) }).Array;
  }

  method is_auto_recipient {
    so e_destination_is_auto_recipient($!ed);
  }

  method is_evolution_list {
    so e_destination_is_evolution_list($!ed);
  }

  method is_ignored {
    so e_destination_is_ignored($!ed);
  }

  method list_get_dests (:$glist = False, :$raw = False) {
    returnGList(
      e_destination_list_get_dests($!ed),
      $glist,
      $raw,
      EDestination,
      Evolution::Destination
    );
  }

  method list_get_root_dests (:$glist = False, :$raw = False) {
    returnGList(
      e_destination_list_get_root_dests($!ed),
      $glist,
      $raw,
      EDestination,
      Evolution::Destination
    );
  }

  method list_show_addresses (:$glist = False, :$raw = False) {
    returnGList(
      e_destination_list_show_addresses($!ed),
      $glist,
      $raw,
      EDestination,
      Evolution::Destination
    );
  }

  method set_auto_recipient (Int() $value) {
    my gboolean $v = $value.so.Int;

    e_destination_set_auto_recipient($!ed, $v);
  }

  method set_book (EBook() $book) {
    e_destination_set_book($!ed, $book);
  }

  method set_client (EBookClient() $destination) {
    e_destination_set_client($!ed, $destination);
  }

  method set_contact (EContact() $contact, Int() $email_num) {
    my gint $e = $email_num;

    e_destination_set_contact($!ed, $contact, $e);
  }

  method set_contact_uid (Str $uid, gint $email_num) {
    my gint $e = $email_num;

    e_destination_set_contact_uid($!ed, $uid, $e);
  }

  method set_email (Str() $email) {
    e_destination_set_email($!ed, $email);
  }

  method set_html_mail_pref (Int() $flag) {
    my gboolean $f = $flag.so.Int;

    e_destination_set_html_mail_pref($!ed, $f);
  }

  method set_ignored (Int() $ignored) {
    my gboolean $i = $ignored.so.Int;

    e_destination_set_ignored($!ed, $i);
  }

  method set_name (Str() $name) {
    e_destination_set_name($!ed, $name);
  }

  method set_raw (Str() $raw) {
    e_destination_set_raw($!ed, $raw);
  }

}

multi sub infix:<eqv> (EDestination() $a, EDestination $b) {
  $a.equal($b);
}
