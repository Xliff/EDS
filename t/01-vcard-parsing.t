use v6.c;

use Test;

use Evolution::Raw::Types;

use Evolution::Contact;
use Evolution::VCard;

plan 121;

sub compare-single-value ($vcard, $attrname, $value) {
  ok $vcard,       'VCard is defined';
  ok $attrname,    'Attribute name is defined';
  ok $value,       'Value is defined';

  my $attr = $vcard.get_attribute($attrname);
  ok $attr,        'Attribute is defined';

  my $str = $attr.get_value;
  ok $str,         'Attribute value is defined';
  is $str, $value, 'Attribute value matches expected result';

  True;
}

sub has-only-one ($vcard, $attrname) {
  my $found = False;
  for $vcard.get-attributes {
    if $attrname eq .get-name {
      return False if $found;
      $found = True;
    }
  }
  $found;
}

sub test-vcard ($vcard-str) {
  {
    my $vc1 = Evolution::VCard.new-from-string($vcard-str);

    # Do not parse
    my $str = ~$vc1;
    ok  $str,                                           'Stringified VCard is defined';
    is  $str, $vcard-str,                               'Stringified VCard matches origin';
    nok $vc1.is-parsed,                                 'VCard is NOT parsed';

    # Parse
    my $attr = $vc1.get-attribute('UID');
    ok  $vc1.is-parsed,                                 'VCard with attribute is parsed after attribute retrieval';
    $str = ~$vc1;
    ok  $str,                                           'VCard can be stringified after attribute retrieval';
    is  ~$vc1, $vcard-str,                              'VCard still matches origin after attribute retrieval';

    # Getting FN will parse
    $vc1.get-attribute('FN');
    ok  $vc1.is-parsed,                                 'VCard parsed after retrieving 2nd attribute';
    $str = ~$vc1;
    ok  $str,                                           'VCard can be stringified after 2nd attribute retrieval';
    is  ~$vc1, $vcard-str,                              'VCard still matches origin after 2nd attribute retrieval';
  }

  {
    # Do not parse
    my $vc1 = Evolution::VCard.new-from-string($vcard-str);
    $vc1.append-attribute-with-value(
      Evolution::VCard::Attribute.new('UID', :name),
      'other-uid'
    );
    nok $vc1.is-parsed,                                   'VCard NOT parsed after attribute addition';
    ok  compare-single-value($vc1, 'UID', 'other-uid'),   'Created attribute is present in a VCard';
    nok $vc1.is-parsed,                                   'Retrieval of created attribute does not parse VCard';
    $vc1.get-attribute('FN');
    ok  $vc1.is-parsed,                                   "Retrieval of 'FN' attribute parses VCard";

    $vc1.unref;

    # Parse
    $vc1 = Evolution::VCard.new-from-string($vcard-str);
    nok $vc1.is-parsed,                                   'Recreated VCard is NOT parsed';
    $vc1.remove-attributes('UID', :name);

    ok  $vc1.is-parsed,                                   'Recreated VCard is parsed after UID removal';
    $vc1.append-attribute-with-value(
      Evolution::VCard::Attribute.new('UID', :name),
      'other-uid'
    );
    ok    compare-single-value($vc1, 'UID', 'other-uid'), 'Proper UID can be 4 after re-creation';
    {
      my $vc2 = Evolution::VCard.new-from-string(~$vc1);
      ok  compare-single-value($vc1, 'UID', 'other-uid'), 'Proper UID can be retrieved after re-creation';
    }

    {
      # Parse
      $vc1.get-attribute('FN');
      ok  $vc1.is-parsed,                                   'First VCard re-parsed correctly';
      ok  compare-single-value($vc1, 'UID', 'other-uid'),   'Created attribute is present in a original VCard';
      my $vc2 = Evolution::VCard.new-from-string(~$vc1);
      nok $vc2.is-parsed,                                   'Copied VCard is NOT parsed';
      ok  compare-single-value($vc2, 'UID', 'other-uid'),   'Created attribute is present remains valid in copied VCard';
      ok  has-only-one($vc1, 'UID'),                        'UID is singluar on first VCard';
      ok  has-only-one($vc2, 'UID'),                        'UID is singluar on second VCard';
    }
  }

  True;
}

