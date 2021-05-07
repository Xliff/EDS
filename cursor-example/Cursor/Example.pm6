use Evolution::Raw::Types;
use Evolution::Raw::Client; # for $E_CLIENT_ERROR

use GTK::Builder;
use GLib::Source;
use GLib::Timeout;

use Cursor::Subs;
use Cursor::Builder::Registry;

use Cursor::Navigator;
use Cursor::Search;
use Cursor::Slot;

enum TimeoutActivity (
  'TIMEOUT_NONE'          => 0,
  'TIMEOUT_UP_INITIAL'  ,
  'TIMEOUT_UP_TICK'     ,
  'TIMEOUT_DOWN_INITIAL',
  'TIMEOUT_DOWN_TICK'
);

constant N_SLOTS         = 10;
constant INITIAL_TIMEOUT = 600;
constant TICK_TIMEOUT    = 100;

my $ui-def;

constant EXAMPLE-UI-FILE = 'cursor-search.ui';

my %attr-attribute-alias;

# This might be a lot more graceful if the attributes that DO NOT have
# their associated control named after themselves, have a mechanism
# to determine their alias.
#
#
role WidgetRole { }
#
role BuilderWidgets {
  method widget-attributes {
    self.^attributes.grep( * ~~ WidgetRole )
  }

  method builder-names {
    state %anti-attr-attribute-name;

    INIT {
      my %aliases = %attr-attribute-alias.antipairs.Hash;
      %anti-attr-attribute-name{ $_ } = %aliases{$_} // $_
        for %attr-attribute-alias.keys;
    }

    %anti-attr-attribute-name.Map
  }
}
#
multi sub trait_mod:<is> (Attribute $a, :$widget is required) {
  $a but WidgetRole;
}
#
multi sub trait_mod:<is> (Attribute $a, :$builder-name is required) {
  %attr-attribute-alias{ $a.name.substr(2) } =
    $builder-name ~~ Positional ?? $builder-name[0] !! $builder-name
}
# And then:
multi sub getAttributeUIName ($n) {
  %attr-attribute-alias{$n}.defined ?? %attr-attribute-alias{$n} !! $n
}

class Cursor::Example does BuilderWidgets {

  has GTK::Window $!top             handles<*> is widget;
  has             $!up-button                  is widget is builder-name<browse_up_button>;
  has             $!down-button                is widget is builder-name<browse_down_button>;
  has             $!progressbar                is widget;
  has             $!alphabet-label             is widget;
  has             $!search                     is widget;
  has             @!slots[N_SLOTS];
  has             $!navigator                  is widget;

  has             $!client;
  has             $!cursor;

  has             $!timeout-id;
  has             $!activity;
  has             %!ui-attributes;

  # cw: I think this is now solved in Cursor::Navigator...
  #has $!block-index-changed-event;

  # Note that this class overrides the dispose() method. Will need to
  # find a workaround.

  # my @ui-controls = <
  #   browse_up_button
  #   browse_down_button
  #   progressbar
  #   alphabet_label
  #   navigator
  # >;

