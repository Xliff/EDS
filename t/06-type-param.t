use v6.c;

use Test;

use Evolution::Raw::Types;

use Evolution::Contact;

class TestData {
  has Str           $!vcard-str;
  has EContactField $.field-id   is rw;
  has Str           $!expected;

  submethod BUILD (:$!vcard-str, :$!field-id, :$!expected) { }

  method gist {
    diag qq:to/GIST/;
      TestData.new(
        vcard-str => { $!vcard-str // '(Nil)' },
        field-id  => { $!field-id  },
        expected  => { $!expected  // '(Nil)' }
      );
      GIST
  }

  method new ($vc, $fi, $ex) {
    self.bless( vcard-str => $vc, field-id => $fi, expected => $ex );
  }
}
buildAccessors(TestData);

sub test-type-param (@datas, &check-value = Callable) {
  my $vcard-string;

  for @datas {
    #diag "From: { callframe(3).code.name }";
    #.gist;
    $vcard-string = .vcard-str if .vcard-str.defined;

    ok      $vcard-string,                   'A VCARD string exists to be tested';

    my $contact = Evolution::Contact.new-from-vcard($vcard-string);
    ok      $contact,                        'Contact object created from VCARD string, successfully';

    #diag "C:\n{ ~$contact }";

    my $value = $contact.get( .field-id );
    if .expected {
      if &check-value {
        ok  &check-value($value, .expected), 'Value matches expected data using provided comparitor'
      } else {
        is  $value,  .expected,              'Value matches expected data using default comparison';
      }
    } else {
      nok   $value,                          'No value was expected';
    }

    # cw: A reminder that this will eventually be implicit by scope.
    $contact.unref;
  }
}

sub test-type-param-email {
  my @datas = (
    [ q:to/VCARD/, E_CONTACT_EMAIL_1, 'V1' ],
      BEGIN:VCARD
      EMAIL;TYPE=home:V1
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_EMAIL_2, Str ],
    [ Str,         E_CONTACT_EMAIL_3, Str ],
    [ Str,         E_CONTACT_EMAIL_4, Str ],

    [ q:to/VCARD/, E_CONTACT_EMAIL_1, 'V1' ],
      BEGIN:VCARD
      EMAIL;TYPE=home:V1
      EMAIL;TYPE=home:V2
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_EMAIL_2, 'V2' ],
  	[ Str,         E_CONTACT_EMAIL_3, Str  ],
  	[ Str,         E_CONTACT_EMAIL_4, Str  ],

    [ q:to/VCARD/, E_CONTACT_EMAIL_1, 'V1' ],
      BEGIN:VCARD
      EMAIL;TYPE=home:V1
      EMAIL;TYPE=home:V2
      EMAIL;TYPE=home:V3
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_EMAIL_2, 'V2' ],
    [ Str,         E_CONTACT_EMAIL_3, 'V3' ],
    [ Str,         E_CONTACT_EMAIL_4, Str  ],

    [ q:to/VCARD/, E_CONTACT_EMAIL_1, 'V1' ],
      BEGIN:VCARD
      EMAIL;TYPE=home:V1
      EMAIL;TYPE=home:V2
      EMAIL;TYPE=home:V3
      EMAIL;TYPE=home:V4
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_EMAIL_2, 'V2' ],
    [ Str,         E_CONTACT_EMAIL_3, 'V3' ],
    [ Str,         E_CONTACT_EMAIL_4, 'V4' ],

    [ q:to/VCARD/, E_CONTACT_EMAIL_1, 'V1' ],
      BEGIN:VCARD
      EMAIL;TYPE=home:V1
      EMAIL;TYPE=home:V2
      EMAIL;TYPE=home:V3
      EMAIL;TYPE=home:V4
      EMAIL;TYPE=home:V5
      END:VCARD
      VCARD

  ).map({ TestData.new( |$_ ) });

  .gist.say for @datas;

  test-type-param(@datas);
}

