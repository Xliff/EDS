use v6.c;

unit package Cursor::Main;

use GTK::Application;
use GTK::Builder;

use Cursor::Example;
use Cursor::Builder::Registry;

sub MAIN ( $directory = './data' ) is export {
  GTK::Builder.register(Cursor::Builder::Registry);

  my $app = GTK::Application.new( title => 'org.genex.example.cursor' );

  $app.activate.tap({
    my $example = Cursor::Example.new($directory);
    $example.show-all;

    $app.window.destroy-signal.tap({ $app.quit });
    $app.window.add($example);
  });

  $app.run;
}