  submethod BUILD ( :$vcard-path ) {
    # %!ui-attributes<browse_up_button>   := $!up-button     ;
    # %!ui-attributes<browse_down_button> := $!down-button   ;
    # %!ui-attributes<progressbar>        := $!progressbar   ;
    # %!ui-attributes<alphabet_label>     := $!alphabet_label;
    # %!ui-attributes<navigator>          := $!navigator     ;

    my $ip = $*PROGRAM.add(EXAMPLE-UI-FILE);
    $ui-def = $ip.slurp if $ip.e;

    my %controls;
    my $builder = GTK::Builder.new-from-string(
      GTK::Builder.templateToUI(
        $ui-def,
        dom-callback => sub ($dom) {
          CONTROL {
            when     CX::Warn { .message.say; .backtrace.concise.say; .resume }
            default           { .rethrow }
          }

          # Remove CursorSlot, CursorExample, CursorSearch and CursorNavigator
          # from the defintions in lieu of boxes/containers/bins (whatever is
          # the lightest) that will serve as proxy containers for these objects
          # when they are created. They will then be .add'ed to the proper
          # UI container
          # CONTROL {
          #   when CX::Warn { .say; .resume }
          #   default       { .rethrow }
          # }

          for $dom.find('//*[starts-with(@class,"Cursor")]') {
            my ($oldClass, $oldId) =
              ( .getAttribute('class'), .getAttribute('id') );

            say "OLDCLASS: { $oldClass // '--undef--' }";
            say "OLDID:    { $oldId    // '--undef--' }";

            $dom.setAttribute('class', 'GtkBin');
            $dom.setAttribute('id', $oldId ~ '_box');

            # cw: $oldClass needs to go through the Builder Registry for the
            #     proper class name!
            my $controlClass = Cursor::Builder::Registry.typeClass{$oldClass};
            die "Cannot find a valid class for '$oldClass'!"
              unless $controlClass;

            my $control = ::($controlClass).new;
            $control.show;
            $control.name = $oldClass;
            %controls{$oldId} = $control;
          }
        }
      )
    );

    $!top = $builder.top-level;
    %!ui-attributes{ getAttributeUIName( .key ) } := .value
      for $builder.pairs;

    # Add custom controls to their containers.
    %!ui-attributes{ .key ~ '_box'}.add( .value ) for %controls.pairs;

    # for $builder.pairs {
    #   when .key eq 'browse_up_button'    { $!up-button      = .value }
    #   when .key eq 'browse_down_button'  { $!down-button    = .value }
    #   when .key eq 'progressbar'         { $!progressbar    = .value }
    #   when .key eq 'alphabet_label'      { $!alphabet_label = .value }
    #   when .key eq 'navigator'           { $!navigator      = .value }
    # }

    $!up-button.button-press.tap(-> *@a {
      self.load-page if self.move-cursor(E_BOOK_CURSOR_ORIGIN_CURRENT, -1);
      self.ensure-timeout(TIMEOUT_UP_INITIAL);
      @a.tail.r = False;
    });

    $!up-button.button-release.tap(-> *@a {
      self.cancel-timeout;
      @a.tail.r = False;
    });

    $!down-button.button-press.tap(-> *@a {
      self.load-page if self.move-cursor(E_BOOK_CURSOR_ORIGIN_CURRENT, 1);
      self.ensure-timeout(TIMEOUT_UP_INITIAL);
      @a.tail.r = False;
    });

    $!down-button.button-release.tap(-> *@a {
      self.cancel-timeout;
      @a.tail.r = False;
    });

    $!navigator.index-changed.tap(sub {
      #return if $!block-index-changed-event;

      my $index = $!navigator.index;
      say 'Alphabet index changed to: ' ~ $index;

      if $!cursor.set-alphabetic-index-sync($index) {
        if GLib::Error.matches(
            $ERROR,
            $E_CLIENT_ERROR,
            E_CLIENT_ERROR_OUT_OF_SYNC
        ) {
          warn 'Cursor was temporarily out of sync while setting the alphabetic target';
        } else {
          warn "Failed to bove the cursor: { $ERROR.message }";
        }
        $ERROR.clear;
      }

      return unless (my $full-results = self.load-page);
      unless $full-results {
        self.load-page
          if self.move-cursor(E_BOOK_CURSOR_ORIGIN_END, - (N_SLOTS + 1));
      }
    });

    $!search.sexp-changed.tap(-> $sexp {
      unless $!cursor.set-sexp-sync($sexp) {
        warn "Failed to move the cursor: { $ERROR.message }";
        clear_error;
      }

      if self.load-page -> $full-results {
        unless $full-results {
          self.load-page
            if self.move-cursor(E_BOOK_CURSOR_ORIGIN_END, -(N_SLOTS + 1));
        }
      }
    });

    ($!client, $!cursor) = cursor-load-data($vcard-path);
    self.load-alphabet;
    self.load-page;
    self.update-status;

    $!cursor.refresh.tap(-> *@a {
      say 'Cursor refreshed';
      self.update-status if self.load-page;
    });

    $!cursor.notify('alphabet').tap(-> *@a {
      self.load-alphabet;
      self.load-page if self.move-cursor(E_BOOK_CURSOR_ORIGIN_BEGIN, 0);
    });

    $!cursor.notify($_).tap(-> *@a {
      self.update-status
    }) for <total position>;

    $!top.no-show-all = False;
    $!top.show-all;
  }

