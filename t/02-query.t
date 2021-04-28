use v6.c;

use Test;

use GLib::Compat::Definitions;
use Evolution::Raw::Types;

use Evolution::Book::Query;

plan 44;

sub normalize ($s) {
  $s.subst(/\h+/, ' ', :g);
}

sub test-query ($data) {
  diag $data<path>;
  ok setlocale(LC_ADDRESS, $data<locale>),    'Can set locale to the proper value';
  is (~$data<query>).&normalize, $data<sexp>, 'Normalized stringified query matches expected value';

  my $q = Evolution::Book::Query.new($data<sexp>, :string);
  ok $q,                                      'Query created from string without issue';
  my $sexp = (~$q).&normalize;
  $q.unref;
  is $sexp,                     $data<sexp>,  'Normalized stringified query matches expected value after destruction of origin'
}

sub add-query-test ($path, $query, $sexp) {
  test-query({ :$path, :$query, :$sexp });
}

sub MAIN {
  add-query-test(
    '/libebook/test-query/sexp/all',
    Evolution::Book::Query.new(:any),
  	'(contains "x-evolution-any-field" "")'
  );

  add-query-test(
		'/libebook/test-query/sexp/any',
		Evolution::Book::Query.new('liberty', :any),
		'(contains "x-evolution-any-field" "liberty")'
  );

	add-query-test(
		'/libebook/test-query/sexp/not',
		Evolution::Book::Query.new('liberty', :any).not(True),
		'(not (contains "x-evolution-any-field" "liberty"))'
  );

  add-query-test(
		'/libebook/test-query/sexp/or',
		Evolution::Book::Query.or(
			Evolution::Book::Query.new('liberty',    :any),
			Evolution::Book::Query.new('friendship', :any)
		),
		'(or (contains "x-evolution-any-field" "liberty")' ~
		' (contains "x-evolution-any-field" "friendship")' ~
		' )'
  );

  add-query-test(
		'/libebook/test-query/sexp/exists',
		Evolution::Book::Query.new(E_CONTACT_FULL_NAME, :field),
	  '(exists "full_name")'
  );

	add-query-test(
		"/libebook/test-query/sexp/contains",
		Evolution::Book::Query.new(
			E_CONTACT_FULL_NAME,
			E_BOOK_QUERY_CONTAINS,
			'Miguel',
      :field-test
    ),
		'(contains "full_name" "Miguel")'
  );

	add-query-test(
		'/libebook/test-query/sexp/is',
    Evolution::Book::Query.new(
      E_CONTACT_GIVEN_NAME,
      E_BOOK_QUERY_IS,
			'Miguel',
      :field-test
    ),
		'(is "given_name" "Miguel")'
  );

	add-query-test(
		'/libebook/test-query/sexp/beginswith',
    Evolution::Book::Query.new(
      E_CONTACT_FULL_NAME,
      E_BOOK_QUERY_BEGINS_WITH,
			'Mig',
      :field-test
    ),
		'(beginswith "full_name" "Mig")'
  );

  add-query-test(
    '/libebook/test-query/sexp/endswith',
    Evolution::Book::Query.new(
      E_CONTACT_TEL,
      E_BOOK_QUERY_ENDS_WITH,
      '5423789',
      :field-test
    ),
    '(endswith "phone" "5423789")'
  );

  if setlocale(LC_MESSAGES, 'en_US.UTF-8')  {
    add-query-test(
			'/libebook/test-query/sexp/eqphone/us',
			Evolution::Book::Query.or(
        # Test other multis.
				Evolution::Book::Query.new(
          :field_test,
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_PHONE_NUMBER,
					'+1-2215423789',
        ),
				Evolution::Book::Query.field_test(
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_NATIONAL_PHONE_NUMBER,
					'2215423789',
        ),
				Evolution::Book::Query.field-test(
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_SHORT_PHONE_NUMBER,
					'5423789'
        ),
		  ),
			'(or (eqphone "phone" "+1-2215423789" "en_US.UTF-8")'    ~
			' (eqphone_national "phone" "2215423789" "en_US.UTF-8")' ~
			' (eqphone_short "phone" "5423789" "en_US.UTF-8")'       ~
			' )'
    );
  } else {
    diag 'Failed to set local to en_US.UTF-8';
    diag 'Skipping /libebook/test-query/sexp/eqphone/us',
  }

  if setlocale(LC_MESSAGES, 'en_GB.UTF-8')  {
    add-query-test(
			'/libebook/test-query/sexp/eqphone/gb',
      # Test multis
			Evolution::Book::Query.or(
				Evolution::Book::Query.new(
          :field-test,
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_PHONE_NUMBER,
					'+1-2215423789'
        ),
	      Evolution::Book::Query.field_test(
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_NATIONAL_PHONE_NUMBER,
					'2215423789'
        ),
				Evolution::Book::Query.field-test(
					E_CONTACT_TEL,
					E_BOOK_QUERY_EQUALS_SHORT_PHONE_NUMBER,
					'5423789'),
				),
			'(or (eqphone "phone" "+1-2215423789" "en_GB.UTF-8")'    ~
			' (eqphone_national "phone" "2215423789" "en_GB.UTF-8")' ~
			' (eqphone_short "phone" "5423789" "en_GB.UTF-8")'       ~
			' )'
    );
  } else {
    diag 'Failed to set local to en_US.UTF-8';
    diag 'Skipping /libebook/test-query/sexp/eqphone/gb',
  }
}
