use v6.c;

use LibXML::Document;
use LibXML::Node;
use LibXML::XPath::Context;
use LibXML::XPath::Object;

use ICal::GLib::Timezone;

unit package Evolution::Raw::Subs;

sub create-xml-document ($raw) is export {
  create-xml-doc($raw);
}
sub create-xml-doc ($raw) is export {
  LibXML::Document.new( :$raw );
}

sub create-xml-xpath-context ($raw) is export {
  LibXML::XPath::Context.new( :$raw );
}

sub create-xml-node ($raw) is export {
  LibXML::Node.new( :$raw );
}

sub create-xml-xpath-object ($raw) is export {
  LibXML::XPath::Object.new( :$raw );
}

our $DEFAULT-TIMEZONE is export = ICal::GLib::Timezone.get_utc_timezone;
