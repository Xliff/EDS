use v6.c;

use Evolution::Raw::Types;

use Evolution::Raw::Data::Session;

role Evolution::Roles::Extends::JsonBuilder::Task {

  method add-completed (|c) { self.add_completed(|c) }
  method add-due       (|c) { self.add_due(|c)       }
  method add-id        (|c) { self.add_id(|c)        }
  method add-notes     (|c) { self.add_notes(|c)     }
  method add-status    (|c) { self.add_status(|c)    }
  method add-title     (|c) { self.add_title(|c)     }

  proto method add_completed (|)
  { * }

  multi method add_completed ($value is copy) {
    $value .= DateTime if $value.^can('DateTime');
    $value .= Int      if $value.^can('Int');
    samewith($value);
  }
  multi method add_completed (DateTime $value) {
    samewith($value.posix);
  }
  multi method add_completed (Int() $value) {
    my guint64 $v = $value;

    e_gdata_task_add_completed(self.JsonBuilder, $v);
  }

  proto method add_due (|)
  { * }

  multi method add_due ($value is copy) {
    $value .= DateTime if $value.^can('DateTime');
    $value .= Int      if $value.^can('Int');
    samewith($value);
  }
  multi method add_due (DateTime $value) {
    samewith($value.posix);
  }
  multi method add_due (Int $value) {
    my guint64 $v = $value;

    e_gdata_task_add_due(self.JsonBuilder, $v);
  }

  method add_id (Str() $value) {
    e_gdata_task_add_id(self.JsonBuilder, $value);
  }

  method add_notes (Str() $value) {
    e_gdata_task_add_notes(self.JsonBuilder, $value);
  }

  method add_status (Int() $value) {
    my EGDataTaskStatus $v = $value;

    e_gdata_task_add_status(self.JsonBuilder, $v);
  }

  method add_title (Str() $value) {
    e_gdata_task_add_title(self.JsonBuilder, $value);
  }

}

role Evolution::Roles::Extends::JsonBuilder::TaskList {

  method add-completed (|c) { self.add_completed(|c) }
  method add-due       (|c) { self.add_due(|c)       }
  method add-id        (|c) { self.add_id(|c)        }
  method add-notes     (|c) { self.add_notes(|c)     }
  method add-status    (|c) { self.add_status(|c)    }
  method add-title     (|c) { self.add_title(|c)     }

  method add_id (Str() $value) {
    e_gdata_tasklist_add_id(self.JsonBuilder, $value);
  }

  method add_title (Str() $value) {
    e_gdata_tasklist_add_title(self.JsonBuilder, $value);
  }

  proto method add_completed (|)
  { * }

  multi method add_completed ($value is copy) {
    $value .= DateTime if $value.^can('DateTime');
    $value .= Int      if $value.^can('Int');
    samewith($value);
  }
  multi method add_completed (DateTime $value) {
    samewith($value.posix);
  }
  multi method add_completed (Int() $value) {
    my gint64 $v = $value;

    e_gdata_task_add_completed(self.JsonBuilder, $v);
  }

  proto method add_due (|)
  { * }

  multi method add_due ($value is copy) {
    $value .= DateTime if $value.^can('DateTime');
    $value .= Int      if $value.^can('Int');
    samewith($value);
  }
  multi method add_due (DateTime $value) {
    samewith($value.posix);
  }
  multi method add_due (Int() $value) {
    my gint64 $v = $value;

    e_gdata_task_add_due(self.JsonBuilder, $v);
  }

  method add_notes (Str() $value) {
    e_gdata_task_add_notes(self.JsonBuilder, $value);
  }

  method add_status (Int() $value) {
    my EGDataTaskStatus $v = $value;

    e_gdata_task_add_status(self.JsonBuilder, $v);
  }

}

