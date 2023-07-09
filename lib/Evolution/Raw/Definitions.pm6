use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Distro;

use GLib::Roles::Pointers;

unit package Evolution::Raw::Definitions;

constant forced = 0;

constant camel_block_t is export := guint32;
constant camel_hash_t  is export := guint32;
constant camel_key_t   is export := guint32;

constant CamelCipherCloneFunc      is export := Pointer;    # gpointer (* CamelCipherCloneFunc) (gpointer value)
constant CamelIndexNorm            is export := Pointer;    # gchar * (*CamelIndexNorm)(CamelIndex *index, const gchar *word, gpointer user_data);
constant EFreeFormExpBuildSexpFunc is export := Pointer;
constant EListCopyFunc             is export := Pointer;
constant EListFreeFunc             is export := Pointer;

constant ecal           is export = version-by-distro('ecal');
constant ebook          is export = version-by-distro('ebook');
constant ebook-contacts is export = version-by-distro('ebook-contacts');
constant edata-cal      is export = version-by-distro('edata-cal');
constant edata-book     is export = version-by-distro('edata-book');
constant eds            is export = version-by-distro('edataserver');
constant edsui          is export = version-by-distro('edataserverui');
constant ebackend       is export = version-by-distro('ebackend');

class CamelMsgPort                 is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendCache            is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendFile             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSqliteDB         is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSummary          is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSync             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookQuery                   is repr<CPointer> is export does GLib::Roles::Pointers { }
class EbSdbCursor                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookSqliteKeys              is repr<CPointer> is export does GLib::Roles::Pointers { }
class EbSqlCursor                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECacheColumnValues           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECacheKeys                   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarm           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalBackendWeather           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmInstance   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmRepeat     is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarms          is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmTrigger    is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAttendee        is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentDateTime        is repr<CPointer> is export does GLib::Roles::Pointers { }
#class ECalComponentId              is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentOrganizer       is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentParameterBag    is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPeriod          is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPrivate         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPropertyBag     is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentRange           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentText            is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECellRendererColor           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECertificateWidget           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECollator                    is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECredentialsPrompter         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECredentialsPrompterImpl     is repr<CPointer> is export does GLib::Roles::Pointers { }
class EExtensible                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class EGDataQuery                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class EGDataSession                is repr<CPointer> is export does GLib::Roles::Pointers { }
class ENamedParameters             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2Service               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2ServiceGoogle         is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2Support               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EPhoneNumber                 is repr<CPointer> is export does GLib::Roles::Pointers { }
class EReminderData                is repr<CPointer> is export does GLib::Roles::Pointers { }
class ERemindersWidget             is repr<CPointer> is export does GLib::Roles::Pointers { }
class ESourceWebDAVNotes           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ETimezoneCache               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttribute              is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttributeParam         is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWeatherSource               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWebDAVDiscoverContent       is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWebDAVDiscoverDialog        is repr<CPointer> is export does GLib::Roles::Pointers { }
class EXmlHash                     is repr<CPointer> is export does GLib::Roles::Pointers { }
class EXmlUtils                    is repr<CPointer> is export does GLib::Roles::Pointers { }

# Exceptions

class X::Evolution::VCard::AttributeVersionMismatch is Exception {
  has $.expected;
  has $.received;

  submethod BUILD (:$!expected, :$!received) { }

  method new ($expected, $received) {
    self.bless($expected, $received);
  }

  method message {
    "Encountered version {
     $!received } of an attribute when expecting version { $!expected }";
  }

}

# Global constants
constant CAMEL_FOLDER_TYPE_BIT                               is export = 10;

sub e-test-utils is export {
  state $libname = do {
    my ($arch, $os, $ext) = resources-info;
    my $libkey = "lib/{ $arch }/{ $os }/e-test-utils.{ $ext }";
    say "Using '$libkey' as tree support library." if $DEBUG;
    $libname = %?RESOURCES{$libkey}.absolute;
  }

  $libname;
}

# BEGIN {
#   constant e-test-utils is export = e-test-utils-location;
# }
