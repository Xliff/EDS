use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Destination;

use GLib::GList;

use GLib::Roles::Object;

our subset EDestinationAncestry is export of Mu
  where EDestination | GObject;

class Evolution::Book::Destination {
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

  method Evolution::Raw::Structs::EDestination
    is also<EDestination>
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

  method contact is rw {
    Proxy.new:
      FETCH => -> $     { self.get_contact    },
      STORE => -> $, \v { self.set_contact(v) }
  }

  method contact_uid is rw is also<contact-uid> {
    Proxy.new:
      FETCH => -> $     { self.get_contact_uid    },
      STORE => -> $, \v { self.set_contact_uid(v) }
  }

  method email is rw {
    Proxy.new:
      FETCH => -> $     { self.get_email    },
      STORE => -> $, \v { self.set_email(v) }
  }

  method html_mail_pref is rw is also<html-mail-pref> {
    Proxy.new:
      FETCH => -> $     { self.get_html_mail_pref    },
      STORE => -> $, \v { self.set_html_mail_pref(v) }
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method copy ( :$raw = False ) {
    my $copy = e_destination_copy($!ed);

    $copy ??
      ( $raw ?? $copy !! Evolution::Book::Destination($copy, :!ref) )
      !!
      Nil
  }

  method empty {
    so e_destination_empty($!ed);
  }

  multi method equal (Evolution::Book::Destination:D: EDestination() $b) {
    Evolution::Book::Destination.equal($!ed, $b);
  }
  multi method equal (
    Evolution::Book::Destination:U:

    EDestination() $a,
    EDestination() $b
  ) {
    e_destination_equal($a, $b);
  }

  method export {
    e_destination_export($!ed);
  }

  method export_to_vcard_attribute (EVCardAttribute $attr) is also<export-to-vcard-attribute> {
    e_destination_export_to_vcard_attribute($!ed, $attr);
  }

  multi method exportv (Evolution::Book::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations) );
  }
  multi method exportv (
    Evolution::Book::Destination:U:

    CArray[Pointer[EDestination]] $destinations
  ) {
    e_destination_exportv($destinations);
  }

  multi method freev (Evolution::Book::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations) );
  }
  multi method freev (
    Evolution::Book::Destination:U:

    CArray[Pointer[EDestination]] $destinations
  ) {
    e_destination_freev($destinations);
  }

  method get_address
    is also<
      get-address
      address
    >
  {
    e_destination_get_address($!ed);
  }

  method get_contact is also<get-contact> {
    e_destination_get_contact($!ed);
  }

  method get_contact_uid is also<get-contact-uid> {
    e_destination_get_contact_uid($!ed);
  }

  method get_email is also<get-email> {
    e_destination_get_email($!ed);
  }

  method get_email_num
    is also<
      get-email-num
      email_num
      email-num
    >
  {
    e_destination_get_email_num($!ed);
  }

  method get_html_mail_pref is also<get-html-mail-pref> {
    so e_destination_get_html_mail_pref($!ed);
  }

  method get_name is also<get-name> {
    e_destination_get_name($!ed);
  }

  method get_source_uid
    is also<
      get-source-uid
      source_uid
      source-uid
    >
  {
    e_destination_get_source_uid($!ed);
  }

  method get_textrep (Int() $include_email) is also<get-textrep> {
    my gboolean $i = $include_email.so.Int;

    e_destination_get_textrep($!ed, $include_email);
  }

  proto method get_textrepv
    is also<get-textrepv>
  { * }

  multi method get_textrepv (Evolution::Book::Destination:U: @destinations) {
    samewith( ArrayToCArray(EDestination, @destinations) );
  }
  multi method get_textrepv (
    Evolution::Book::Destination:U:

    CArray[Pointer[EDestination]] $destinations
  ) {
    e_destination_get_textrepv($destinations);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_destination_get_type, $n, $t );
  }

  method import (Evolution::Book::Destination:U: Str() $dest, :$raw = False) {
    my $d = e_destination_import($dest);

    $d ??
      ( $raw ?? $d !! Evolution::Book::Destination.new($d, :!ref) )
      !!
      Nil
  }

  multi method importv (
    Evolution::Book::Destination:U:

    Str() $destinations,
          :$raw          = False
  ) {
    my @d = CArrayToArray( e_destination_importv($destinations) );

    return @d unless $raw;

    @d.map({ Evolution::Book::Destination.new($_, :!ref) })
  }

  method is_auto_recipient is also<is-auto-recipient> {
    so e_destination_is_auto_recipient($!ed);
  }

  method is_evolution_list is also<is-evolution-list> {
    so e_destination_is_evolution_list($!ed);
  }

  method is_ignored is also<is-ignored> {
    so e_destination_is_ignored($!ed);
  }

  method list_get_dests (:$glist = False, :$raw = False)
    is also<list-get-dests>
  {
    returnGList(
      e_destination_list_get_dests($!ed),
      $glist,
      $raw,
      EDestination,
      Evolution::Book::Destination
    );
  }

  method list_get_root_dests (:$glist = False, :$raw = False)
    is also<list-get-root-dests>
  {
    returnGList(
      e_destination_list_get_root_dests($!ed),
      $glist,
      $raw,
      EDestination,
      Evolution::Book::Destination
    );
  }

  method list_show_addresses is also<list-show-addresses> {
    so e_destination_list_show_addresses($!ed);
  }

  method set_auto_recipient (Int() $value) is also<set-auto-recipient> {
    my gboolean $v = $value.so.Int;

    e_destination_set_auto_recipient($!ed, $v);
  }

  method set_book (EBook() $book) is DEPRECATED<set_client> is also<set-book> {
    e_destination_set_book($!ed, $book);
  }

  method set_client (EBookClient() $client) is also<set-client> {
    e_destination_set_client($!ed, $client);
  }

  method set_contact (EContact() $contact, Int() $email_num)
    is also<set-contact>
  {
    my gint $e = $email_num;

    e_destination_set_contact($!ed, $contact, $e);
  }

  method set_contact_uid (Str() $uid, Int() $email_num)
    is also<set-contact-uid>
  {
    my gint $e = $email_num;

    e_destination_set_contact_uid($!ed, $uid, $e);
  }

  method set_email (Str() $email) is also<set-email> {
    e_destination_set_email($!ed, $email);
  }

  method set_html_mail_pref (Int() $flag) is also<set-html-mail-pref> {
    my gboolean $f = $flag.so.Int;

    e_destination_set_html_mail_pref($!ed, $f);
  }

  method set_ignored (Int() $ignored) is also<set-ignored> {
    my gboolean $i = $ignored.so.Int;

    e_destination_set_ignored($!ed, $i);
  }

  method set_name (Str() $name) is also<set-name> {
    e_destination_set_name($!ed, $name);
  }

  method set_raw (Str() $raw) is also<set-raw> {
    e_destination_set_raw($!ed, $raw);
  }

}