sub test-econtact ($vcard-str) {
  diag 'Not parsed';
  my  $c1  = Evolution::Contact.new-from-vcard($vcard-str);
  ok  $c1,                                         'Contact created from vcard string representation is defined';
  ok  ~$c1,                                        'Stringified contact is defined';
  nok $c1.is-parsed,                               'Contact object is NOT parsed';

  diag 'Parse';
  $c1.get-const(E_CONTACT_UID);
  ok  $c1.is-parsed,                                'Contact object is parsed after information retrieval';
  my $str = ~$c1;
  ok  $str,                                         'Contact object re-stringifies with no issue';
  is  $str, $vcard-str,                             'Stringified contact object matches origin specification';

  diag 'Parse';
  $c1.get-const(E_CONTACT_FULL_NAME);
  $str = ~$c1;
  ok  $str,                                         'Contact object re-stringified for 3rd time successfully';
  is  $str, $vcard-str,                             'Stringified contact object still matches origin specification after programmatic access';

  $c1.unref;

  diag 'Not parsed again';
  $c1 = Evolution::Contact.new-from-vcard($vcard-str);
  $c1.set(E_CONTACT_UID, 'other-uid');
  nok $c1.is-parsed,                                 'New contact object is not parsed';
  ok  compare-single-value($c1, 'UID', 'other-uid'), 'New contact object contains the proper UID';
  nok $c1.is-parsed,                                 'New contact remains unparsed after UID check';
  my $c2 = Evolution::Contact.new-from-vcard(~$c1);
  nok $c2.is-parsed,                                 'Copy of new contact object is unparsed';
  ok  compare-single-value($c2, 'UID', 'other-uid'), 'Copy object contains the proper UID';

  $c2.unref;

  diag 'Parsed';
  $c1.get-const(E_CONTACT_FULL_NAME);
  ok  $c1.is-parsed,                                 'Contact is parsed after information retrieval';
  ok  compare-single-value($c1, 'UID', 'other-uid'), 'Contact contains the proper UID';
  $c2 = Evolution::Contact.new-from-vcard(~$c1);
  ok  $c2,                                           'Second contact, created from a stringification of the first, is defined';
  ok  compare-single-value($c2, 'UID', 'other-uid'), 'Second contact contains the proper UID';
  ok  has-only-one($c1, 'UID'),                      'First contact has a singular UID';
  ok  has-only-one($c2, 'UID'),                      'Second contact has a singular UID';

  .unref for $c1, $c2;

  diag 'Not parsed';
  $c1 = Evolution::Contact.new-from-vcard-with-uid($vcard-str, 'other-uid');
  ok  $c1,                                           'Contact with UID created from string, successfully';
  nok $c1.is-parsed,                                 'Contact is NOT parsed';
  ok  compare-single-value($c1, 'UID', 'other-uid'), 'Contact contains the proper UID';
  nok  $c1.is-parsed,                                'Contact remains unparsed';
  $c2 = Evolution::Contact.new-from-vcard(~$c1);
  ok  $c2,                                           'Second contact, created from stringified first, is defined';
  ok  compare-single-value($c2, 'UID', 'other-uid'), 'Second contact contains the proper UID';

  $c2.unref;

  diag 'Parse';
  $c1.get-const(E_CONTACT_FULL_NAME);
  ok  compare-single-value($c1, 'UID', 'other-uid'), 'Contact contains the proper UID after information retrieval';
  ok  $c1.is-parsed,                                 'Contact object is now parsed';
  $c2 = Evolution::Contact.new-from-vcard(~$c1);
  ok  $c2,                                           'Second contact, created from stringified first, is defined';
  ok  has-only-one($c1, 'UID'),                      'First contact has a singular UID';
  ok  has-only-one($c2, 'UID'),                      'Second contact has a singular UID';

  .unref for $c1, $c2;

  True
}

sub test_vcard_qp_2_1_parsing ($vcard-str, $expected-value) {
  my $vcard = Evolution::VCard.new-from-string($vcard-str);
  ok $vcard,                   'VCard created from string successfully';

  my $attr = $vcard.get-attribute('FN');
  ok $attr,                    'Attribute retrieved from VCard successfully';

  my $value = $attr.get-value;
  ok $value,                   'Value retrieved from Attribute successfully';

  is $value, $expected-value , 'Value matches expectation';

  # cw: Obligatory mention of roadmap.
  # $vcard.unref
}

sub test_vcard_qp_2_1_saving ($expected-text) {
  my $vcard = Evolution::VCard.new;
  my $attr  = Evolution::VCard::Attribute.new('FN', :name);
  my $param = Evolution::VCard::Attribute::Param.new('ENCODING');
  $param.add-value('quoted-printable');
  $attr.add-param($param);
  $attr.add-value-decoded($expected-text);

  my $decoded = $attr.get-value-decoded;
  ok   $decoded,                       'Decoded attribute value created successfully';
  is   $decoded.str,   $expected-text, 'Decoded attribute value matches expected value';

  my $encoded-value = $attr.get-value;
  ok   $encoded-value,                 'Encoded value is defined';
  isnt $encoded-value, $expected-text, 'Encoded value does NOT match expected value';

  $vcard.add-attribute($attr);
  my $str = $vcard.Str(EVC_FORMAT_VCARD_21);
  $vcard.unref;
  ok   $str,                           'Attribute is defined after VCard destruction';
  $vcard = Evolution::VCard.new-from-string($str);
  ok   $vcard,                         'VCard can be recreated from string representation';

  $attr    = $vcard.get-attribute('FN');
  $decoded = $attr.get-value-decoded;
  ok   $attr,                          'Retrieved attribute is defined';
  # Remember: $decoded is a GString!
  is   $decoded.str,   $expected-text, 'Decoded attribute matches expected value';

  True;
}

