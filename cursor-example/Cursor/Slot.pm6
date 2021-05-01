use v6.c;

use Evolution::Raw::Types;

use GTK::Builder;

constant UI-FILE = 'cursor-slot.ui';

my $ui-def;

class Cursor::Slot {
  has $!top;
  has $!area;         # GtkGrid
  has $!name_label;   # GtkLabel
  has $!email_label;  # GtkLabel
  has $!phone_label;  # GtkLabel

  has $!contact;       # EContact

  submethod BUILD (:$contact) {
    my $ip = $*PROGRAM.add(UI-FILE);
    $ui-def = $ip.slurp if $ip.e;

    my $builder = GTK::Builder.new-from-string(
      GTK::Builder.templateToUI($ui-def)
    );

    $!top = $builder.top-level;
    for $builder.pairs.grep( .key ne $builder.top-level-id ) {
      when .key eq 'area'             { $!area         = .value }
      when .key eq 'name_label'       { $!name_label   = .value }
      when .key eq 'emails_label'     { $!email_label = .value }
      when .key eq 'telephone_label'  { $!phone_label = .value }

      default { die "Do not have a control called { $_ } in Cursor::Slot!" }
    }
    $!top.no-show-all = False;
    $!top.show-all;

    $!contact = $contact;
  }

  method new ($contact) {
    self.bless( :$contact );
  }

  method GTK::Raw::Definitions::GtkWidget
  { $!area.GtkWidet }

  method make-string-from-list ($contact, $field) {
    my $v = do if $contact.get($field) -> $dl {
      $dl.join(', ');
    } else {
      '- none -'
    }

    '<span size="x-small">' ~ $v ~ '</span>'
  }

  method ui-def-size {
    $ui-def.chars;
  }

  method set-from-contact ($contact) {
    unless $contact {
      $!area.hide;
      return;
    }

    $!name_label.text = "{ $contact.get-const(E_CONTACT_FAMILY_NAME) }, {
                           $contact.get-const(E_CONTACT_GIVEN_NAME) }";
    $!email_label.markup = self.make-string-from-list($contact, E_CONTACT_EMAIL);
    $!phone_label.markup = self.make-string-from-list($contact, E_CONTACT_TEL);

    $!area.show;
  }

}

BEGIN {
  $ui-def = q:to/UI-DEFINITION/;
    <?xml version="1.0" encoding="UTF-8"?>
    <interface>
      <!-- interface-requires gtk+ 3.10 -->
      <template class="CursorSlot" parent="GtkGrid">
        <property name="can_focus">False</property>
        <property name="no_show_all">True</property>
        <property name="hexpand">True</property>
        <child>
          <object class="GtkGrid" id="area">
            <property name="can_focus">False</property>
            <property name="hexpand">True</property>
            <property name="vexpand">False</property>
            <property name="row_spacing">2</property>
            <property name="column_spacing">2</property>
            <child>
              <object class="GtkLabel" id="name_label">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="halign">start</property>
                <property name="label" translatable="yes">Family Name, Name</property>
                <attributes>
                  <attribute name="weight" value="bold"/>
                </attributes>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">0</property>
                <property name="width">3</property>
                <property name="height">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLabel" id="label2">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="halign">end</property>
                <property name="margin_left">6</property>
                <property name="hexpand">False</property>
                <property name="label" translatable="yes">&lt;span size="x-small"&gt;Email:&lt;/span&gt;</property>
                <property name="use_markup">True</property>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">1</property>
                <property name="width">1</property>
                <property name="height">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLabel" id="label1">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="margin_left">6</property>
                <property name="hexpand">False</property>
                <property name="label" translatable="yes">&lt;span size="x-small"&gt;Telephone:&lt;/span&gt;</property>
                <property name="use_markup">True</property>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">2</property>
                <property name="width">1</property>
                <property name="height">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLabel" id="emails_label">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="hexpand">True</property>
                <property name="xalign">0</property>
                <property name="label" translatable="yes">&lt;span size="x-small"&gt;email@foo.bar&lt;/span&gt;</property>
                <property name="use_markup">True</property>
                <property name="ellipsize">end</property>
              </object>
              <packing>
                <property name="left_attach">1</property>
                <property name="top_attach">1</property>
                <property name="width">2</property>
                <property name="height">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLabel" id="telephones_label">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="hexpand">True</property>
                <property name="xalign">0</property>
                <property name="label" translatable="yes">&lt;span size="x-small"&gt;1-234-555-6789, 1-800-DONOUGHTS&lt;/span&gt;</property>
                <property name="use_markup">True</property>
                <property name="ellipsize">end</property>
              </object>
              <packing>
                <property name="left_attach">1</property>
                <property name="top_attach">2</property>
                <property name="width">2</property>
                <property name="height">1</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="left_attach">0</property>
            <property name="top_attach">0</property>
            <property name="width">1</property>
            <property name="height">1</property>
          </packing>
        </child>
      </template>
    </interface>
    UI-DEFINITION

}
