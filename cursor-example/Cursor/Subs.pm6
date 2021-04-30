use Evolution::Raw::Types;
use GIO::Raw::Quarks;

use GLib::MainLoop;
use Evolution::Book::Client;
use Evolution::Source::Registry;
use Evolution::Contact;
use Evolution::Source;

use GIO::Roles::GFile;

constant CURSOR_DATA_SOURCE_ID = 'cursor-example-book';

my $address-book;
my $address-book-source;

sub cursor-data-source-added ($registry, $source is copy, $mainloop?)
  is export
{
  $source = Evolution::Source.new($source);

  return unless $source.uid eq CURSOR_DATA_SOURCE_ID;

  if Evolution::Book::Client.connect-sync($source, 30) -> $a {
    $address-book = $a;
  } else {
    say 'Unable to create the test book: ' ~ $ERROR.message;
  }

  $address-book-source = $source.ref;
  $mainloop.quit if $mainloop;
}

sub cursor-data-source-timeout ($ud) is export {
  say 'Timed out while waiting for ESource creation rom the registry';
}

sub contact-from-file ($vcard-file) is export {
  do if GLib::File.file-get-contents($vcard-file) -> $vcard {
    Evolution::Contact.new-from-vcard($vcard);
  } else {
    say 'Failed to load VCard:' ~ $ERROR.message;
    Nil;
  }
}

sub load-contacts ($client, $vcard-directory) is export {
  my @contacts;
  @contacts.push: contact-from-file($_)
    for $vcard-directory.IO.dir( test => *.ends-with('.vcf') );

  if @contacts.elems {
    unless $client.add-contacts-sync(@contacts) {
      if $ERROR.matches(
        $E_BOOK_CLIENT_ERROR,
        E_BOOK_CLIENT_ERROR_CONTACT_ID_ALREADY_EXISTS
      ) {
        clear_error;
      } else {
        say 'Failed to add test contacts: ' ~ $ERROR.message;
      }
    }
  }
}

sub get-cursor ($client) is export {
  my $cursor;

  return $cursor if (
    $cursor = $client.get-cursor-sync([
      E_CONTACT_FAMILY_NAME => E_BOOK_CURSOR_SORT_ASCENDING,
      E_CONTACT_GIVEN_NAME  => E_BOOK_CURSOR_SORT_ASCENDING
    ])
  );

  say 'Unable to create cursor';
  clear_error;
}

sub cursor-load-data ($vcard-path) is export {
  my ($cursor, $mainloop, $registry);

  say "Cursor loading data from: { $vcard-path }";

  $mainloop = GLib::MainLoop.new;
  $registry = Evolution::Source::Registry.new-sync;

  die "Unable to create the registry: { $ERROR.message }" unless $registry;

  $registry.source-added.tap(-> *@a {
    cursor-data-source-added($registry, @a[1], $mainloop)
  });

  my $scratch = Evolution::Source.new-with-uid(CURSOR_DATA_SOURCE_ID);
  my $backend = $scratch.get-extension(E_SOURCE_EXTENSION_ADDRESS_BOOK);
  $backend.backend-name = 'local';

  unless $registry.commit-source-sync($scratch) {
    if $ERROR.matches($G_IO_ERROR, G_IO_ERROR_EXISTS) {
      my $source = $registry.ref-source(CURSOR_DATA_SOURCE_ID);

      clear_error;
      return Nil unless $source;
      cursor-data-source-added($registry, $source);
      $source.unref;
    } else {
      die "Unable to add new addressbook source to the registry: {
           $ERROR.message }";
    }
  }
  # cw: Reminder to remove these after implementor disposal refactoring
  $scratch.unref;

  unless $address-book {
    GLib::Timeout.add-seconds(20, &cursor-data-source-timeout);
    $mainloop.run;
  }
  die 'Address is still unloaded after timeout.' unless $address-book;

  load-contacts($address-book, $vcard-path);

  $cursor = get-cursor($address-book);

  .unref for $mainloop, $address-book-source, $registry;

  ($address-book, $cursor);
}
