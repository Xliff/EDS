use v6.c;

use Test;

use Evolution::Raw::Types;
use Evolution::PhoneNumber;

my @match-candidates = <
  not-a-number
  +1-617-4663489 617-4663489 4663489
  +1.408.845.5246 4088455246 8455246
  +1-857-4663489
>;

my @expected-matches = (
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,

  # +1-617-4663489
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_EXACT,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,

  # 617-4663489
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,

  # 4663489
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NATIONAL, # XXX - Google, really? I'd expect a full match here.
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_SHORT,

  # +1.408.845.5246
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_EXACT,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NONE,

  # 4088455246
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_NATIONAL,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NONE,

  # 8455246
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NATIONAL, # XXX - Google, really?  I'd expect a full match here.
  E_PHONE_NUMBER_MATCH_NONE,

  # +1-857-4663489
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_SHORT,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_NONE,
  E_PHONE_NUMBER_MATCH_EXACT
);

sub parse-and-format-data-new(
  $phone-number,
  $region-code,
  $country-source,
  $country-code,
  $national-number,
  $formatted-e164,
  $formatted-intl,
  $formatted-natl,
  $formatted-uri
) {
  (
    phone-number      => $phone-number,
    region-code       => $region-code,
    country-source    => $country-source,
    country-code      => $country-code,
    national-number   => $national-number,
    formatted-numbers => (
      $formatted-e164,
      $formatted-intl,
      $formatted-natl,
      $formatted-uri
    )
  ).Hash
}

sub test-parse-and-format ($data) {
  my $parsed = Evolution::PhoneNumber.new(
    $data<phone-number>,
    $data<region-code> // Str
  );

  {
    my ($cc, $source) = $parsed.get_country_code;

    is   $cc,                     $data<country-code>,       'Phone number has the correct country code';
    is   $source.Int,             $data<country-source>.Int, 'Phone number has the correct country source';
    ok   $parsed,                                            'Parsed number is defined';
    is   $parsed.national_number, $data<national-number>,    'Phone number has the correct national number';
    nok  $ERROR,                                             'No error occurred while retrieving the national number';

    for $data<formatted-numbers>.kv -> $i, $expected {
      my $formatted = $parsed.to_string($i);

      ok $formatted,                           'Phone number converted to string, successfully';
      is $formatted,              $expected,   "Phone number string matches expected value and { EPhoneNumberFormatEnum($i) }";
    }
  }
}

sub test-parse-bad-number {
  my $parsed = Evolution::PhoneNumber.new('+1-NOT-A-NUMBER', 'US');

  nok $parsed,                                              'Parsed object is undefined';
  ok  $ERROR,                                               'An error was detected';
  is  $ERROR.domain, Evolution::PhoneNumber.error_quark,    'Error detected belongs in the E_PHONE_NUMBER_ERROR domain';
  is  $ERROR.code,   E_PHONE_NUMBER_ERROR_NOT_A_NUMBER.Int, 'Error code indicates a NOT_A_NUMBER error';
  ok  $ERROR.message,                                       'An associated error message is present';
}

sub test-parse-auto-region {
  my $parsed = Evolution::PhoneNumber.new('212-5423789');

  ok  $parsed,                                                           'Parsed object is defined';
  nok $ERROR,                                                            'No error was detected in the parse operation';

  my ($cc, $s) = $parsed.country-code;
  is  $cc,                      1,                                       "Parsed object's country code is 1";
  is  $s,                       E_PHONE_NUMBER_COUNTRY_FROM_DEFAULT.Int, "Parsed object's source is the default";
  is  $parsed.national-number, '2125423789',                             "Parsed object's national format is '2125423789'";

  my $formatted = $parsed.to-string(E_PHONE_NUMBER_FORMAT_E164);
  is  $formatted,              '+12125423789',                           'Parsed object has the correct international format';
}

sub test-compare-numbers ($n1, $n2, $e, $expected) {
  my $actual-match = Evolution::PhoneNumber.compare-strings($n1, $n2);

  is $actual-match, $e,                                     "Actual match is { $e }";
  if $expected.not {
    nok $ERROR,                                             'Error was not expected!';
  } else {
    ok  $ERROR,                                             'An expected error was encountered';
    is  $ERROR.domain,  Evolution::PhoneNumber.error-quark, 'Error is in the E_PHONE_NUMBER_ERROR domain';
    is  $ERROR.code,    E_PHONE_NUMBER_ERROR_NOT_A_NUMBER,  'Error is of the NOT_A_NUMBER variety';
    ok  $ERROR.message,                                     'Error has an associated description';
  }
}

