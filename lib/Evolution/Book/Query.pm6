use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Query;

multi sub trait_mod:<is> (Parameter $param, :$also is required) {
  use nqp;
  my $named := nqp::getattr(nqp::decont($param), Parameter, '$!named_names');
  #nqp::push_s($named, $_) for $also.Array;
  $named := nqp::splice($named, nqp::decont($also.Array), nqp::elems($named), 0);
  nqp::bindattr( nqp::decont($param), Parameter, '$!named_names', $named );
}

# BOXED
class Evolution::Book::Query {
  has EBookQuery $!ebq;

  submethod BUILD (:$query) {
    $!ebq = $query if $query;
  }

  method Evolution::Raw::Definitions::EBookQuery
    is also<EBookQuery>
  { $!ebq }

  multi method new (EBookQuery $query) {
    $query ?? self.bless( :$query ) !! Nil;
  }

  multi method new (
    Str() $nq,
    # Aliases
    :from_string(
      :from-string(
        :from_str(
          :from-str(
            :string(:$str)
          )
        )
      )
    ) is required
  ) {
    Evolution::Book::Query.from_string($nq);
  }
  method from_string (Evolution::Book::Query:U: Str() $nq, :$raw = False)
    is also<from-string>
  {
    my $q = e_book_query_from_string($nq);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  multi method new (
    Int() $field,
    :vcard_field_exists(
      :vcard-field-exists(
        :vcard_field(:$vcard-field)
      )
    ) is required
  ) {
    Evolution::Book::Query.vcard_field_exists($field);
  }
  method vcard_field_exists (
    Evolution::Book::Query:U:

    Str() $field,
          :$raw = False
  )
    is also<vcard-field-exists>
  {
    my $q = e_book_query_vcard_field_exists($field);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  multi method new (
    Int() $field,
    Int() $test,
    Str() $value,
          :vcard_field_test(:$vcard-field-test) is required
  ) {
    Evolution::Book::Query.vcard_field_test($field, $test, $value)
  }
  method vcard_field_test (
    Evolution::Book::Query:U:

    Int() $field,
    Int() $test,
    Str() $value,
          :$raw   = False
  )
    is also<vcard-field-test>
  {
    my EContactField  $f = $field;
    my EBookQueryTest $t = $test;
    my                $q = e_book_query_vcard_field_test($!ebq, $test, $value);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  multi method new (
    Str() $value,
          :any_field_contains(
            :any-field-contains(
              :field_contains(
                :field-contains(
                  :contains(:$any)
                )
              )
            )
          ) is required
  ) {
    Evolution::Book::Query.any_field_contains($value);
  }
  method any_field_contains (
    Evolution::Book::Query:U:

    Str() $value,
          :$raw   = False
  )
    is also<any-field-contains>
  {
    e_book_query_any_field_contains($value);
  }

  # new() alias?
  method field_exists (Evolution::Book::Query:U: Int() $field, :$raw = False)
    is also<field-exists>
  {
    my EContactField $f = $field;

    my $q = e_book_query_field_exists($f);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  # new() alias?
  method field_test (
    Evolution::Book::Query:U:

    Int() $field,
    Int() $test,
    Str() $value,
          :$raw  = False
  )
    is also<field-test>
  {
    my EContactField  $f = $field;
    my EBookQueryTest $t = $test;

    my $q = e_book_query_field_test($f, $t, $value);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  multi method and (
    Evolution::Book::Query:D:

          *@qs,
    Int() :$unref = False,
          :$raw   = False
  ) {
    Evolution::Book::Query.and($!ebq, |@qs, :$unref, :$raw);
  }
  multi method and (
    Evolution::Book::Query:U:

          *@qs,
    Int() :$unref = False,
          :$raw   = False
  ) {
    samewith( @qs.elems, ArrayToCArray(EBookQuery, @qs), $unref, :$raw );
  }
  multi method and (
    Evolution::Book::Query:U:

    Int()              $nq,
    CArray[EBookQuery] $qs,
    Int()              $unref = False,
                       :$raw  = False
  ) {
    my gint     $n = $nq;
    my gboolean $u = $unref.so.Int;
    my          $q = e_book_query_and($n, $qs, $unref);

    $q ??
      ( $raw ?? $q !! Evolution::Book::Query.new($q) )
      !!
      Nil;
  }

  # cw: Since the regular and() accepts an array, there really is no need for
  #     andv() or orv()
  #
  # method andv (*@queries) {
  #   e_book_query_andv($!ebq);
  # }

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

  method get_type is also<get-type> {
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
    samewith( @qs.elems, ArrayToCArray(EBookQuery, @qs), $unref, :$raw );
  }
  multi method or (
    Evolution::Book::Query:U:

    Int()              $nq,
    CArray[EBookQuery] $qs,
    Int()              $unref = False,
                       :$raw  = False
  ) {
    my gint     $n = $nq;
    my gboolean $u = $unref.so.Int;
    my          $q = e_book_query_or($n, $qs, $unref);

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
  multi method ref (Evolution::Book::Query:U: EBookQuery() $q, :$raw = False) {
    my $qq = e_book_query_ref($q);

    $qq ??
      ( $raw ?? $qq !! Evolution::Book::Query.new($qq) )
      !!
      Nil;
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    e_book_query_to_string($!ebq);
  }

  multi method unref (Evolution::Book::Query:D: ) {
    Evolution::Book::Query.unref($!ebq);
  }
  multi method unref (Evolution::Book::Query:D: EBookQuery() $qq) {
    e_book_query_unref($qq);
  }

}