sub test-type-param-adr {
  my @datas = (
    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME, 'V1' ],
      BEGIN:VCARD
      ADR;TYPE=home:;;V1;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK,  Str ],
  	[ Str,         E_CONTACT_ADDRESS_OTHER, Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  Str ],
      BEGIN:VCARD
      ADR:;;V1;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK, 'V1' ],
		[ Str,         E_CONTACT_ADDRESS_OTHER, Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  Str ],
      BEGIN:VCARD
      ADR;TYPE=work:;;V1;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK, 'V1' ],
    [ Str,         E_CONTACT_ADDRESS_OTHER, Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  Str ],
      BEGIN:VCARD
      ADR;TYPE=other:;;V1;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK,   Str ],
    [ Str,         E_CONTACT_ADDRESS_OTHER, 'V1' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  'V1' ],
      BEGIN:VCARD
      ADR;TYPE=dom;TYPE=home:;;V1;;;;
      ADR;TYPE=postal,work:;;V2;;;;
      ADR;TYPE=postal,intl;TYPE=parcel,other:;;V3;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK,  'V2' ],
    [ Str,         E_CONTACT_ADDRESS_OTHER, 'V3' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  'V2' ],
      BEGIN:VCARD
      ADR:;;V1;;;;
      ADR;TYPE=dom;TYPE=home:;;V2;;;;
      ADR;TYPE=postal,intl;TYPE=parcel,other:;;V3;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK,  'V1' ],
 	  [ Str,         E_CONTACT_ADDRESS_OTHER, 'V3' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_HOME,  Str ],
      BEGIN:VCARD
      ADR;TYPE=dom:;;V1;;;;
      ADR:;;V2;;;;
      ADR;TYPE=postal,intl;TYPE=parcel,other:;;V3;;;;
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_WORK,  'V2' ],
    [ Str,         E_CONTACT_ADDRESS_OTHER, 'V3' ]
  ).map({ TestData.new( |$_ ) });

  test-type-param(@datas, -> $addr, $expected {
    ok $addr,                   'Address is defined';
    ok $expected,               'Expected value is defined';
    is $addr.street, $expected, 'Address street matches expected value.'
  });
}

sub test-type-param-label {
  my @datas = (
    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME, 'V1' ],
      BEGIN:VCARD
      LABEL;TYPE=home:V1
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,  Str ],
  	[ Str,         E_CONTACT_ADDRESS_LABEL_OTHER, Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,  Str ],
      BEGIN:VCARD
      LABEL:V1
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,  'V1' ],
  	[ Str,         E_CONTACT_ADDRESS_LABEL_OTHER, Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,  Str ],
      BEGIN:VCARD
      LABEL;TYPE=work:V1
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,  'V1'  ],
    [ Str,         E_CONTACT_ADDRESS_LABEL_OTHER,  Str ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,   Str ],
      BEGIN:VCARD
      LABEL;TYPE=other:V1
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,   Str ],
		[ Str,         E_CONTACT_ADDRESS_LABEL_OTHER,  'V1' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,   'V1' ],
      BEGIN:VCARD
      LABEL;TYPE=dom;TYPE=home:V1
      LABEL;TYPE=postal,work:V2
      LABEL;TYPE=postal,intl;TYPE=parcel,other:V3
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,   'V2' ],
    [ Str,         E_CONTACT_ADDRESS_LABEL_OTHER,  'V3' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,   'V2' ],
      BEGIN:VCARD
      LABEL:V1
      LABEL;TYPE=dom;TYPE=home:V2
      LABEL;TYPE=postal,intl;TYPE=parcel,other:V3
      END:VCARD
      VCARD

    [ Str,         E_CONTACT_ADDRESS_LABEL_WORK,   'V1' ],
    [ Str,         E_CONTACT_ADDRESS_LABEL_OTHER,  'V3' ],

    [ q:to/VCARD/, E_CONTACT_ADDRESS_LABEL_HOME,   Str ],
      BEGIN:VCARD
      LABEL;TYPE=dom:V1
      LABEL:V2
      LABEL;TYPE=postal,intl;TYPE=parcel,other:V3
      END:VCARD
      VCARD

    [ Str,        E_CONTACT_ADDRESS_LABEL_WORK,   'V2' ],
  	[ Str,        E_CONTACT_ADDRESS_LABEL_OTHER,  'V3' ]
  ).map({ TestData.new( |$_ ) });

  test-type-param(@datas);
}