  method GTK::Raw::Definitions::Widget
  { $!top }

  method new ($vcard-path) {
    self.bless( :$vcard-path );
  }

  method load-alphabet {
    $!navigator.alphabet = $!cursor.alphabet( :raw );
    $!navigator.index( :!action ) = 0;
  }

  method !checkCursorError {
    #  Pop into a sub. It will be used again in load-page
    if $ERROR.matches($E_CLIENT_ERROR, E_CLIENT_ERROR_OUT_OF_SYNC) {
      warn 'Cursor was temporarily out of sync while moving';
    } elsif $ERROR.matches($E_CLIENT_ERROR, E_CLIENT_ERROR_QUERY_REFUSED) {
      warn 'End of list was reached';
    } else {
      warn 'Failed to move the cursor: ' ~ $ERROR.message
    }
    clear_error;
  }

  method move-cursor ($origin, $count) {
    my $n = $!cursor.step-sync(E_BOOK_CURSOR_STEP_MOVE, $origin, $count);
    if $n.defined.not {
      self!checkCursorError;
      return False;
    }
    True
  }

  multi method load-page {
    samewith($);
  }
  multi method load-page ($full-results is rw) {
    my $res-val = $!cursor.step-sync(
      E_BOOK_CURSOR_STEP_FETCH,
      E_BOOK_CURSOR_ORIGIN_CURRENT,
      N_SLOTS
    );

    if $res-val ~~ List {
      for $res-val[1].kv -> $k, $v {
        self.update-current-index($v) unless $k;
        @!slots[$k].set-from-contact($v);
      }
    } else {
      self!checkCursorError;
    }
    $full-results = $res-val[0] == N_SLOTS;

    return False unless $res-val;
    return $res-val[0] == 0;
  }

  method update-status {
    my ($total, $position)  = (.total, .position) given $!cursor;
    $!progressbar.text     = "Position { $position } / Total { $total }";
    $!progressbar.fraction = $position / ($total - N_SLOTS);

    ($!up-button.sensitive, $!down-button.sensitive) = $total <= N_SLOTS ??
      False xx 2
      !!
      ($position > 0, $position < $total - N_SLOTS);
  }

  method update-current-index ($contact = EContact) {
    my $index = $!cursor.get-contact-alphabetic-index($contact);
    my $labels = $!cursor.alphabet;

    $!alphabet-label.text = $labels[$index];
    $!navigator.index( :!action ) = $index if $contact;
  }

  method ensure_timeout ($new-activity) {
    my ($activity, $cursor, $self) := ($!activity, $!cursor, self);

    sub timeout {
      given $activity {
        when TIMEOUT_NONE { }

        when TIMEOUT_UP_INITIAL | TIMEOUT_UP_TICK {
          if $self.move-cursor(E_BOOK_CURSOR_ORIGIN_CURRENT, -1) {
            $self.load-page;
            $self.ensure-timeout(TIMEOUT_UP_TICK);
          } else {
            $self.cancel-timeout
          }
        }

        when TIMEOUT_DOWN_INITIAL | TIMEOUT_DOWN_TICK {
          my $can-move = .position - .total - N_SLOTS given $cursor;

          if $can-move && $cursor.move-cursor(E_BOOK_CURSOR_ORIGIN_CURRENT, 1) {
            $self.load-page;
            $self.ensure-timeout(TIMEOUT_DOWN_TICK);
          } else {
            $self.cancel-timeout;
          }
        }
      }
      False
    }

    self.cancel-timeout;
    my $timeout = $activity == (TIMEOUT_UP_INITIAL, TIMEOUT_DOWN_INITIAL).any ??
      INITIAL_TIMEOUT !! TICK_TIMEOUT;
    $!activity = $new-activity;
    $!timeout-id = GLib::Timeout.add($timeout, &timeout);
  }

