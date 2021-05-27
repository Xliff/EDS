use Test;

use Evolution::Raw::Types;

use GLib::Base64;
use Evolution::Contact;

constant TEST_ID = "test-uid";

sub test-string ($f) {
  $f<contact>.set(E_CONTACT_UID, TEST_ID);
  is $f<contact>.get-const(E_CONTACT_UID), TEST_ID, 'Contact UID can be set and retrieved without issue';
}

sub test-date ($f) {
  my $d = EContactDate.new(1900, 3, 3, :intl);

  $f<contact>.set(E_CONTACT_BIRTH_DATE, $d);
  my $dp = $f<contact>.get(E_CONTACT_BIRTH_DATE);

  is $dp.year,  $d.year,  'Retrieved year is correct';
  is $dp.month, $d.month, 'Retrieved month is correct';
  is $dp.day,   $d.day,   'Retrieved day is correct';
}

sub test-certificates($f) {
  my ($pgp-blob, $x509-blob) = (
    "fake\tpgp-certificate-blob\n\x1\x2\x3\x4\x5\x6\x7\x8\x9\x0 abc",
    "fake\tx.509-certificate-blob\n\x1\x2\x3\x4\x5\x6\x7\x8\x9\x0 def"
  )».encode;

  {
    my $cert = Evolution::Contact::Cert.new($pgp-blob);
    $f<contact>.set(E_CONTACT_PGP_CERT, $cert);
  }

  {
    my $cert = Evolution::Contact::Cert.new($x509-blob);
    $f<contact>.set(E_CONTACT_X509_CERT, $cert);
  }

  for E_CONTACT_PGP_CERT, E_CONTACT_X509_CERT {
    diag $_;
    my $cert = $f<contact>.get($_);
    ok $cert,                          'Certificate data retrieved from contact is defined';
    my $cert-data := $_ == E_CONTACT_PGP_CERT ?? $pgp-blob !! $x509-blob;
    is $cert.length, $cert-data.bytes, 'Certificate data has the right length';
    ok $cert.compare($cert-data),      'Retrieved certificate matches expected PGP data';
  }
}

my $photo-data = q:to/BLOCK/.chomp.split("\n").join('');
  /9j/4AAQSkZJRgABAQEARwBHAAD//gAXQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q/9sAQwAIBgYHB
  gUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCMcHCg3KSwwMTQ0NB8nOT04Mjw
  uMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyM
  jIyMjIyMjIyMjIyMjIyMjIy/8AAEQgAMgAyAwEiAAIRAQMRAf/EABsAAQACAwEBAAAAAAAAAAA
  AAAAHCAQFBgID/8QAMBAAAgEDAQYEBQQDAAAAAAAAAQIDAAQRBQYSEyExQQdhcYEiI0JRkRQVM
  qFiguH/xAAaAQADAQEBAQAAAAAAAAAAAAAABAUCBgED/8QAIxEAAgICAQQCAwAAAAAAAAAAAAE
  CAwQRQRITITEUYQUiUf/aAAwDAQACEQMRAD8An+sHUtWtNKjVrmQ7754cajLvjrgfbzPIdzWdV
  fds9pJb3XdQkMrcFZGj+HqY0bdVV9Tz/wBia+N9vbjvkaxMb5E9N6SJB1HxLEEjJaWsUjD6QzS
  MPXdGB7E1zV74t63HINy1s4F7CWCTn77wrA0TY86jY3N1qsUk6wxBxBDvYjLHkoUH4j3JP/a0V
  3s1CvF/QM9tKpw0THeU+TLkj8VLnmzT8y0n9FujBx5bioba/rZLWx3iPZ7RzLp95GtnqRGVTez
  HNjruH7/4n+67iqpq7Qi3uYWMMsNynfnE6sM8/Lr6VamFi0KMepUE1Sx7XZHbI+fjxos1H0z3S
  lKYEjzISI2I64OKqsyu8sck2QYrmPjBvpIYg598Vauoh8VtlY7JW2isoBwpPl6hGByZTyD+o6E
  +h7UtlVOcPHA/+PyI1Wal6Zp7vaC/06wnTTLtEeUDiKwzu4H8vI9AM9Tiuctkng1Nnk1G5cOoY
  ifB4nI/jB7VjWuoT21qPmwXUCHKlphHKvqG5N6g0/cLi/Rg88FhbkbxlaUSu3kqpnn6kDzqGqb
  NdPB0XyK4/svZr9RVntL50GePdcKEDqzhVBx7sKtPpayppNosxzKIlDHzxUFeG2zo2n2kivWhK
  6PpHwwoTnfk65J7kZyT9z5VYADAwKuYtfRA5zPv7tnjgUpSmREV8bq1hvbWW1uY1khlUo6MMhg
  eor7UoAje18FtmLe9eeQT3EXPcglkJRPbv71EWu7Dajp2o3MGmlRCkjKQ30jPUe1WlrlNW0Rpt
  TleNB84DnjkD0P9VlxT4Nqck9pmn8JuFp2zo0cgCWFi2e7555/NSHXLadso2m3sU0NxlV65HM+
  VdTW3rgwvsUpSvAFKUoAUxSlAClKUAKUpQB//2Q==
  BLOCK

