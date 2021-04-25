use v6.c;

use Test;

use Evolution::Raw::Types;

use Evolution::VCard;

sub compare-single-value ($vcard, $attrname, $value) {
  ok $vcard,       'VCard is defined';
  ok $attrname,    'Attribute name is defined';
  ok $value,       'Value is defined';

  my $attr = $vcard.get_attribute($attrname);
  ok $attr,        'Attribute is defined';

  my $str = $vcard.get_value($attr);
  ok $str,         'Attribute value is defined';
  is $str, $value, 'Attribute value matches expected result';

  True;
}

sub has-only-one ($vcard, $attrname) {
  my $found = False
  for $vcard.get-attributes {
    if $attrname eq $_ {
      return False if $found;
      $found = True;
    }
  }
  $found;
}

sub test-vcard ($vcard-str) {
  my $vc1 = Evolution::VCard.new-from-string($vcard-str);
  my $str = ~$vc1;
  ok  $str,                                           'Stringified VCard is defined';
  is $str, $vcard-str,                                'Stringified VCard matches origin';

  $vc1.get-attribute('FN');
  ok  $vc1.is-parsed,                                 'VCard parsed successfully';
  ok  ~$vc1,                                          'Stringified VCard is defined     (repeat?)';
  is  $str, $vcard-str,                               'Stringified VCard matches origin (repeat?)';

  $vc1 = Evolution::VCard.new-from-string($vcard-str);
  $vc1.append-attribute-with-value(
    Evolution::VCard::Attribute.new('UID', :name),
    'other-uid'
  );
  nok $vc1.is-parsed,                                 'VCard with attribute is not parsed';

  # Getting FN will parse
  $vc1.get-attribute('FN');
  ok  $vc1.is-parsed,                                 'VCard parsed after retrieving attribute';
  my $vc2 = Evolution::VCard.new-from-string(~$vc1);
  ok  compare-single-value($vc2, 'UID', 'other-uid'), 'Created attribute is present in a copied VCard';

  $vc1.get-attribute('FN');
  ok  $vc1.is-parsed,                                 'First VCard re-parsed correctly';
  ok  compare-single-value($vc1, 'UID', 'other-uid'), 'Created attribute is present in a original VCard';
  nok $vc2.is-parsed,                                 'Copied VCard is not parsed';
  ok  compare-single-value($vc2, 'UID', 'other-uid'), 'Created attribute is present remains valid in copied VCard';
  ok  has-only-one($vc1, 'UID');
  ok  has-only-one($vc2, 'UID');

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
  $str = ~$c1;
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
  pl  $c1.is-parsed,                                 'Contact object is now parsed';
  $c2 = Evolution::contact.new-from-vcard(~$c1);
  ok  $c2,                                           'Second contact, created from stringified first, is defined';
  ok  has-only-one($c1, 'UID'),                      'First contact has a singular UID';
  ok  has-only-one($c2, 'UID'),                      'Second contact has a singular UID';

  .unref for $c1, $c2;

  True
}

sub test-vcard-qp-2-1-parsing ($vcard-str, $expected-value) {
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

sub test-vcard-qp-2-1-saving ($expected-text) {
  my $vcard = Evolution::VCard.new;
  my $attr  = Evolution::VCard::Attribute.new($fn, :name);
  my $param = Evolution::VCard::Attribute::Param.new('ENCODING');
  $param.add-value('quoted-printable');
  $attr.add-param($param);
  $attr.add-value-decoded($expected-text);

  my $decoded = $attr.get-value-decoded;
  ok   $decoded,                       'Decoded attribute value created successfully';
  is   $decoded, $expected-text,       'Decoded attribute value matches expected value';

  my $encoded-value = $attr.get-value;
  ok   $encoded-value,                 'Encoded value is defined';
  isnt $encoded-value, $expected-text, 'Encoded value does NOT match expected value';

  $vcard.add-attribute($attr);
  my $str = $vcard.Str(EVC_FORMAT_VCARD_21);
  $vcard.unref;
  ok   $str,                           'Attribute is defined after VCard destruction';
  $vcard = Evolution::VCard.new-from-string($str);
  ok   $vcard,                         'VCard can be recreated from string representation';

  $attr = $vcard.get-attribute('FN');
  my $decoded = $attr.get-value-decoded;
  ok   $attr,                          'Retrieved attribute is defined';
  # Remember: $decoded is a GString!
  ok   $decoded.str,   $expected-text, 'Decoded attribute matches expected value';

  True;
}

sub test-vcard-qp-3-0-saving ($expected-text) {
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
  $vcard = Evolution::VCard.new-from-string($str);
  ok   $vcard,                         'New object created from string representation succeeds';
  my $attr = $vcard.get-attribute('FN');
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