sub test-type-param-key {
  my @datas = (
    [ q:to/VCARD/, E_CONTACT_X509_CERT, 'V1' ],
      BEGIN:VCARD
      KEY;TYPE=x509:V1
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, Str ],

    [ q:to/VCARD/, E_CONTACT_X509_CERT, Str ],
      BEGIN:VCARD
      KEY;TYPE=pgp:V1
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, 'V1' ],

    [ q:to/VCARD/,  E_CONTACT_X509_CERT, 'V1' ],
      BEGIN:VCARD
      KEY;TYPE=X509;TYPE=x-test:V1
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, Str ],

    [ q:to/VCARD/, E_CONTACT_X509_CERT, Str ],
      BEGIN:VCARD
      KEY;TYPE=PGP;TYPE=x-test:V1
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, 'V1' ],

    [ q:to/VCARD/, E_CONTACT_X509_CERT, 'V1' ],
      BEGIN:VCARD
      KEY;TYPE=x-test,x509:V1
      KEY;TYPE=x-test,pgp:V2
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, 'V2' ],

    [ q:to/VCARD/,  E_CONTACT_X509_CERT, Str ],
      BEGIN:VCARD
      KEY:V1
      KEY;TYPE=x-test:V2
      END:VCARD
      VCARD

    [ Str, E_CONTACT_PGP_CERT, Str ]
  ).map({ TestData.new( |$_ ) });

  test-type-param(@datas, -> $cert, $e {
    ok $cert,                                           'Certificate is defined';
    ok $e,                                              'Expected value is defined';
    is Buf.new( $cert.data[^$cert.length] ).decode, $e, 'Certificate matches expected value';
  });
}

