use v6.c;

use Test;

use Evolution::Raw::Types;
use Evolution::Contact;

constant VCARD = q:to/VCARD/.chomp;
  BEGIN:VCARD
  FN:Janet Jackson
  N:Janet
  TEL;WORK,VOICE:123-123-1234
  TEL;VOICE:456-456-4567
  TEL;FAX:321-321-4321
  END:VCARD
  VCARD

sub number-test ($t, $pn) {
  my $contact = Evolution::Contact.new-from-vcard(VCARD);
  my $phone   = $contact.get-const($t);

  ok  $phone,      'Phone number exists and is defined';
  is  $phone, $pn, "Phone number matches expected value of '{ $pn }'";
}

sub test-business    { number-test(E_CONTACT_PHONE_BUSINESS,  '123-123-1234') }
sub test-other-phone { number-test(E_CONTACT_PHONE_OTHER,     '456-456-4567') }
sub test-other-fax   { number-test(E_CONTACT_PHONE_OTHER_FAX, '321-321-4321') }

test-business;
test-other-phone;
test-other-fax
