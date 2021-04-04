use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
#use Evolution::Raw::Definitions;

class CamelAddress is repr<CStruct> is export {
	has GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelBlockFile is repr<CStruct> is export {
	has GObject               $!parent;
	has Pointer $!priv  ;
}

class CamelBlockRoot is repr<CStruct> is export {
	has gchar         $!version   ;
	has guint32       $!flags     ;
	has guint32       $!block_size;
	has camel_block_t $!free      ;
	has camel_block_t $!last      ;
}

class CamelCertDB is repr<CStruct> is export {
	has GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelCharset is repr<CStruct> is export {
	has guint $!mask ;
	has gint  $!level;
}

class CamelCipherCertInfo is repr<CStruct> is export {
	has gchar                $!name           ;
	has gchar                $!email          ;
	has gpointer             $!cert_data      ;
	has GDestroyNotify       $!cert_data_free ;
	has CamelCipherCloneFunc $!cert_data_clone;
	has GSList               $!properties     ;
}

class CamelCipherCertInfoProperty is repr<CStruct> is export {
	has gchar                $!name       ;
	has gpointer             $!value      ;
	has GDestroyNotify       $!value_free ;
	has CamelCipherCloneFunc $!value_clone;
}

class CamelCipherContext is repr<CStruct> is export {
	has GObject                   $!parent;
	has Pointer $!priv  ;
}

class CamelContentDisposition is repr<CStruct> is export {
	has gchar               $!disposition;
	has _camel_header_param $!params     ;
	has guint               $!refcount   ;
}

class CamelDB is repr<CStruct> is export {
	has GObject        $!parent;
	has Pointer $!priv  ;
}

class CamelDataCache is repr<CStruct> is export {
	has GObject               $!parent;
	has Pointer $!priv  ;
}

class CamelDataWrapper is repr<CStruct> is export {
	has GObject                 $!parent;
	has Pointer $!priv  ;
}

class CamelFIRecord is repr<CStruct> is export {
	has gchar   $!folder_name  ;
	has guint32 $!version      ;
	has guint32 $!flags        ;
	has guint32 $!nextuid      ;
	has gint64  $!timestamp    ;
	has guint32 $!saved_count  ;
	has guint32 $!unread_count ;
	has guint32 $!deleted_count;
	has guint32 $!junk_count   ;
	has guint32 $!visible_count;
	has guint32 $!jnd_count    ;
	has gchar   $!bdata        ;
}

class CamelFilterDriver is repr<CStruct> is export {
	has GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelFilterInputStream is repr<CStruct> is export {
	has GFilterInputStream            $!parent;
	has Pointer $!priv  ;
}

class CamelFilterOutputStream is repr<CStruct> is export {
	has GFilterOutputStream            $!parent;
	has Pointer $!priv  ;
}

class CamelFolder is repr<CStruct> is export {
	has CamelObject        $!parent;
	has Pointer $!priv  ;
}

class CamelFolderChangeInfo is repr<CStruct> is export {
	has GPtrArray                    $!uid_added  ;
	has GPtrArray                    $!uid_removed;
	has GPtrArray                    $!uid_changed;
	has GPtrArray                    $!uid_recent ;
	has Pointer $!priv       ;
}

class CamelFolderInfo is repr<CStruct> is export {
	has _CamelFolderInfo     $!next        ;
	has _CamelFolderInfo     $!parent      ;
	has _CamelFolderInfo     $!child       ;
	has gchar                $!full_name   ;
	has gchar                $!display_name;
	has CamelFolderInfoFlags $!flags       ;
	has gint32               $!unread      ;
	has gint32               $!total       ;
}

class CamelFolderQuotaInfo is repr<CStruct> is export {
	has gchar                 $!name ;
	has guint64               $!used ;
	has guint64               $!total;
	has _CamelFolderQuotaInfo $!next ;
}

class CamelFolderSearch is repr<CStruct> is export {
	has GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelFolderSummary is repr<CStruct> is export {
	has GObject                   $!parent;
	has Pointer $!priv  ;
}

class CamelGpgContext is repr<CStruct> is export {
	has CamelCipherContext     $!parent;
	has Pointer $!priv  ;
}

class CamelHTMLParser is repr<CStruct> is export {
	has GObject                $!parent;
	has Pointer $!priv  ;
}

class CamelIndex is repr<CStruct> is export {
	has GObject           $!parent        ;
	has Pointer $!priv          ;
	has gchar             $!path          ;
	has guint32           $!version       ;
	has guint32           $!flags         ;
	has guint32           $!state         ;
	has CamelIndexNorm    $!normalize     ;
	has gpointer          $!normalize_data;
}

class CamelIndexCursor is repr<CStruct> is export {
	has GObject                 $!parent;
	has Pointer $!priv  ;
	has CamelIndex              $!index ;
}

class CamelIndexName is repr<CStruct> is export {
	has GObject               $!parent;
	has Pointer $!priv  ;
	has CamelIndex            $!index ;
	has gchar                 $!name  ;
	has GByteArray            $!buffer;
	has GHashTable            $!words ;
}

class CamelInternetAddress is repr<CStruct> is export {
	has CamelAddress                $!parent;
	has Pointer $!priv  ;
}

class CamelKeyFile is repr<CStruct> is export {
	has GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelKeyRootBlock is repr<CStruct> is export {
	has camel_block_t $!first;
	has camel_block_t $!last ;
	has camel_key_t   $!free ;
}

class CamelKeyTable is repr<CStruct> is export {
	has GObject              $!parent;
	has Pointer $!priv  ;
}

class CamelLocalSettings is repr<CStruct> is export {
	has CamelStoreSettings        $!parent;
	has Pointer $!priv  ;
}

class CamelLockHelperMsg is repr<CStruct> is export {
	has guint32 $!magic;
	has guint32 $!seq  ;
	has guint32 $!id   ;
	has guint32 $!data ;
}

class CamelMIRecord is repr<CStruct> is export {
	has gchar    $!uid                  ;
	has guint32  $!flags                ;
	has guint32  $!msg_type             ;
	has guint32  $!dirty                ;
	has gboolean $!read                 ;
	has gboolean $!deleted              ;
	has gboolean $!replied              ;
	has gboolean $!important            ;
	has gboolean $!junk                 ;
	has gboolean $!attachment           ;
	has guint32  $!size                 ;
	has gint64   $!dsent                ;
	has gint64   $!dreceived            ;
	has gchar    $!subject              ;
	has gchar    $!from                 ;
	has gchar    $!to                   ;
	has gchar    $!cc                   ;
	has gchar    $!mlist                ;
	has gchar    $!followup_flag        ;
	has gchar    $!followup_completed_on;
	has gchar    $!followup_due_by      ;
	has gchar    $!part                 ;
	has gchar    $!labels               ;
	has gchar    $!usertags             ;
	has gchar    $!cinfo                ;
	has gchar    $!bdata                ;
}

class CamelMedium is repr<CStruct> is export {
	has CamelDataWrapper   $!parent;
	has Pointer $!priv  ;
}

class CamelMessageContentInfo is repr<CStruct> is export {
	has CamelMessageContentInfo $!next       ;
	has CamelMessageContentInfo $!childs     ;
	has CamelMessageContentInfo $!parent     ;
	has CamelContentType        $!type       ;
	has CamelContentDisposition $!disposition;
	has gchar                   $!id         ;
	has gchar                   $!description;
	has gchar                   $!encoding   ;
	has guint32                 $!size       ;
}

class CamelMessageInfo is repr<CStruct> is export {
	has GObject                 $!parent;
	has Pointer $!priv  ;
}

class CamelMessageInfoBase is repr<CStruct> is export {
	has CamelMessageInfo            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilter is repr<CStruct> is export {
	has GObject                $!parent  ;
	has Pointer $!priv    ;
	has gchar                  $!outreal ;
	has gchar                  $!outbuf  ;
	has gchar                  $!outptr  ;
	has gsize                  $!outsize ;
	has gsize                  $!outpre  ;
	has gchar                  $!backbuf ;
	has gsize                  $!backsize;
	has gsize                  $!backlen ;
}

class CamelMimeFilterBasic is repr<CStruct> is export {
	has CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterBestenc is repr<CStruct> is export {
	has CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCRLF is repr<CStruct> is export {
	has CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCanon is repr<CStruct> is export {
	has CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCharset is repr<CStruct> is export {
	has CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterEnriched is repr<CStruct> is export {
	has CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterFrom is repr<CStruct> is export {
	has CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterGZip is repr<CStruct> is export {
	has CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterHTML is repr<CStruct> is export {
	has CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterIndex is repr<CStruct> is export {
	has CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterLinewrap is repr<CStruct> is export {
	has CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterPgp is repr<CStruct> is export {
	has CamelMimeFilter           $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterProgress is repr<CStruct> is export {
	has CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterToHTML is repr<CStruct> is export {
	has CamelMimeFilter              $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterWindows is repr<CStruct> is export {
	has CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterYenc is repr<CStruct> is export {
	has CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeMessage is repr<CStruct> is export {
	has CamelMimePart           $!parent;
	has Pointer $!priv  ;
}

class CamelMimeParser is repr<CStruct> is export {
	has GObject                $!parent;
	has Pointer $!priv  ;
}

class CamelMimePart is repr<CStruct> is export {
	has CamelMedium          $!parent;
	has Pointer $!priv  ;
}

class CamelMsg is repr<CStruct> is export {
	has CamelMsgPort $!reply_port;
	has gint         $!flags     ;
}

class CamelMultipart is repr<CStruct> is export {
	has CamelDataWrapper      $!parent;
	has Pointer $!priv  ;
}

class CamelMultipartEncrypted is repr<CStruct> is export {
	has CamelMultipart                 $!parent;
	has Pointer $!priv  ;
}

class CamelMultipartSigned is repr<CStruct> is export {
	has CamelMultipart              $!parent;
	has Pointer $!priv  ;
}

class CamelNNTPAddress is repr<CStruct> is export {
	has CamelAddress            $!parent;
	has Pointer $!priv  ;
}

class CamelNullOutputStream is repr<CStruct> is export {
	has GOutputStream                $!parent;
	has Pointer $!priv  ;
}

class CamelObject is repr<CStruct> is export {
	has GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineFolder is repr<CStruct> is export {
	has CamelFolder               $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineSettings is repr<CStruct> is export {
	has CamelStoreSettings          $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineStore is repr<CStruct> is export {
	has CamelStore               $!parent;
	has Pointer $!priv  ;
}

class CamelOperation is repr<CStruct> is export {
	has GCancellable          $!parent;
	has Pointer $!priv  ;
}

class CamelPartitionKey is repr<CStruct> is export {
	has camel_hash_t $!hashid;
	has camel_key_t  $!keyid ;
}

class CamelPartitionMap is repr<CStruct> is export {
	has camel_hash_t  $!hashid ;
	has camel_block_t $!blockid;
}

class CamelPartitionTable is repr<CStruct> is export {
	has GObject                    $!parent;
	has Pointer $!priv  ;
}

class CamelSExp is repr<CStruct> is export {
	has GObject          $!parent;
	has Pointer $!priv  ;
}

class CamelSMIMEContext is repr<CStruct> is export {
	has CamelCipherContext       $!parent;
	has Pointer $!priv  ;
}

class CamelSasl is repr<CStruct> is export {
	has GObject          $!parent;
	has Pointer $!priv  ;
}

class CamelSaslAnonymous is repr<CStruct> is export {
	has CamelSasl                 $!parent;
	has Pointer $!priv  ;
}

class CamelSaslGssapi is repr<CStruct> is export {
	has CamelSasl              $!parent;
	has Pointer $!priv  ;
}

class CamelSaslLogin is repr<CStruct> is export {
	has CamelSasl             $!parent;
	has Pointer $!priv  ;
}

class CamelSaslNTLM is repr<CStruct> is export {
	has CamelSasl            $!parent;
	has Pointer $!priv  ;
}

class CamelSaslPlain is repr<CStruct> is export {
	has CamelSasl             $!parent;
	has Pointer $!priv  ;
}

class CamelService is repr<CStruct> is export {
	has CamelObject         $!parent;
	has Pointer $!priv  ;
}

class CamelSession is repr<CStruct> is export {
	has GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelSettings is repr<CStruct> is export {
	has GObject              $!parent;
	has Pointer $!priv  ;
}

class CamelStore is repr<CStruct> is export {
	has CamelService      $!parent;
	has Pointer $!priv  ;
}

class CamelStoreSettings is repr<CStruct> is export {
	has CamelSettings             $!parent;
	has Pointer $!priv  ;
}

class CamelStoreSummary is repr<CStruct> is export {
	has GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelStream is repr<CStruct> is export {
	has GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelStreamBuffer is repr<CStruct> is export {
	has CamelStream              $!parent;
	has Pointer $!priv  ;
}

class CamelStreamFilter is repr<CStruct> is export {
	has CamelStream              $!parent;
	has Pointer $!priv  ;
}

class CamelStreamFs is repr<CStruct> is export {
	has CamelStream          $!parent;
	has Pointer $!priv  ;
}

class CamelStreamMem is repr<CStruct> is export {
	has CamelStream           $!parent;
	has Pointer $!priv  ;
}

class CamelStreamNull is repr<CStruct> is export {
	has CamelStream            $!parent;
	has Pointer $!priv  ;
}

class CamelStreamProcess is repr<CStruct> is export {
	has CamelStream               $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndex is repr<CStruct> is export {
	has CamelIndex            $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexCursor is repr<CStruct> is export {
	has CamelIndexCursor            $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexKeyCursor is repr<CStruct> is export {
	has CamelIndexCursor               $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexName is repr<CStruct> is export {
	has CamelIndexName            $!parent;
	has Pointer $!priv  ;
}

class CamelTransport is repr<CStruct> is export {
	has CamelService          $!parent;
	has Pointer $!priv  ;
}

class CamelURL is repr<CStruct> is export {
	has gchar $!protocol;
	has gchar $!user    ;
	has gchar $!authmech;
	has gchar $!host    ;
	has gint  $!port    ;
	has gchar $!path    ;
	has GData $!params  ;
	has gchar $!query   ;
	has gchar $!fragment;
}

class CamelVTrashFolder is repr<CStruct> is export {
	has CamelVeeFolder           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeDataCache is repr<CStruct> is export {
	has GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelVeeFolder is repr<CStruct> is export {
	has CamelFolder           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeMessageInfo is repr<CStruct> is export {
	has CamelMessageInfo           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeMessageInfoData is repr<CStruct> is export {
	has GObject                        $!parent;
	has Pointer $!priv  ;
}

class CamelVeeStore is repr<CStruct> is export {
	has CamelStore           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeSubfolderData is repr<CStruct> is export {
	has GObject                      $!parent;
	has Pointer $!priv  ;
}

class CamelVeeSummary is repr<CStruct> is export {
	has CamelFolderSummary     $!parent;
	has Pointer $!priv  ;
}

class ECalClient is repr<CStruct> is export {
	has EClient           $!parent;
	has Pointer $!priv  ;
}

class ECalClientView is repr<CStruct> is export {
	has GObject               $!object;
	has Pointer $!priv  ;
}

class ECalComponent is repr<CStruct> is export {
	has GObject              $!parent;
	has Pointer $!priv  ;
}

class ECalComponentClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class ECancellableLocksBase is repr<CStruct> is export {
	has GMutex $!cond_mutex;
	has GCond  $!cond      ;
}

class ECancellableMutex is repr<CStruct> is export {
	has _ECancellableLocksBase $!base ;
	has GMutex                 $!mutex;
}

class ECancellableRecMutex is repr<CStruct> is export {
	has _ECancellableLocksBase $!base     ;
	has GRecMutex              $!rec_mutex;
}

class EClient is repr<CStruct> is export {
	has GObject        $!parent;
	has Pointer $!priv  ;
}

class EClientErrorsList is repr<CStruct> is export {
	has gchar $!name    ;
	has gint  $!err_code;
}

class ECredentials is repr<CStruct> is export {
	has Pointer $!priv;
}

class EExtensibleInterface is repr<CStruct> is export {
	has GTypeInterface $!parent_interface;
}

class EExtension is repr<CStruct> is export {
	has GObject           $!parent;
	has Pointer $!priv  ;
}

class EExtensionClass is repr<CStruct> is export {
	has GObjectClass $!parent_class   ;
	has GType        $!extensible_type;
}

class EFreeFormExpSymbol is repr<CStruct> is export {
	has gchar                     $!names     ;
	has gchar                     $!hint      ;
	has EFreeFormExpBuildSexpFunc $!build_sexp;
}

class EIterator is repr<CStruct> is export {
	has GObject $!parent;
}

class EList is repr<CStruct> is export {
	has GObject       $!parent   ;
	has GList         $!list     ;
	has GList         $!iterators;
	has EListCopyFunc $!copy     ;
	has EListFreeFunc $!free     ;
	has gpointer      $!closure  ;
}

class EListClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class EListIterator is repr<CStruct> is export {
	has EIterator $!parent  ;
	has EList     $!list    ;
	has GList     $!iterator;
}

class EListIteratorClass is repr<CStruct> is export {
	has EIteratorClass $!parent_class;
}

class EModule is repr<CStruct> is export {
	has GTypeModule    $!parent;
	has Pointer $!priv  ;
}

class EModuleClass is repr<CStruct> is export {
	has GTypeModuleClass $!parent_class;
}

class ENetworkMonitor is repr<CStruct> is export {
	has GObject                $!parent;
	has Pointer $!priv  ;
}

class ENetworkMonitorClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class EProxy is repr<CStruct> is export {
	has GObject       $!parent;
	has Pointer $!priv  ;
}

class EReminderWatcher is repr<CStruct> is export {
	has GObject                 $!parent;
	has Pointer $!priv  ;
}

class ESExp is repr<CStruct> is export {
	has GObject      $!parent_object;
	has Pointer $!priv         ;
}

class ESExpClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class ESoupAuthBearer is repr<CStruct> is export {
	has SoupAuth               $!parent;
	has Pointer $!priv  ;
}

class ESoupAuthBearerClass is repr<CStruct> is export {
	has SoupAuthClass $!parent_class;
}

class ESoupSession is repr<CStruct> is export {
	has SoupSession         $!parent;
	has Pointer $!priv  ;
}

class ESource is repr<CStruct> is export {
	has GObject        $!parent;
	has Pointer $!priv  ;
}

class ESourceAddressBook is repr<CStruct> is export {
	has ESourceBackend            $!parent;
	has Pointer $!priv  ;
}

class ESourceAddressBookClass is repr<CStruct> is export {
	has ESourceBackendClass $!parent_class;
}

class ESourceAlarms is repr<CStruct> is export {
	has ESourceExtension     $!parent;
	has Pointer $!priv  ;
}

class ESourceAlarmsClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceAuthentication is repr<CStruct> is export {
	has ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceAuthenticationClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceAutocomplete is repr<CStruct> is export {
	has ESourceExtension           $!parent;
	has Pointer $!priv  ;
}

class ESourceAutocompleteClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceAutoconfig is repr<CStruct> is export {
	has ESourceExtension         $!parent;
	has Pointer $!priv  ;
}

class ESourceAutoconfigClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceBackend is repr<CStruct> is export {
	has ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceBackendClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceCalendar is repr<CStruct> is export {
	has ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceCalendarClass is repr<CStruct> is export {
	has ESourceSelectableClass $!parent_class;
}

class ESourceCamel is repr<CStruct> is export {
	has ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceCamelClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class ;
	has GType                 $!settings_type;
}

class ESourceCollection is repr<CStruct> is export {
	has ESourceBackend           $!parent;
	has Pointer $!priv  ;
}

class ESourceCollectionClass is repr<CStruct> is export {
	has ESourceBackendClass $!parent_class;
}

class ESourceContacts is repr<CStruct> is export {
	has ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceContactsClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceCredentialsProvider is repr<CStruct> is export {
	has GObject                           $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImpl is repr<CStruct> is export {
	has EExtension                            $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImplPassword is repr<CStruct> is export {
	has ESourceCredentialsProviderImpl                $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImplPasswordClass is repr<CStruct> is export {
	has ESourceCredentialsProviderImplClass $!parent_class;
}

class ESourceExtension is repr<CStruct> is export {
	has GObject                 $!parent;
	has Pointer $!priv  ;
}

class ESourceExtensionClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gchar        $!name        ;
}

class ESourceGoa is repr<CStruct> is export {
	has ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceGoaClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceLDAP is repr<CStruct> is export {
	has ESourceExtension   $!parent;
	has Pointer $!priv  ;
}

class ESourceLDAPClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceLocal is repr<CStruct> is export {
	has ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceLocalClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMDN is repr<CStruct> is export {
	has ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceMDNClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMailAccount is repr<CStruct> is export {
	has ESourceBackend            $!parent;
	has Pointer $!priv  ;
}

class ESourceMailAccountClass is repr<CStruct> is export {
	has ESourceBackendClass $!parent_class;
}

class ESourceMailComposition is repr<CStruct> is export {
	has ESourceExtension              $!parent;
	has Pointer $!priv  ;
}

class ESourceMailCompositionClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMailIdentity is repr<CStruct> is export {
	has ESourceExtension           $!parent;
	has Pointer $!priv  ;
}

class ESourceMailIdentityClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMailSignature is repr<CStruct> is export {
	has ESourceExtension            $!parent;
	has Pointer $!priv  ;
}

class ESourceMailSignatureClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMailSubmission is repr<CStruct> is export {
	has ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceMailSubmissionClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceMailTransport is repr<CStruct> is export {
	has ESourceBackend              $!parent;
	has Pointer $!priv  ;
}

class ESourceMailTransportClass is repr<CStruct> is export {
	has ESourceBackendClass $!parent_class;
}

class ESourceMemoList is repr<CStruct> is export {
	has ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceMemoListClass is repr<CStruct> is export {
	has ESourceSelectableClass $!parent_class;
}

class ESourceOffline is repr<CStruct> is export {
	has ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceOfflineClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceOpenPGP is repr<CStruct> is export {
	has ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceOpenPGPClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceProxy is repr<CStruct> is export {
	has ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceProxyClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceRefresh is repr<CStruct> is export {
	has ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceRefreshClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceRegistry is repr<CStruct> is export {
	has GObject                $!parent;
	has Pointer $!priv  ;
}

class ESourceRegistryWatcher is repr<CStruct> is export {
	has GObject                       $!parent;
	has Pointer $!priv  ;
}

class ESourceResource is repr<CStruct> is export {
	has ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceResourceClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceRevisionGuards is repr<CStruct> is export {
	has ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceRevisionGuardsClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceSMIME is repr<CStruct> is export {
	has ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceSMIMEClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceSecurity is repr<CStruct> is export {
	has ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceSecurityClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceSelectable is repr<CStruct> is export {
	has ESourceBackend           $!parent;
	has Pointer $!priv  ;
}

class ESourceSelectableClass is repr<CStruct> is export {
	has ESourceBackendClass $!parent_class;
}

class ESourceTaskList is repr<CStruct> is export {
	has ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceTaskListClass is repr<CStruct> is export {
	has ESourceSelectableClass $!parent_class;
}

class ESourceUoa is repr<CStruct> is export {
	has ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceUoaClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceWeather is repr<CStruct> is export {
	has ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceWeatherClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class ESourceWebdav is repr<CStruct> is export {
	has ESourceExtension     $!parent;
	has Pointer $!priv  ;
}

class ESourceWebdavClass is repr<CStruct> is export {
	has ESourceExtensionClass $!parent_class;
}

class EUri is repr<CStruct> is export {
	has gchar $!protocol;
	has gchar $!user    ;
	has gchar $!authmech;
	has gchar $!passwd  ;
	has gchar $!host    ;
	has gint  $!port    ;
	has gchar $!path    ;
	has GData $!params  ;
	has gchar $!query   ;
	has gchar $!fragment;
}

class EWebDAVAccessControlEntry is repr<CStruct> is export {
	has EWebDAVACEPrincipalKind $!principal_kind;
	has gchar                   $!principal_href;
	has guint32                 $!flags         ;
	has gchar                   $!inherited_href;
	has GSList                  $!privileges    ;
}

class EWebDAVDiscoveredSource is repr<CStruct> is export {
	has gchar   $!href        ;
	has guint32 $!supports    ;
	has gchar   $!display_name;
	has gchar   $!description ;
	has gchar   $!color       ;
}

class EWebDAVPrivilege is repr<CStruct> is export {
	has gchar                $!ns_uri     ;
	has gchar                $!name       ;
	has gchar                $!description;
	has EWebDAVPrivilegeKind $!kind       ;
	has EWebDAVPrivilegeHint $!hint       ;
}

class EWebDAVPropertyChange is repr<CStruct> is export {
	has EWebDAVPropertyChangeKind $!kind  ;
	has gchar                     $!ns_uri;
	has gchar                     $!name  ;
	has gchar                     $!value ;
}

class EWebDAVResource is repr<CStruct> is export {
	has EWebDAVResourceKind $!kind          ;
	has guint32             $!supports      ;
	has gchar               $!href          ;
	has gchar               $!etag          ;
	has gchar               $!display_name  ;
	has gchar               $!content_type  ;
	has gsize               $!content_length;
	has glong               $!creation_date ;
	has glong               $!last_modified ;
	has gchar               $!description   ;
	has gchar               $!color         ;
}

class EWebDAVSession is repr<CStruct> is export {
	has ESoupSession          $!parent;
	has Pointer $!priv  ;
}

class EXmlDocument is repr<CStruct> is export {
	has GObject             $!parent;
	has Pointer $!priv  ;
}

class addrinfo is repr<CStruct> is export {
	has gint     $!ai_flags    ;
	has gint     $!ai_family   ;
	has gint     $!ai_socktype ;
	has gint     $!ai_protocol ;
	has gsize    $!ai_addrlen  ;
	has sockaddr $!ai_addr     ;
	has gchar    $!ai_canonname;
	has addrinfo $!ai_next     ;
}

class camel_header_param is repr<CStruct> is export {
	has _camel_header_param $!next ;
	has gchar               $!name ;
	has gchar               $!value;
}

class camel_search_word is repr<CStruct> is export {
	has camel_search_word_t $!type;
	has gchar               $!word;
}

class camel_search_words is repr<CStruct> is export {
	has gint                $!len  ;
	has camel_search_word_t $!type ;
	has _camel_search_word  $!words;
}

class encrypt is repr<CStruct> is export {
	has CamelCipherValidityEncrypt $!status     ;
	has gchar                      $!description;
	has GQueue                     $!encrypters ;
}

class sign is repr<CStruct> is export {
	has CamelCipherValiditySign $!status     ;
	has gchar                   $!description;
	has GQueue                  $!signers    ;
}