sub test-type-param-tel {
  my $vcard1 = qq:to/VCARD/;
    BEGIN:VCARD
    TEL;TYPE={ EVC_X_ASSISTANT }:V1
    TEL;TYPE=work:V2
    TEL;TYPE=work,voice:V3
    TEL;TYPE=work;TYPE=fax:V4
    TEL;TYPE={ EVC_X_CALLBACK }:V5
    TEL;TYPE=car:V6
    TEL;TYPE={ EVC_X_COMPANY }:V7
    TEL;TYPE=voice,home:V8
    TEL;TYPE=home:V9
    TEL;TYPE=fax;Type=home:V10
    TEL;TYPE=ISDN:V11
    TEL;TYPE=cell:V12
    TEL;TYPE=voice:V13
    TEL;TYPE=fax:V14
    TEL;TYPE=pager:V15
    TEL;TYPE=pref:V16
    TEL;TYPE={ EVC_X_RADIO }:V17
    TEL;TYPE={ EVC_X_TELEX }:V18
    TEL;TYPE={ EVC_X_TTYTDD }:V19
    END:VCARD
    VCARD

  my $vcard2 = qq:to/VCARD/;
    BEGIN:VCARD
    TEL;TYPE={ EVC_X_ASSISTANT };Type=msg:V1
    TEL;Type=msg;TYPE=work:V2
    TEL;TYPE=work,msg;type=Voice:V3
    TEL;TYPE=work;Type=msg;TYPE=fax:V4
    TEL;TYPE=msg,{ EVC_X_CALLBACK }:V5
    TEL;TYPE=msg,car:V6
    TEL;TYPE={ EVC_X_COMPANY },msg:V7
    TEL;TYPE=voice,msg,home:V8
    TEL;TYPE=home,msg:V9
    TEL;TYPE=fax,msg;Type=home:V10
    TEL;TYPE=msg,Isdn:V11
    TEL;TYPE=cELL,msg:V12
    TEL:V13
    TEL;TYPE=fax,msg:V14
    TEL;TYPE=pager,msg:V15
    TEL;TYPE=pref,msg:V16
    TEL;TYPE=msg,{ EVC_X_RADIO }:V17
    TEL;Type=msg;TYPE={ EVC_X_TELEX }:V18
    TEL;TYPE={ EVC_X_TTYTDD };Type=msg:V19
    END:VCARD
    VCARD

  my @datas = (
    [ $vcard1, E_CONTACT_PHONE_ASSISTANT,           'V1'  ],
    [ Str,     E_CONTACT_PHONE_BUSINESS,            'V2'  ],
		[ Str,     E_CONTACT_PHONE_BUSINESS_2,          'V3'  ],
		[ Str,     E_CONTACT_PHONE_BUSINESS_FAX,        'V4'  ],
		[ Str,     E_CONTACT_PHONE_CALLBACK,            'V5'  ],
		[ Str,     E_CONTACT_PHONE_CAR,                 'V6'  ],
		[ Str,     E_CONTACT_PHONE_COMPANY,             'V7'  ],
		[ Str,     E_CONTACT_PHONE_HOME,                'V8'  ],
		[ Str,     E_CONTACT_PHONE_HOME_2,              'V9'  ],
		[ Str,     E_CONTACT_PHONE_HOME_FAX,            'V10' ],
		[ Str,     E_CONTACT_PHONE_ISDN,                'V11' ],
		[ Str,     E_CONTACT_PHONE_MOBILE,              'V12' ],
		[ Str,     E_CONTACT_PHONE_OTHER,               'V13' ],
		[ Str,     E_CONTACT_PHONE_OTHER_FAX,           'V14' ],
		[ Str,     E_CONTACT_PHONE_PAGER,               'V15' ],
		[ Str,     E_CONTACT_PHONE_PRIMARY,             'V16' ],
		[ Str,     E_CONTACT_PHONE_RADIO,               'V17' ],
		[ Str,     E_CONTACT_PHONE_TELEX,               'V18' ],
		[ Str,     E_CONTACT_PHONE_TTYTDD,              'V19' ],
    [ $vcard2, E_CONTACT_PHONE_ASSISTANT,           'V1'  ],
    [ Str,     E_CONTACT_PHONE_BUSINESS,            'V2'  ],
		[ Str,     E_CONTACT_PHONE_BUSINESS_2,          'V3'  ],
		[ Str,     E_CONTACT_PHONE_BUSINESS_FAX,        'V4'  ],
		[ Str,     E_CONTACT_PHONE_CALLBACK,            'V5'  ],
		[ Str,     E_CONTACT_PHONE_CAR,                 'V6'  ],
		[ Str,     E_CONTACT_PHONE_COMPANY,             'V7'  ],
		[ Str,     E_CONTACT_PHONE_HOME,                'V8'  ],
		[ Str,     E_CONTACT_PHONE_HOME_2,              'V9'  ],
		[ Str,     E_CONTACT_PHONE_HOME_FAX,            'V10' ],
		[ Str,     E_CONTACT_PHONE_ISDN,                'V11' ],
		[ Str,     E_CONTACT_PHONE_MOBILE,              'V12' ],
		[ Str,     E_CONTACT_PHONE_OTHER,               'V13' ],
		[ Str,     E_CONTACT_PHONE_OTHER_FAX,           'V14' ],
		[ Str,     E_CONTACT_PHONE_PAGER,               'V15' ],
		[ Str,     E_CONTACT_PHONE_PRIMARY,             'V16' ],
		[ Str,     E_CONTACT_PHONE_RADIO,               'V17' ],
		[ Str,     E_CONTACT_PHONE_TELEX,               'V18' ],
		[ Str,     E_CONTACT_PHONE_TTYTDD,              'V19' ],

    [ q:to/VCARD/, E_CONTACT_PHONE_ASSISTANT,       Str   ],
      BEGIN:VCARD
      TEL;Type=msg:V1
      TEL;TYPE=msg;type=Voice:V2
      TEL:V3
      END:VCARD
      VCARD

    [ Str,          E_CONTACT_PHONE_BUSINESS,       Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_2,     Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_FAX,   Str  ],
    [ Str,          E_CONTACT_PHONE_CALLBACK,       Str  ],
    [ Str,          E_CONTACT_PHONE_CAR,            Str  ],
    [ Str,          E_CONTACT_PHONE_COMPANY,        Str  ],
    [ Str,          E_CONTACT_PHONE_HOME,           Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_2,         Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_FAX,       Str  ],
    [ Str,          E_CONTACT_PHONE_ISDN,           Str  ],
    [ Str,          E_CONTACT_PHONE_MOBILE,         Str  ],
    [ Str,          E_CONTACT_PHONE_OTHER,          'V2' ],
    [ Str,          E_CONTACT_PHONE_OTHER_FAX,      Str  ],
    [ Str,          E_CONTACT_PHONE_PAGER,          Str  ],
    [ Str,          E_CONTACT_PHONE_PRIMARY,        Str  ],
    [ Str,          E_CONTACT_PHONE_RADIO,          Str  ],
    [ Str,          E_CONTACT_PHONE_TELEX,          Str  ],
    [ Str,          E_CONTACT_PHONE_TTYTDD,         Str  ],

    [ q:to/VCARD/,  E_CONTACT_PHONE_ASSISTANT,      Str  ],
      BEGIN:VCARD
      TEL;Type=msg:V1
      TEL:V2
      TEL;TYPE=msg;type=Voice:V3
      END:VCARD
      VCARD

    [ Str,          E_CONTACT_PHONE_BUSINESS,       Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_2,     Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_FAX,   Str  ],
    [ Str,          E_CONTACT_PHONE_CALLBACK,       Str  ],
    [ Str,          E_CONTACT_PHONE_CAR,            Str  ],
    [ Str,          E_CONTACT_PHONE_COMPANY,        Str  ],
    [ Str,          E_CONTACT_PHONE_HOME,           Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_2,         Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_FAX,       Str  ],
    [ Str,          E_CONTACT_PHONE_ISDN,           Str  ],
    [ Str,          E_CONTACT_PHONE_MOBILE,         Str  ],
    [ Str,          E_CONTACT_PHONE_OTHER,          'V2' ],
    [ Str,          E_CONTACT_PHONE_OTHER_FAX,      Str  ],
    [ Str,          E_CONTACT_PHONE_PAGER,          Str  ],
    [ Str,          E_CONTACT_PHONE_PRIMARY,        Str  ],
    [ Str,          E_CONTACT_PHONE_RADIO,          Str  ],
    [ Str,          E_CONTACT_PHONE_TELEX,          Str  ],
    [ Str,          E_CONTACT_PHONE_TTYTDD,         Str  ],

    [ q:to/VCARD/,  E_CONTACT_PHONE_ASSISTANT,      Str  ],
      BEGIN:VCARD
      TEL;Type=msg:V1
      TEL;TYPE=msg;type=Fax:V2
      TEL:V3
      END:VCARD
      VCARD

    [ Str,          E_CONTACT_PHONE_BUSINESS,       Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_2,     Str  ],
    [ Str,          E_CONTACT_PHONE_BUSINESS_FAX,   Str  ],
    [ Str,          E_CONTACT_PHONE_CALLBACK,       Str  ],
    [ Str,          E_CONTACT_PHONE_CAR,            Str  ],
    [ Str,          E_CONTACT_PHONE_COMPANY,        Str  ],
    [ Str,          E_CONTACT_PHONE_HOME,           Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_2,         Str  ],
    [ Str,          E_CONTACT_PHONE_HOME_FAX,       Str  ],
    [ Str,          E_CONTACT_PHONE_ISDN,           Str  ],
    [ Str,          E_CONTACT_PHONE_MOBILE,         Str  ],
    [ Str,          E_CONTACT_PHONE_OTHER,          'V3' ],
    [ Str,          E_CONTACT_PHONE_OTHER_FAX,      'V2' ],
    [ Str,          E_CONTACT_PHONE_PAGER,          Str  ],
    [ Str,          E_CONTACT_PHONE_PRIMARY,        Str  ],
    [ Str,          E_CONTACT_PHONE_RADIO,          Str  ],
    [ Str,          E_CONTACT_PHONE_TELEX,          Str  ],
    [ Str,          E_CONTACT_PHONE_TTYTDD,         Str  ],

    [ q:to/VCARD/,  E_CONTACT_PHONE_ASSISTANT,      Str  ],
      BEGIN:VCARD
      TEL;Type=msg:V1
      TEL:V2
      TEL;TYPE=msg;type=Fax:V3
      END:VCARD
      VCARD

    [ Str,          E_CONTACT_PHONE_BUSINESS,       Str  ],
  	[ Str,          E_CONTACT_PHONE_BUSINESS_2,     Str  ],
  	[ Str,          E_CONTACT_PHONE_BUSINESS_FAX,   Str  ],
  	[ Str,          E_CONTACT_PHONE_CALLBACK,       Str  ],
  	[ Str,          E_CONTACT_PHONE_CAR,            Str  ],
  	[ Str,          E_CONTACT_PHONE_COMPANY,        Str  ],
  	[ Str,          E_CONTACT_PHONE_HOME,           Str  ],
  	[ Str,          E_CONTACT_PHONE_HOME_2,         Str  ],
  	[ Str,          E_CONTACT_PHONE_HOME_FAX,       Str  ],
  	[ Str,          E_CONTACT_PHONE_ISDN,           Str  ],
  	[ Str,          E_CONTACT_PHONE_MOBILE,         Str  ],
  	[ Str,          E_CONTACT_PHONE_OTHER,          'V2' ],
  	[ Str,          E_CONTACT_PHONE_OTHER_FAX,      'V3' ],
  	[ Str,          E_CONTACT_PHONE_PAGER,          Str  ],
  	[ Str,          E_CONTACT_PHONE_PRIMARY,        Str  ],
  	[ Str,          E_CONTACT_PHONE_RADIO,          Str  ],
  	[ Str,          E_CONTACT_PHONE_TELEX,          Str  ],
  	[ Str,          E_CONTACT_PHONE_TTYTDD,         Str  ]
  ).map({ TestData.new( |$_ )  });

  test-type-param(@datas);
}

