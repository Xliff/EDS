
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

class Cursor::Example {
  has $!top;
  has $!up-button;
  has $!down-button;
  has $!progressbar;
  has $!alphabet-label;
  has @!slots[N_SLOTS];
  has $!navigator;

  has $!client;
  has $!cursor;

  has %!timeout-id;
  has $!activity;

  # Note that this class overrides the dispose() method. Will need to
  # find a workaround.

  # Note: The UI definition uses the custom classes that we cannot since we
  #       are not subclassing anything. Go through the XML and replace all of
  #       of those instances with a GtkBin or GtkBox and apppend the ID name
  #       with '_box' before passing it to GTKBuilder. Those widgets can then
  #       be created added independently in a later phase.


  submethod BUILD ( :$vcard-path ) {

    $!up-button.button-press.tap(-> *@a {
      self.load-page if self.move-cursor(E_BOOK_CURSOR_ORIGIN_CURRENT, -1);
      self.ensure-timeout(TIMEOUT_UP_INITIAL);
      @a.tail.r = False;
    })

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

    $!navigator.index-changed.tap({
      unless $!nagivagor-change-pause {
        my $index = $!navigator.index;
        say 'Alphabet index changed to: ' ~ $index;

        if $!cursor.set-alphabetic-index-sync($index) {
          if GLib::Error.matches(
              $ERROR,
              E_CLIENT_ERROR,
              E_CLIENT_ERROR_OUT_OF_SYNC
          ) {
            warn 'Cursor was temporarily out of sync while setting the alphabetic target';
          } else {
            warn "Failed to bove the cursor: { $error.message }";
          }
          $error.clear;
        }

        return unless (my $full-results = self.load-page);
        unless $full-results {
          self.load-page
            if self.move-cursor(E_BOOK_CURSOR_ORIGIN_END, - (N_SLOTS + 1));
        }
      }
    });

    $!search.sexp-changed.tap(-> $sexp {
      unless $cursor.set-sexp-sync($sexp) {
        warn "Failed to move the cursor: { $ERROR.message }";
        clear_error;
      }

      if self.load-page -> $full_results {
        unless $full-results {
          self.load-page
            if self.move-cursor(E_BOOK_CURSOR_ORIGIN_END, -(N_SLOTS + 1));
        }
      }
    });

    $!client = cursor-load-data($vcard-path, $!cursor);
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

  }

  method new ($vcard-path) {
    self.bless( :$vcard-path );
  }

  method load-alphabet {
    $!navigator.alphabet = $!cursor.alphabet( :raw );
    $!navigator.index( :!action ) = 0;
  }

  method !checkCursorError {
    #  Pop into a sub. It will be used again in load-page
    if $ERROR.matches(E_CLIENT_ERROR, E_CLIENT_ERROR_OUT_OF_SYNC) {
      warn 'Cursor was temporarily out of sync while moving';
    } elsif $ERROR.matches(E_CLIENT_ERROR, E_CLIENT_ERROR_QUERY_REFUSED) {
      warn 'End of list was reached';
    } else {
      warn 'Failed to move the cursor: ' ~ $ERROR.message
    }
    clear-error;
  }

  method move-cursor ($origin, $count) {
    my $n = $!cursor.step-sync(E_BOOK_CURSOR_STEP_MOVE, $origin, $count)
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
      E_BOOK_CURSOR_ORIGIN_CRRENT,
      N_SLOTS
    );

    if $res-val ~~ List {
      for $res-val[1].kv -> $k, $v {
        $self.update-current-index($v) unless $k;
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
    $!progress-bar.text     = "Position { $position } / Total { $total }";
    $!progress-bar.fraction = $position / ($total - N_SLOTS);

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
    $!timeout = $activity == (TIMEOUT_UP_INITIAL, TIMEOUT_DOWN_INITIAL).any ??
      INITIAL_TIMEOUT !! TICK_TIMEOUT;
    $!activity = $new-activity;
    $!timeout-id = GLib::Timeout.add($tmineout, &timeout);
  }

  method cancel-timeout {
    GLib::source.remove($!timeout-id) if $!timeout-id;
    $!timeout-id = 0;
  }

}
