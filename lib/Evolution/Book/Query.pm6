# BOXED
class Evolution::Book::Query {
  has EBookQuery $!ebq;

  # NOWHERE NEAR COMPLETE!

  submethod BUILD (:$query) {
    $!ebq = $query if $query;
  }

  method Evolution::Raw::Definitions::EBookQuery
  { $!ebq }

  method new (EBookQuery $query) {
    $query ?? self.bless( :$query ) !! Nil;
  }

  method vcard_field_exists (
    Evolution::Book::Query:U:

    Int() $field,
          :$raw = False
  ) {

    my $q = e_book_query_vcard_field_exists($f);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  method vcard_field_test (
    Evolution::Book::Query:U:

    Int() $field,
    Int() $test,
    Str() $value
  ) {
    my EBookField     $f = $field;
    my EBookQueryTest $t = $test;
    my                $q = e_book_query_vcard_field_test($!ebq, $test, $value);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  # Finish out as per .or
  multi method and (@qs, Int() $unref = False) {
    samewith( @qs.elems, CArray[EBookQuery].new(@qs), $unref );
  }
  multi method and (Int() $nq ,CArray[EBookQuery] $qs, Int() $unref = False) {
    my gint     $n = $nq;
    my gboolean $u = $unref.so.Int;

    e_book_query_and($n, $qs, $unref);
  }

  # cw: Since the regular and() accepts an array, there really is no need for
  #     andv() or orv()
  #
  # method andv (*@queries) {
  #   e_book_query_andv($!ebq);
  # }

  method from_string (Evolution::Book::Query:U: Str() $nq, :$raw = False) {
    my $q = e_book_query_from_string($nq);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  method any_field_contains (
    Evolution::Book::Query:U:

    Str() $value,
          :$raw   = False
  ) {
    e_book_query_any_field_contains($value);
  }

  multi method copy (:$raw = False) {
    Evolution::Book::Query.copy($!ebq, :$raw);
  }
  multi method copy (
    Evolution::Book::Query:U:

    EBookQuery() $tc,
                 :$raw = False
  ) {
    my $c = e_book_query_copy($tc);

    $c ??
      ( $raw ?? $c !! Evolution::Book::Query.new($c) )
      !!
      Nil;
  }

  method field_exists (Evolution::Book::Query:U: Int() $field, :$raw = False) {
    my EBookField $f = $field;

    my $q = e_book_query_field_exists($f);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  method field_test (
    Evolution::Book::Query:U:

    Int() $field,
    Int() $test,
    Str() $value,
          :$raw  = False
  ) {
    my EBookField     $f = $field;
    my EBookQueryTest $t = $test;

    my $q = e_book_query_field_test($f, $t, $value);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_query_get_type, $n, $t );
  }

  multi method not (Evolution::Book::Query:D: Int() $unref, :$raw = False) {
    Evolution::Book::Query.not($!ebq, $unref, :$raw);
  }
  multi method not (
    Evolution::Book::Query:U:

    EBookQuery() $q,
    Int()        $unref,
                 :$raw = False
  ) {
    my gboolean $u = $unref.so.Int;
    my          $qq = e_book_query_not($q, $u);

    $qq ??
      ( $raw ?? $qq !! Evolution::Book::Query.new($qq) )
      !!
      Nil;
  }

  multi method or (
    Evolution::Book::Query:D:

          *@qs,
    Int() :$unref = False,
          :$raw   = False
  ) {
    Evolution::Book::Query.or($!ebq, |@qs, :$unref, :$raw);
  }
  multi method or (
    Evolution::Book::Query:U:

          *@qs,
    Int() :$unref = False,
          :$raw   = False
  ) {
    samewith( @qs.elems, ArrayToCArray(@qs, EBookQuery), $unref );
  }
  multi method or (
    Evolution::Book::Query:U:

    Int()              $nq,
    CArray[EBookQuery] $qs,
    Int()              $unref = False
  ) {
    my gint     $n = $nq;
    my gboolean $u = $unref.so.Int;
    my          $q = e_book_query_or($!ebq, $qs, $unref);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  # method orv {
  #   e_book_query_orv($!ebq);
  # }

  multi method ref (Evolution::Book::Query:D: :$raw = False) {
    Evolution::Book::Query.ref($!ebq, :$raw);
  }
  multi method ref (Evolution::Book::Query:U: EBookQuery() $q :$raw = False) {
    my $qq = e_book_query_ref($qq);

    $qq ??
      ( $raw ?? $qq !! Evolution::Book::Query.new($qq) )
      !!
      Nil;
  }

  method to_string {
    e_book_query_to_string($!ebq);
  }

  method unref (Evolution::Book::Query:D: ) {
    Evolution::Book::Query.unref($!ebq);
  }
  method unref (Evolution::Book::Query:D: EBookQuery() $qq) {
    e_book_query_unref($qq);
  }

}
