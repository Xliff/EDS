use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::PhoneNumber;

# BOXED
class Evolution::PhoneNumber {
  has EPhoneNumber $!ep is implementor;

  submethod BUILD (:$phone) {
    $!ep = $phone;
  }

  multi method new (EPhoneNumber $phone , :$ref = True) {
    # Wire in :$ref when we get GLib::Roles::Boxed!
    $phone ?? self.bless( :$phone ) !! Nil;
  }
  multi method new (Str() $phone_number, Str() $region_code = Str) {
    self.from-string($phone_number, $region_code);
  }

  multi method compare (Evolution::PhoneNumber:D: EPhoneNumber() $p2) {
    Evolution::PhoneNumber.compare($!ep, $p2);
  }
  multi method compare (
    Evolution::PhoneNumber:U:

    EPhoneNumber() $p1,
    EPhoneNumber() $p2
  ) {
    so e_phone_number_compare($p1, $p2);
  }

  method compare_strings (
    Evolution::PhoneNumber:U:

    Str()                   $n1,
    Str()                   $n2,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<compare-strings>
  {
    clear_error;
    my $r = EPhoneNumberMatchEnum(
      e_phone_number_compare_strings($n1, $n2, $error)
    );
    set_error($error);
    $r;
  }

  method compare_strings_with_region (
    Evolution::PhoneNumber:U:

    Str()                   $first_number,
    Str()                   $second_number,
    Str()                   $region_code,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<compare-strings-with-region>
  {
    clear_error;
    my $r = EPhoneNumberMatchEnum(
      e_phone_number_compare_strings_with_region(
        $first_number,
        $second_number,
        $region_code,
        $error
      )
    );
    set_error($error);
    $r
  }

  method copy (:$raw = False) {
    my $c = e_phone_number_copy($!ep);

    # Transfer: full
    $c ??
      ( $raw ?? $c !! Evolution::PhoneNumber.new($c, :!ref) )
      !!
      Nil;
  }

  method error_quark (Evolution::PhoneNumber:U: ) is also<error-quark> {
    e_phone_number_error_quark();
  }

  multi method free {
    Evolution::PhoneNumber.free($!ep);
  }
  multi method free (Evolution::PhoneNumber:U: EPhoneNumber() $pn) {
    e_phone_number_free($pn);
  }

  method from_string (
    Evolution::PhoneNumber:U:

    Str()                   $phone_number,
    Str()                   $region_code   = Str,
    CArray[Pointer[GError]] $error         = gerror,
                            :$raw          = False
  )
    is also<from-string>
  {
    clear_error;
    my $phone = e_phone_number_from_string($!ep, $region_code, $error);
    set_error($error);

    $phone ??
      ( $raw ?? $phone !! Evolution::PhoneNumber.new($phone, :!ref) )
      !!
      Nil;
  }

  proto method get_country_code (|)
    is also<get-country-code>
  { * }

  multi method get_country_code
    is also<
      country_code
      country-code
    >
  {
    samewith($s, :all);
  }
  multi method get_country_code ($source is rw, :$all = False) {
    my EPhoneNumberCountrySource $s = 0;

    my $cc = e_phone_number_get_country_code($!ep, $s);
    $source = $s;

    return $cc unless $all;
    ($cc, $source);
  }

  method get_country_code_for_region (
    Evolution::PhoneNumber:U:

    Str()                   $region,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-country-code-for-region>
  {
    clear_error;
    my $cc = e_phone_number_get_country_code_for_region($region, $error);
    set_error($error);
    $cc;
  }

  method get_default_region (
    Evolution::PhoneNumber:U:

    CArray[Pointer[GError]] $error = gerror
  )
    is also<
      get-default-region
      default_region
      default-region
    >
  {
    clear_error;
    my $r = e_phone_number_get_default_region($error);
    set_error($error);
    $r;
  }

  method get_national_number
    is also<
      get-national-number
      national_number
      national-number
    >
  {
    e_phone_number_get_national_number($!ep);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_phone_number_get_type, $n, $t );
  }

  method is_supported (Evolution::PhoneNumber:U: ) is also<is-supported> {
    e_phone_number_is_supported();
  }

  method Str {
    self.to_string;
  }
  method to_string (Int() $format = E_PHONE_NUMBER_FORMAT_INTERNATIONAL)
    is also<to-string>
  {
    my EPhoneNumberFormat $f = $format;

    e_phone_number_to_string($!ep, $format);
  }

}