sub test-type-param-im ($im-attr, Int() $field-id) {
  my @vcards = ( qq:to/VCARD1/, qq:to/VCARD2/, qq:to/VCARD3/, qq:to/VCARD4/ );
  BEGIN:VCARD
  { $im-attr };Type=home:V1
  END:VCARD
  VCARD1
    BEGIN:VCARD
    { $im-attr };TYPE=WORK:V1
    END:VCARD
    VCARD2
      BEGIN:VCARD
      { $im-attr };TYPE=x-test,WORK:V1
      { $im-attr };type=X-Test;tYPE=Home:V2
      END:VCARD
      VCARD3
        BEGIN:VCARD
        { $im-attr };type=WORK:V1
        { $im-attr };TYPE=x-test,work:V2
        { $im-attr }:V3
        { $im-attr };TYPE=WORK,x-test:V4
        { $im-attr }:V5
        { $im-attr };type=X-Test;tYPE=Home:V6
        { $im-attr };tYPE=Home;type=X-Test:V7
        { $im-attr };type=Home:V8
        END:VCARD
        VCARD4

  my @datas = (
		[ @vcards[0], -1, 'V1' ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ @vcards[1], -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, 'V1' ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ @vcards[2], -1, 'V2' ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ Str,        -1, 'V1' ],
		[ Str,        -1, Str  ],
		[ Str,        -1, Str  ],
		[ @vcards[3], -1, 'V6' ],
		[ Str,        -1, 'V7' ],
		[ Str,        -1, 'V8' ],
		[ Str,        -1, 'V1' ],
		[ Str,        -1, 'V2' ],
		[ Str,        -1, 'V4' ]
  );
  my ($idx, $div) = (0, +@datas div +@vcards);
  @datas .= map({
    my $td = TestData.new( |$_ );
    $td.field-id = $field-id.Int + $idx++ % $div;
    $td
  });

  # for ( @datas.rotor(+@datas / +@vcards) Z @vcards).kv ->
  #   $dkey, ($test-data, $vcard)
  # {
  #   for $test-data.kv.rotor(2) -> ($key, $data) {
  #     $data.vcard-str = $vcard;
  #     $data.field-id = $field-id.Int + $dkey * 6 + $key;
  #   }
  # }

  #.gist for @datas;
  #diag "Last Field: { E_CONTACT_FIELD_LAST.Int }";

  plan 72;
  test-type-param(@datas);
}