sub test_vcard_qp_3_0_saving ($expected-text) {
  my $vcard = Evolution::VCard.new;
  my $attr  = Evolution::VCard::Attribute.new('FN', :name);
  my $param = Evolution::VCard::Attribute::Param.new('ENCODING');
  $param.add-value('quoted-printable');
  $attr.add-param($param);
  $attr.add-value-decoded($expected-text);
  $vcard.add-attribute($attr);

  my $decoded = $attr.get-value-decoded;
  ok   $decoded,                       'Decoded attribute value is defined';
  # cw: Also note... I can't say GString with a straight face...
  is   $decoded.str,  $expected-text,  'Decoded value matches expected text';
  $decoded.free(True);

  my $encoded-value = $attr.get-value;
  ok   $encoded-value,                 'Encoded value retrieved from attribute is defined';
  isnt $encoded-value, $expected-text, 'Encoded value cannot match expected text';

  my $str = ~$vcard;
  $vcard.unref;
  ok   $str,                           'Stringified object still exists after origin is unref\'d';
  $vcard  = Evolution::VCard.new-from-string($str);
  ok   $vcard,                         'New object created from string representation succeeds';
  $attr   = $vcard.get-attribute('FN');
  ok   $attr,                          'Attribute retrieval from VCard succeeds';
  $decoded = $attr.get-value-decoded;
  ok   $decoded,                       'Round trip decoded attribute value is defined';
  is   $decoded.str,   $expected-text, 'Round trip decoded value matches expected text';
  $decoded.free(True);

  my $value = $attr.get-value;
  ok   $value,                         'Value retrieved from attribute is defined';
  isnt $value,         $encoded-value, 'Value does not match encoded value';

  True;
}

sub test-vcard-quoted-printable {
  constant EXPECTED-TEXT =
    'ActualValue ěščřžýáíéúůóöĚŠČŘŽÝÁÍÉÚŮÓÖ§ ' ~
    '1234567890 1234567890 1234567890 1234567890 1234567890';

  constant VCARD_21 = qq:to/_VCARD/.chomp.&crlf;
    BEGIN:VCARD
    VERSION:2.1
    FN;ENCODING=quoted-printable:ActualValue=20=C4=9B=C5=A1{
    '' }=C4=8D=C5=99=C5=BE=C3=BD=C3=A1=C3=AD=C3=A9=C3=BA=C5=AF=C3{
    '' }=B3=C3=B6=C4=9A=C5=A0=C4=8C=C5=98=C5=BD=C3=9D=C3=81=C3=8D{
    '' }=C3=89=C3=9A=C5=AE=C3=93=C3=96=C2=A7=201234567890=2012345{
    '' }67890=201234567890=201234567890=201234567890
    END:VCARD
    _VCARD

   ok test_vcard_qp_2_1_parsing(VCARD_21, EXPECTED-TEXT), 'VCard 2.1 text representation parses correctly';
   ok test_vcard_qp_2_1_saving(EXPECTED-TEXT),            'VCard 2.1 text representation parses correctly';
   ok test_vcard_qp_3_0_saving(EXPECTED-TEXT),            'VCard 3.0 text representation parses correctly';
}

constant TEST-VCARD-NO-UID-STR = q:to/VCARD-DEF/.chomp.&crlf;
  BEGIN:VCARD
  VERSION:3.0
  EMAIL;TYPE=OTHER:zyx@no.where
  FN:zyx mix
  N:zyx;mix;;;
  END:VCARD
  VCARD-DEF

constant TEST-VCARD-WITH-UID-STR = q:to/VCARD-DEF/.chomp.&crlf;
  BEGIN:VCARD
  VERSION:3.0
  UID:some-uid
  EMAIL;TYPE=OTHER:zyx@no.where
  FN:zyx mix
  N:zyx;mix;;;
  END:VCARD
  VCARD-DEF

sub test-vcard-with-uid {
  subtest { test-vcard(TEST-VCARD-WITH-UID-STR) },    'VCard with UID';
}

sub test-vcard-without-uid {
  subtest { test-vcard(TEST-VCARD-NO-UID-STR) },      'VCard with no UID';
}

sub test-contact-with-uid {
  subtest { test-econtact(TEST-VCARD-WITH-UID-STR) }, 'EContact with UID';
}

