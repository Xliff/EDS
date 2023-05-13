use v6.c;

use LibXML::Document;

unit package Evolution::Raw::Subs;

sub create-xml-document ($raw, :$ref = True) is export {
  my $o = LibXML::Document.new( :$raw );
  $o.ref if $ref;
  $o
}