sub test-photo ($f) {
  my $data  = GLib::Base64.decode($photo-data);
  my $photo = Evolution::Contact::Photo.new($data[0], length => $data[1]);

  $f<contact>.set(E_CONTACT_PHOTO, $photo);
  my $new-photo = $f<contact>.get(E_CONTACT_PHOTO);

  is  $new-photo.data.inlined.length, $photo.data.inlined.length, 'Photo sizes match';
  ok  $photo.compare($new-photo),                                 'Photo data matches';
}

sub test-categories-initially-null-list ($f) {
  nok $f<contact>.get(E_CONTACT_CATEGORY_LIST),  'Category list is not defined';
}

sub test-categories-convert-to-string ($f) {
  $f<contact>.set(
    E_CONTACT_CATEGORY_LIST,
    GLib::GList.new.append(<Birthday Business Competition>)
  );

  is $f<contact>.get(E_CONTACT_CATEGORIES), 'Birthday,Business,Competition', 'Contact category list can be set and retrieved with no issue';
}

sub test-categories-convert-to-list ($f) {
  $f<contact>.set(E_CONTACT_CATEGORIES, 'Birthday,Business,Competition');

  my $category-list = $f<contact>.get(E_CONTACT_CATEGORY_LIST);

  is   $category-list.elems, 3,    'Retrieved the proper number of categories from contact';
  for ($category-list.Array.sort Z <Birthday Business Competition>) {
    is .[0],                 .[1], "Category { .[1] } appears in contact category list";
  }
}

sub createContact {
  (
    contact => Evolution::Contact.new
  );
}

subtest '/Contact/Types/String', {
  my %f = createContact;
  test-string(%f);
  %f<contact>.unref;
};

subtest '/Contact/Types/Date', {
  my %f = createContact;
  test-date(%f);
  %f<contact>.unref;
}

subtest '/Contact/Types/Certificates', {
  CATCH { default { .message.say; .backtrace.concise.say } }
  my %f = createContact;
  test-certificates(%f);
  %f<contact>.unref;
}

subtest '/Contact/Types/Photo', {
  my %f = createContact;
  test-photo(%f);
  %f<contact>.unref;
}

subtest '/Contact/Types/Categories/InitiallyNullList', {
  my %f = createContact;
  test-categories-initially-null-list(%f);
  %f<contact>.unref;
}

subtest '/Contact/Types/Categories/ConvertToString', {
  my %f = createContact;
  test-categories-convert-to-string(%f);
  %f<contact>.unref;
}

subtest '/Contact/Types/Categories/ConvertToList', {
  my %f = createContact;
  test-categories-convert-to-list(%f),
  %f<contact>.unref;
}
