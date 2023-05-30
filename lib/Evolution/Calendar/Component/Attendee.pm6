use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Attendee;

use GLib::Roles::Implementor;

class Evolution::Calendar::Component::Attendee {
  also does GLib::Roles::Implementor;

  has ECalComponentAttendee $!eds-ecc-att is implementor;

  submethod BUILD ( :$e-cal-attendee ) {
    $!eds-ecc-att = $e-cal-attendee if $e-cal-attendee;
  }

  method Evolution::Raw::Structs::ECalComponentAttendee
  { $!eds-ecc-att }

  multi method new (ECalComponentAttendee $e-cal-attendee) {
    $e-cal-attendee ?? self.bless( :$e-cal-attendee ) !! Nil;
  }
  multi method new {
    my $e-cal-attendee = e_cal_component_attendee_new();

    $e-cal-attendee ?? self.bless( :$e-cal-attendee ) !! Nil;
  }

  method new_from_property (ICalProperty() $property) {
    my $e-cal-attendee = e_cal_component_attendee_new_from_property(
      $!eds-ecc-att,
      $property
    );

    $e-cal-attendee ?? self.bless( :$e-cal-attendee ) !! Nil;
  }

  multi method new_full (
    Int() :part(:$partstat)      = ICAL_PARTSTAT_NEEDSACTION,
    Int() :type(:$cutype)        = I_CAL_CUTYPE_INDIVIDUAL,
    Int() :res(:$rsvp)           = False,
    Int() :$role                 = I_CAL_ROLE_OPTPARTICIPANT,
    Str() :val(:$value)          = Str,
    Str() :m(:$member)           = Str,
    Str() :from(:$delegatedfrom) = Str,
    Str() :to(:$delegatedto)     = Str,
    Str() :by(:$sentby)          = Str,
    Str() :name(:$cn)            = Str,
    Str() :lang(:$language)      = Str
  ) {
    samewith(
      $value,
      $member,
      $cutype,
      $role,
      $partstat,
      $rsvp,
      $delegatedfrom,
      $delegatedto,
      $sentby,
      $cn,
      $language
    );
  }
  multi method new_full (
    Str() $value,
    Str() $member,
    Int() $cutype,
    Int() $role,
    Int() $partstat,
    Int() $rsvp,
    Str() $delegatedfrom,
    Str() $delegatedto,
    Str() $sentby,
    Str() $cn,
    Str() $language
  ) {
    my ICalParameterCutype   $c = $cutype,
    my ICalParameterRole     $r = $role,
    my ICalParameterPartstat $p = $partstat,
    my gboolean              $s = $rsvp.so.Int;

    my $e-cal-attendee = e_cal_component_attendee_new_full(
      $value,
      $member,
      $c,
      $r,
      $p,
      $s,
      $delegatedfrom,
      $delegatedto,
      $sentby,
      $cn,
      $language
    );

    $e-cal-attendee ?? self.bless( :$e-cal-attendee ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_attendee_copy($!eds-ecc-att),
      $raw,
      |self.getTypePair
    );
  }

  method fill_property (ICalProperty() $property) {
    e_cal_component_attendee_fill_property($!eds-ecc-att, $property);
  }

  method free {
    e_cal_component_attendee_free($!eds-ecc-att);
  }

  method get_as_property ( :$raw = False ) {
    propReturnObject(
      e_cal_component_attendee_get_as_property($!eds-ecc-att),
      $raw,
      |ICal::GLib::Property.getTypePair
    );
  }

  method get_cn {
    e_cal_component_attendee_get_cn($!eds-ecc-att);
  }

  method get_cutype ( :$enum = True ) {
    my $c = e_cal_component_attendee_get_cutype($!eds-ecc-att);
    return $c unless $enum;
    ICalParameterCutypeEnum($c);
  }

  method get_delegatedfrom {
    e_cal_component_attendee_get_delegatedfrom($!eds-ecc-att);
  }

  method get_delegatedto {
    e_cal_component_attendee_get_delegatedto($!eds-ecc-att);
  }

  method get_language {
    e_cal_component_attendee_get_language($!eds-ecc-att);
  }

  method get_member {
    e_cal_component_attendee_get_member($!eds-ecc-att);
  }

  method get_parameter_bag ( :$raw = False ) {
    propReturnObject(
      e_cal_component_attendee_get_parameter_bag($!eds-ecc-att),
      $raw,
      |Evolution::Calendar::Component::ParameterBag.getTypePair
    );
  }

  method get_partstat ( :$enum = False ) {
    my $p = e_cal_component_attendee_get_partstat($!eds-ecc-att);
    return $p unless $enum;
    ICalParameterPartstatEnum($p);
  }

  method get_role ( :$enum = False ) {
    my $r = e_cal_component_attendee_get_role($!eds-ecc-att);
    return $r unless $enum;
    ICalParameterRoleEnum($r);
  }

  method get_rsvp {
    so e_cal_component_attendee_get_rsvp($!eds-ecc-att);
  }

  method get_sentby {
    e_cal_component_attendee_get_sentby($!eds-ecc-att);
  }

  method get_type {
    e_cal_component_attendee_get_type();
  }

  method get_value {
    e_cal_component_attendee_get_value($!eds-ecc-att);
  }

  method set_cn (Str() $cn) {
    e_cal_component_attendee_set_cn($!eds-ecc-att, $cn);
  }

  method set_cutype (Int() $cutype) {
    my ICalParameterCutype $c = $cutype;

    e_cal_component_attendee_set_cutype($!eds-ecc-att, $c);
  }

  method set_delegatedfrom (Str() $delegatedfrom) {
    e_cal_component_attendee_set_delegatedfrom($!eds-ecc-att, $delegatedfrom);
  }

  method set_delegatedto (Str() $delegatedto) {
    e_cal_component_attendee_set_delegatedto($!eds-ecc-att, $delegatedto);
  }

  method set_from_property (ICalProperty() $property) {
    e_cal_component_attendee_set_from_property($!eds-ecc-att, $property);
  }

  method set_language (Str() $language) {
    e_cal_component_attendee_set_language($!eds-ecc-att, $language);
  }

  method set_member (Str() $member) {
    e_cal_component_attendee_set_member($!eds-ecc-att, $member);
  }

  method set_partstat (Int() $partstat) {
    my ICalParameterPartstat $p = $partstat;

    e_cal_component_attendee_set_partstat($!eds-ecc-att, $p);
  }

  method set_role (Int() $role) {
    my ICalParameterRole $r = $role;

    e_cal_component_attendee_set_role($!eds-ecc-att, $r);
  }

  method set_rsvp (Int() $rsvp) {
    my gboolean $r = $rsvp.so.Int;

    e_cal_component_attendee_set_rsvp($!eds-ecc-att, $r);
  }

  method set_sentby (Str() $sentby) {
    e_cal_component_attendee_set_sentby($!eds-ecc-att, $sentby);
  }

  method set_value (Str() $value) {
    e_cal_component_attendee_set_value($!eds-ecc-att, $value);
  }

}