  method cancel-timeout {
    GLib::Source.remove($!timeout-id) if $!timeout-id;
    $!timeout-id = 0;
  }

}


BEGIN {
  $ui-def = q:to/UI-DEF/;
  <?xml version="1.0" encoding="UTF-8"?>
  <!-- Generated with glade 3.15.2 on Fri Oct 18 22:00:50 2013 -->
  <interface>
    <!-- interface-requires gtk+ 3.10 -->
    <!-- interface-requires cursor 0.0 -->
    <template class="CursorExample" parent="GtkWindow">
      <property name="can_focus">False</property>
      <property name="title" translatable="yes">Cursor Example Program</property>
      <property name="default_width">600</property>
      <property name="default_height">300</property>
      <child>
        <object class="GtkBox" id="box1">
          <property name="visible">True</property>
          <property name="can_focus">False</property>
          <property name="border_width">8</property>
          <property name="orientation">vertical</property>
          <property name="spacing">6</property>
          <child>
            <object class="GtkBox" id="box3">
              <property name="visible">True</property>
              <property name="can_focus">False</property>
              <property name="orientation">vertical</property>
              <property name="spacing">2</property>
              <child>
                <object class="GtkGrid" id="grid1">
                  <property name="visible">True</property>
                  <property name="can_focus">False</property>
                  <property name="hexpand">False</property>
                  <child>
                    <object class="GtkBox" id="box4">
                      <property name="visible">True</property>
                      <property name="can_focus">False</property>
                      <property name="margin_right">6</property>
                      <property name="hexpand">True</property>
                      <property name="orientation">vertical</property>
                      <property name="spacing">6</property>
                      <child>
                        <object class="CursorSlot" id="contact_slot_1">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">0</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_2">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">1</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_3">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">2</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_4">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">3</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_5">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">4</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_6">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">5</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_7">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">6</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_8">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">7</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_9">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">8</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSlot" id="contact_slot_10">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="hexpand">True</property>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                          <child>
                            <placeholder/>
                          </child>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">9</property>
                        </packing>
                      </child>
                    </object>
                    <packing>
                      <property name="left_attach">0</property>
                      <property name="top_attach">1</property>
                      <property name="width">3</property>
                      <property name="height">1</property>
                    </packing>
                  </child>
                  <child>
                    <object class="CursorNavigator" id="navigator">
                      <property name="visible">True</property>
                      <property name="can_focus">True</property>
                      <property name="hexpand">False</property>
                      <property name="vexpand">True</property>
                      <property name="orientation">vertical</property>
                      <property name="draw_value">False</property>
                      <property name="has_origin">False</property>
                      <signal name="index-changed" handler="cursor_example_navigator_changed" swapped="yes"/>
                    </object>
                    <packing>
                      <property name="left_attach">3</property>
                      <property name="top_attach">1</property>
                      <property name="width">1</property>
                      <property name="height">1</property>
                    </packing>
                  </child>
                  <child>
                    <object class="GtkButton" id="browse_up_button">
                      <property name="visible">True</property>
                      <property name="can_focus">True</property>
                      <property name="receives_default">True</property>
                      <property name="halign">center</property>
                      <property name="valign">end</property>
                      <property name="hexpand">False</property>
                      <property name="relief">none</property>
                      <signal name="button-press-event" handler="cursor_example_up_button_press" swapped="yes"/>
                      <signal name="button-release-event" handler="cursor_example_up_button_release" swapped="yes"/>
                      <child>
                        <object class="GtkArrow" id="arrow1">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="arrow_type">up</property>
                        </object>
                      </child>
                    </object>
                    <packing>
                      <property name="left_attach">3</property>
                      <property name="top_attach">0</property>
                      <property name="width">1</property>
                      <property name="height">1</property>
                    </packing>
                  </child>
                  <child>
                    <object class="GtkButton" id="browse_down_button">
                      <property name="visible">True</property>
                      <property name="can_focus">True</property>
                      <property name="receives_default">True</property>
                      <property name="halign">center</property>
                      <property name="valign">start</property>
                      <property name="hexpand">False</property>
                      <property name="relief">none</property>
                      <signal name="button-press-event" handler="cursor_example_down_button_press" swapped="yes"/>
                      <signal name="button-release-event" handler="cursor_example_down_button_release" swapped="yes"/>
                      <child>
                        <object class="GtkArrow" id="arrow2">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="arrow_type">down</property>
                        </object>
                      </child>
                    </object>
                    <packing>
                      <property name="left_attach">3</property>
                      <property name="top_attach">2</property>
                      <property name="width">1</property>
                      <property name="height">1</property>
                    </packing>
                  </child>
                  <child>
                    <object class="GtkBox" id="box2">
                      <property name="visible">True</property>
                      <property name="can_focus">False</property>
                      <child>
                        <object class="GtkLabel" id="alphabet_label">
                          <property name="visible">True</property>
                          <property name="can_focus">False</property>
                          <property name="halign">start</property>
                          <property name="hexpand">False</property>
                          <property name="xalign">0</property>
                          <property name="label" translatable="yes">A</property>
                          <property name="width_chars">3</property>
                          <attributes>
                            <attribute name="weight" value="bold"/>
                            <attribute name="scale" value="1.5"/>
                          </attributes>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">0</property>
                        </packing>
                      </child>
                      <child>
                        <object class="CursorSearch" id="search">
                          <property name="visible">True</property>
                          <property name="can_focus">True</property>
                          <property name="margin_left">6</property>
                          <property name="margin_right">6</property>
                          <property name="margin_top">6</property>
                          <property name="margin_bottom">6</property>
                          <property name="hexpand">True</property>
                          <signal name="notify::sexp" handler="cursor_example_sexp_changed" swapped="yes"/>
                        </object>
                        <packing>
                          <property name="expand">False</property>
                          <property name="fill">True</property>
                          <property name="position">1</property>
                        </packing>
                      </child>
                    </object>
                    <packing>
                      <property name="left_attach">0</property>
                      <property name="top_attach">0</property>
                      <property name="width">3</property>
                      <property name="height">1</property>
                    </packing>
                  </child>
                  <child>
                    <placeholder/>
                  </child>
                  <child>
                    <placeholder/>
                  </child>
                  <child>
                    <placeholder/>
                  </child>
                </object>
                <packing>
                  <property name="expand">False</property>
                  <property name="fill">True</property>
                  <property name="position">0</property>
                </packing>
              </child>
            </object>
            <packing>
              <property name="expand">False</property>
              <property name="fill">True</property>
              <property name="position">0</property>
            </packing>
          </child>
          <child>
            <object class="GtkFrame" id="frame1">
              <property name="visible">True</property>
              <property name="can_focus">False</property>
              <property name="label_xalign">0</property>
              <property name="shadow_type">in</property>
              <child>
                <object class="GtkProgressBar" id="progressbar">
                  <property name="visible">True</property>
                  <property name="can_focus">False</property>
                  <property name="show_text">True</property>
                </object>
              </child>
              <child type="label_item">
                <placeholder/>
              </child>
            </object>
            <packing>
              <property name="expand">False</property>
              <property name="fill">True</property>
              <property name="position">1</property>
            </packing>
          </child>
        </object>
      </child>
    </template>
  </interface>
  UI-DEF

}