sub test-type-param-xaim {
	test-type-param-im(EVC_X_AIM, E_CONTACT_IM_AIM_HOME_1);
}

sub test-type-param-xgadugadu {
	test-type-param-im(EVC_X_GADUGADU, E_CONTACT_IM_GADUGADU_HOME_1);
}

sub test-type-param-xgoogletalk {
	test-type-param-im(EVC_X_GOOGLE_TALK, E_CONTACT_IM_GOOGLE_TALK_HOME_1);
}

sub test-type-param-xgroupwise {
	test-type-param-im(EVC_X_GROUPWISE, E_CONTACT_IM_GROUPWISE_HOME_1);
}

sub test-type-param-xicq {
	test-type-param-im(EVC_X_ICQ, E_CONTACT_IM_ICQ_HOME_1);
}

sub test-type-param-xjabber {
	test-type-param-im(EVC_X_JABBER, E_CONTACT_IM_JABBER_HOME_1);
}

sub test-type-param-xmsn {
	test-type-param-im(EVC_X_MSN, E_CONTACT_IM_MSN_HOME_1);
}

sub test-type-param-xskype {
	test-type-param-im(EVC_X_SKYPE, E_CONTACT_IM_SKYPE_HOME_1);
}

sub test-type-param-xyahoo {
	test-type-param-im(EVC_X_YAHOO, E_CONTACT_IM_YAHOO_HOME_1);
}

plan 14;
subtest '/Contact/TypeParam/Email',       &test-type-param-email;
subtest '/Contact/TypeParam/Adr',         &test-type-param-adr;
subtest '/Contact/TypeParam/Label',       &test-type-param-label;
subtest '/Contact/TypeParam/Key',         &test-type-param-key;
subtest '/Contact/TypeParam/Tel',         &test-type-param-tel;
subtest '/Contact/TypeParam/XAim',        &test-type-param-xaim;
subtest '/Contact/TypeParam/XGadugadu',   &test-type-param-xgadugadu;
subtest '/Contact/TypeParam/XGoogletalk', &test-type-param-xgoogletalk;
subtest '/Contact/TypeParam/XGroupwise',  &test-type-param-xgroupwise;
subtest '/Contact/TypeParam/XIcq',        &test-type-param-xicq;
subtest '/Contact/TypeParam/XJabber',     &test-type-param-xjabber;
subtest '/Contact/TypeParam/XMsn',        &test-type-param-xmsn;
subtest '/Contact/TypeParam/XSkype',      &test-type-param-xskype;
subtest '/Contact/TypeParam/XYahoo',      &test-type-param-xyahoo;