role Evolution::Roles::Extends::JsonObject::Task {

   method get-completed (|c) { self.get_completed(|c) }
   method get-deleted   (|c) { self.get_deleted(|c)   }
   method get-due       (|c) { self.get_due(|c)       }
   method get-etag      (|c) { self.get_etag(|c)      }
   method get-hidden    (|c) { self.get_hidden(|c)    }
   method get-id        (|c) { self.get_id(|c)        }
   method get-notes     (|c) { self.get_notes(|c)     }
   method get-parent    (|c) { self.get_parent(|c)    }
   method get-position  (|c) { self.get_position(|c)  }
   method get-self_link (|c) { self.get_self_link(|c) }
   method get-status    (|c) { self.get_status(|c)    }
   method get-title     (|c) { self.get_title(|c)     }
   method get-updated   (|c) { self.get_updated(|c)   }

   method completed     (|c) { self.get_completed(|c) }
   method deleted       (|c) { self.get_deleted(|c)   }
   method due           (|c) { self.get_due(|c)       }
   method etag          (|c) { self.get_etag(|c)      }
   method hidden        (|c) { self.get_hidden(|c)    }
   method id            (|c) { self.get_id(|c)        }
   method notes         (|c) { self.get_notes(|c)     }
   method parent        (|c) { self.get_parent(|c)    }
   method position      (|c) { self.get_position(|c)  }
   method self_link     (|c) { self.get_self_link(|c) }
   method status        (|c) { self.get_status(|c)    }
   method title         (|c) { self.get_title(|c)     }
   method updated       (|c) { self.get_updated(|c)   }

   method get_completed ( :$raw = False ) {
     my $c = e_gdata_task_get_completed(self.JsonObject);
     return $c if $raw;
     DateTime.new($c);
   }

   method get_deleted ( :$raw = False ) {
     my $d = e_gdata_task_get_deleted(self.JsonObject);
     return $d if $raw;
     DateTime.new($d);
   }

   method get_due ( :$raw = False ) {
     my $d = e_gdata_task_get_due(self.JsonObject);
     return $d if $raw;
     DateTime.new($d);
   }

   method get_etag {
     e_gdata_task_get_etag(self.JsonObject);
   }

   method get_hidden {
     so e_gdata_task_get_hidden(self.JsonObject);
   }

   method get_id {
     e_gdata_task_get_id(self.JsonObject);
   }

   method get_notes {
     e_gdata_task_get_notes(self.JsonObject);
   }

   method get_parent {
     e_gdata_task_get_parent(self.JsonObject);
   }

   method get_position {
     e_gdata_task_get_position(self.JsonObject);
   }

   method get_self_link {
     so e_gdata_task_get_self_link(self.JsonObject);
   }

   method get_status ( :$enum = True ) {
     my $s = e_gdata_task_get_status(self.JsonObject);
     return $s unless $enum;
     EGDataTaskStatus($s);
   }

   method get_title {
     e_gdata_task_get_title(self.JsonObject);
   }

   method get_updated ( :$raw = False ) {
     my $u = e_gdata_task_get_updated(self.JsonObject);
     return $u if $raw;
     DateTime.new($u);
   }

 }

role Evolution::Roles::Extends::JsonObject::TaskList {

  method etag      { self.get_etag      }
  method id        { self.get_id        }
  method self-link { self.get_self_link }
  method self_link { self.get_self_link }
  method title     { self.get_title     }
  method updated   { self.get_updated   }

  method get_etag {
    e_gdata_tasklist_get_etag(self.JsonBuilder);
  }

  method get_id {
    e_gdata_tasklist_get_id(self.JsonBuilder);
  }

  method get_self_link {
    so e_gdata_tasklist_get_self_link(self.JsonBuilder);
  }

  method get_title {
    e_gdata_tasklist_get_title(self.JsonBuilder);
  }

  method get_updated ( :$raw = False ) {
    my $u = e_gdata_tasklist_get_updated(self.JsonBuilder);
    return $u if $raw;
    DateTime.new($u);
  }

}