sub test-country-code-for-region {
  is setlocale(LC_ADDRESS), 'en_US.UTF-8', 'setlocale() returns the correct response';

  for ( ('CH', 41), (Str, 1), ('C', 0), ('', 1) ) -> $cc {
    my $code = Evolution::PhoneNumber.get_country_code_for_region( $cc[0] );
    if $ERROR {
      nok $ERROR.message,                  'Error defined with message';
    }
    my $out = $cc[0].defined ?? "'{ $out }'" !! 'NIL';
    is $code,             $cc[1],          "Country code for { $out } is correct";
  }
}

sub test-default-region {
  is setlocale(LC_ADDRESS), 'en_US.UTF-8', 'setlocale() returns the correct response';

  my $country = Evolution::PhoneNumbner.get-default-region;
  if $ERROR {
    nok $ERROR.message,                    'Error defined with message';
  }
  is $country, 'US',                       'Default country is "US"'
}

sub MAIN {
  plan 9;

  subtest '/ebook-phone-number/supported', {
    ok Evolution::PhoneNumber.is-supported, 'EPhoneNumber support is supported';
  };

  subtest '/ebook-phone-number/parse-and-format/i164', {
    test-parse-and-format(
      parse-and-format-data-new(
        '+493011223344',
        Nil,
        E_PHONE_NUMBER_COUNTRY_FROM_FQTN,
        49,
        '3011223344',
        '+493011223344',
        '+49 30 11223344',
        '030 11223344',
        'tel:+49-30-11223344'
      )
    );
  };

  subtest '/ebook-phone-number/parse-and-format/national' ,{
    test-parse-and-format(
      parse-and-format-data-new(
        '(030) 22334-455',
        'DE',
        E_PHONE_NUMBER_COUNTRY_FROM_DEFAULT,
        49,
        '3022334455',
        '+493022334455',
        '+49 30 22334455',
        '030 22334455',
        'tel:+49-30-22334455'
      )
    );
  };

  subtest '/ebook-phone-number/parse-and-format/national2', {
    test-parse-and-format(
      parse-and-format-data-new(
        '0049 (30) 22334-455',
        'DE',
        E_PHONE_NUMBER_COUNTRY_FROM_IDD,
        49,
        '3022334455',
        '+493022334455',
        '+49 30 22334455',
        '030 22334455',
        'tel:+49-30-22334455'
      )
    );
  };

  subtest '/ebook-phone-number/parse-and-format/international', {
    test-parse-and-format(
      parse-and-format-data-new(
        '+1 212 33445566',
        Nil,
  			E_PHONE_NUMBER_COUNTRY_FROM_FQTN,
  			1,
        '21233445566',
  			'+121233445566',
  			'+1 21233445566',
  			'21233445566',
  			'tel:+1-21233445566'
      )
    );
  };

  subtest '/ebook-phone-number/parse-and-format/rfc3966', {
    test-parse-and-format(
      parse-and-format-data-new(
        'tel:+358-71-44556677',
        Nil,
  			E_PHONE_NUMBER_COUNTRY_FROM_FQTN,
  			358,
        '7144556677',
  			'+3587144556677',
  			'+358 71 44556677',
  			'071 44556677',
  			'tel:+358-71-44556677'
      )
    );
  };

  subtest '/ebook-phone-number/parse-and-format/bad-number', {
    test-parse-bad-number;
  };

  subtest '/ebook-phone-number/parse-and-format/auto-region', {
    test-parse-auto-region;
  };

  # subtest 'ebook-phone-number/compare', {
  #   # cw: This is how test-compare-numbers is to be invoked!
  #   my $mcmi = +@match-candidates - 1;
  #   for @expected-matches.rotor(+@match-candidates) -> $em {
  #     for @match-candidates -> $m1 {
  #       my $e-idx = 0;
  #
  #       for @match-candidates -> $m2 {
  #         subtest "/ebook-phone-number/compare/$m1/$m2/{ $e-idx }-{ $mcmi }", {
  #           test-compare-numbers($m1, $m2, $em[$e-idx], $e-idx.not);
  #           $e-idx++;
  #         }
  #       }
  #     }
  #   }
  # };

}