sub test-contact-without-uid {
  subtest { test-econtact(TEST-VCARD-NO-UID-STR) },   'EContact with no UID';
}

sub test-phone-params-and-value (
  $contact,
  $field-id,
  $expected-value,
  $expected-value-type
) {
  is   $contact.objectType.Int,       Evolution::Contact.get-type, 'Contact object is an EContact';
  my $field-value = $contact.get-const($field-id);
  ok   $field-value,                                               "Can get a defined value for field '{$field-id}'";
  is   $field-value, $expected-value,                              'Field value matches expection';
  my $attributes = $contact.get-contact-attributes($field-id);
  ok   $attributes,                                                "Field '{ $field-id }' has defined attributes";
  is   $attributes.elems,             3,                           'The number of those attributes is 3';

  my $attr;
  for $attributes.kv -> $k, $v {
    ok $v,                                                         "Attribute {$k} is defined";
    my $value = $v.get-value;
    ok $value,                                                     "Attribute {$k} has a defined value";
    if $value eq $expected-value {
      $attr = $v;
      last;
    }
  }

  ok   $attr,                                                      'Proper attribute was found';
  ok   $attr.get-name,                                             'Attribute name is defined';

  my $params = $attr.get-params;
  is   $params.elems,                 2,                           'Attribute has 2 parameters';

  for $params.kv -> $k, $v {
    ok $v,                                                         "Parameter {$k} is defined";
    my $name = $v.get-name;
    ok $name,                                                      "Parameter {$k} has a defined name";
    is $name,                         (EVC_TYPE, EVC_X_E164).any,  'Parameter is of class TYPE or X_E164';

    my $values = $v.get-values;

    ok $values,                                                     'Parameter has defined values';
    if $name.lc eq EVC_X_E164.lc {
      ok $values.elems < 2,                                         'EVC_X_E164 Parameter has less than 2 values';
      ok $values[0],                                                'First parameter value is defined';
      is $values[0],                  $expected-value,              'Parameter value matches expected value';
      if $values[1] {
        is $values[1],                                              'Second value is present but it is a Nil string';
      }
    } else {
      ok $values.elems >= 2,                                        'Non EVC_X_E164 parameter has at least 2 values';
      ok $values.elems <  3,                                        'Non EVC_X_E164 parameter has less than 3 values';
      #
      # diag "V: $values";
      #
      ok $values[0],                                                'First parameter value is defined';
      ok $values[1],                                                'Second parameter value is defined';
      is $values[0],                   $expected-value-type,        'First parameter value type matches expectation';
      is $values[1],                   'VOICE',                     "Second parameter value matches 'VOICE'";
    }
  }
}

sub test-contact-empty-value {
  my $contact = Evolution::Contact.new-from-vcard(q:to/VCARD/.chomp.&crlf);
    BEGIN:VCARD
    UID:some-uid
    REV:2017-01-12T11:34:36Z(0)
    FN:zyx
    N:zyx;;;;
    EMAIL;TYPE=WORK:work@no.where
    TEL;X-EVOLUTION-E164=00123456789,;TYPE=WORK,VOICE:00123456789
    TEL;TYPE=WORK;TYPE=VOICE;X-EVOLUTION-E164=11123456789,:11123456789
    TEL;X-EVOLUTION-E164=002233445566;TYPE=HOME,VOICE:002233445566
    END:VCARD
    VCARD

  is $contact.objectType.Int, Evolution::Contact.get-type, 'Contact object is an EContact';

  test-phone-params-and-value(
    $contact,
    E_CONTACT_PHONE_BUSINESS,
    '00123456789',
    'WORK'
  );

  test-phone-params-and-value(
    $contact,
    E_CONTACT_PHONE_BUSINESS_2,
    '11123456789',
    'WORK'
  );

  test-phone-params-and-value(
    $contact,
    E_CONTACT_PHONE_HOME,
    '002233445566',
    'HOME'
  );

}

sub test-construction-vcard-attribute-with-group {
  my $attr1 = Evolution::VCard::Attribute.new('X-TEST',    :name);
  my $attr2 = Evolution::VCard::Attribute.new('',       'X-TEST');
  my $attr3 = Evolution::VCard::Attribute.new('GROUP',  'X-TEST');

  nok $attr1.get-group,          'First attribute does not have a group';
  nok $attr2.get-group,          'Second attribute does not have a group';
  is  $attr3.get-group, 'GROUP', "Third attribute has a group named 'GROUP'";

  .free for $attr1, $attr2, $attr3;
}

test-vcard-with-uid;
test-vcard-without-uid;
test-vcard-quoted-printable;
test-contact-with-uid;
test-contact-without-uid;
test-contact-empty-value;
test-construction-vcard-attribute-with-group;
