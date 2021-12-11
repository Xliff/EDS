use v6.c;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::Enums;

# cw: This is a project-specific definition and hence included first.
our enum VCardVersion is export ('ver2-1', 'ver2_1' => 0, 'ver3', 'ver4');

constant CAMEL_STORE_INFO_FOLDER_TYPE_BIT is export = 10;

constant EOAuth2ServiceNavigationPolicy is export := guint32;
our enum EOAuth2ServiceNavigationPolicyEnum is export <
  E_OAUTH2_SERVICE_NAVIGATION_POLICY_DENY
  E_OAUTH2_SERVICE_NAVIGATION_POLICY_ALLOW
  E_OAUTH2_SERVICE_NAVIGATION_POLICY_ABORT
>;

constant CamelAuthenticationResult is export := guint32;
our enum CamelAuthenticationResultEnum is export <
  CAMEL_AUTHENTICATION_ERROR
  CAMEL_AUTHENTICATION_ACCEPTED
  CAMEL_AUTHENTICATION_REJECTED
>;

constant CamelBestencEncoding is export := guint32;
our enum CamelBestencEncodingEnum is export (
  'CAMEL_BESTENC_7BIT',
  'CAMEL_BESTENC_8BIT',
  'CAMEL_BESTENC_BINARY',
  CAMEL_BESTENC_TEXT      => 1 +< 8,
);

constant CamelBestencRequired is export := guint32;
our enum CamelBestencRequiredEnum is export (
  CAMEL_BESTENC_GET_ENCODING => 1 +< 0,
  CAMEL_BESTENC_GET_CHARSET  => 1 +< 1,
  CAMEL_BESTENC_LF_IS_CRLF   => 1 +< 8,
  CAMEL_BESTENC_NO_FROM      => 1 +< 9,
);

constant CamelBlockFileFlags is export := guint32;
our enum CamelBlockFileFlagsEnum is export (
  CAMEL_BLOCK_FILE_SYNC => 1 +< 0,
);

constant CamelBlockFlags is export := guint32;
our enum CamelBlockFlagsEnum is export (
  CAMEL_BLOCK_DIRTY    => 1 +< 0,
  CAMEL_BLOCK_DETACHED => 1 +< 1,
);

constant CamelCertTrust is export := guint32;
our enum CamelCertTrustEnum is export <
  CAMEL_CERT_TRUST_UNKNOWN
  CAMEL_CERT_TRUST_NEVER
  CAMEL_CERT_TRUST_MARGINAL
  CAMEL_CERT_TRUST_FULLY
  CAMEL_CERT_TRUST_ULTIMATE
  CAMEL_CERT_TRUST_TEMPORARY
>;

constant CamelCipherHash is export := guint32;
our enum CamelCipherHashEnum is export <
  CAMEL_CIPHER_HASH_DEFAULT
  CAMEL_CIPHER_HASH_MD2
  CAMEL_CIPHER_HASH_MD5
  CAMEL_CIPHER_HASH_SHA1
  CAMEL_CIPHER_HASH_SHA256
  CAMEL_CIPHER_HASH_SHA384
  CAMEL_CIPHER_HASH_SHA512
  CAMEL_CIPHER_HASH_RIPEMD160
  CAMEL_CIPHER_HASH_TIGER192
  CAMEL_CIPHER_HASH_HAVAL5160
>;

constant CamelCipherValidityEncrypt is export := guint32;
our enum CamelCipherValidityEncryptEnum is export <
  CAMEL_CIPHER_VALIDITY_ENCRYPT_NONE
  CAMEL_CIPHER_VALIDITY_ENCRYPT_WEAK
  CAMEL_CIPHER_VALIDITY_ENCRYPT_ENCRYPTED
  CAMEL_CIPHER_VALIDITY_ENCRYPT_STRONG
>;

constant CamelCipherValidityMode is export := guint32;
our enum CamelCipherValidityModeEnum is export <
  CAMEL_CIPHER_VALIDITY_SIGN
  CAMEL_CIPHER_VALIDITY_ENCRYPT
>;

constant CamelCipherValiditySign is export := guint32;
our enum CamelCipherValiditySignEnum is export <
  CAMEL_CIPHER_VALIDITY_SIGN_NONE
  CAMEL_CIPHER_VALIDITY_SIGN_GOOD
  CAMEL_CIPHER_VALIDITY_SIGN_BAD
  CAMEL_CIPHER_VALIDITY_SIGN_UNKNOWN
  CAMEL_CIPHER_VALIDITY_SIGN_NEED_PUBLIC_KEY
>;

constant CamelCompareType is export := guint32;
our enum CamelCompareTypeEnum is export <
  CAMEL_COMPARE_CASE_INSENSITIVE
  CAMEL_COMPARE_CASE_SENSITIVE
>;

constant CamelDBKnownColumnNames is export := gint32;
our enum CamelDBKnownColumnNamesEnum is export (
  CAMEL_DB_COLUMN_UNKNOWN               => -1,
  'CAMEL_DB_COLUMN_ATTACHMENT',
  'CAMEL_DB_COLUMN_BDATA',
  'CAMEL_DB_COLUMN_CINFO',
  'CAMEL_DB_COLUMN_DELETED',
  'CAMEL_DB_COLUMN_DELETED_COUNT',
  'CAMEL_DB_COLUMN_DRECEIVED',
  'CAMEL_DB_COLUMN_DSENT',
  'CAMEL_DB_COLUMN_FLAGS',
  'CAMEL_DB_COLUMN_FOLDER_NAME',
  'CAMEL_DB_COLUMN_FOLLOWUP_COMPLETED_ON',
  'CAMEL_DB_COLUMN_FOLLOWUP_DUE_BY',
  'CAMEL_DB_COLUMN_FOLLOWUP_FLAG',
  'CAMEL_DB_COLUMN_IMPORTANT',
  'CAMEL_DB_COLUMN_JND_COUNT',
  'CAMEL_DB_COLUMN_JUNK',
  'CAMEL_DB_COLUMN_JUNK_COUNT',
  'CAMEL_DB_COLUMN_LABELS',
  'CAMEL_DB_COLUMN_MAIL_CC',
  'CAMEL_DB_COLUMN_MAIL_FROM',
  'CAMEL_DB_COLUMN_MAIL_TO',
  'CAMEL_DB_COLUMN_MLIST',
  'CAMEL_DB_COLUMN_NEXTUID',
  'CAMEL_DB_COLUMN_PART',
  'CAMEL_DB_COLUMN_READ',
  'CAMEL_DB_COLUMN_REPLIED',
  'CAMEL_DB_COLUMN_SAVED_COUNT',
  'CAMEL_DB_COLUMN_SIZE',
  'CAMEL_DB_COLUMN_SUBJECT',
  'CAMEL_DB_COLUMN_TIME',
  'CAMEL_DB_COLUMN_UID',
  'CAMEL_DB_COLUMN_UNREAD_COUNT',
  'CAMEL_DB_COLUMN_USERTAGS',
  'CAMEL_DB_COLUMN_VERSION',
  'CAMEL_DB_COLUMN_VISIBLE_COUNT',
  'CAMEL_DB_COLUMN_VUID'
);

constant CamelError is export := guint32;
our enum CamelErrorEnum is export <
  CAMEL_ERROR_GENERIC
>;

constant CamelFetchHeadersType is export := guint32;
our enum CamelFetchHeadersTypeEnum is export <
  CAMEL_FETCH_HEADERS_BASIC
  CAMEL_FETCH_HEADERS_BASIC_AND_MAILING_LIST
  CAMEL_FETCH_HEADERS_ALL
>;

constant CamelFetchType is export := guint32;
our enum CamelFetchTypeEnum is export <
  CAMEL_FETCH_OLD_MESSAGES
  CAMEL_FETCH_NEW_MESSAGES
>;

constant CamelFolderError is export := guint32;
our enum CamelFolderErrorEnum is export <
  CAMEL_FOLDER_ERROR_INVALID
  CAMEL_FOLDER_ERROR_INVALID_STATE
  CAMEL_FOLDER_ERROR_NON_EMPTY
  CAMEL_FOLDER_ERROR_NON_UID
  CAMEL_FOLDER_ERROR_INSUFFICIENT_PERMISSION
  CAMEL_FOLDER_ERROR_INVALID_PATH
  CAMEL_FOLDER_ERROR_INVALID_UID
  CAMEL_FOLDER_ERROR_SUMMARY_INVALID
>;

constant CamelFolderFlags is export := guint32;
our enum CamelFolderFlagsEnum is export (
  CAMEL_FOLDER_HAS_SUMMARY_CAPABILITY => 1 +< 0,
  CAMEL_FOLDER_FILTER_RECENT          => 1 +< 2,
  CAMEL_FOLDER_HAS_BEEN_DELETED       => 1 +< 3,
  CAMEL_FOLDER_IS_TRASH               => 1 +< 4,
  CAMEL_FOLDER_IS_JUNK                => 1 +< 5,
  CAMEL_FOLDER_FILTER_JUNK            => 1 +< 6,
);

constant CamelFolderInfoFlags is export := guint32;
our enum CamelFolderInfoFlagsEnum is export (
  CAMEL_FOLDER_NOSELECT      =>                      1 +< 0,
  CAMEL_FOLDER_NOINFERIORS   =>                      1 +< 1,
  CAMEL_FOLDER_CHILDREN      =>                      1 +< 2,
  CAMEL_FOLDER_NOCHILDREN    =>                      1 +< 3,
  CAMEL_FOLDER_SUBSCRIBED    =>                      1 +< 4,
  CAMEL_FOLDER_VIRTUAL       =>                      1 +< 5,
  CAMEL_FOLDER_SYSTEM        =>                      1 +< 6,
  CAMEL_FOLDER_VTRASH        =>                      1 +< 7,
  CAMEL_FOLDER_SHARED_TO_ME  =>                      1 +< 8,
  CAMEL_FOLDER_SHARED_BY_ME  =>                      1 +< 9,
  CAMEL_FOLDER_TYPE_NORMAL   =>  0 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_INBOX    =>  1 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_OUTBOX   =>  2 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_TRASH    =>  3 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_JUNK     =>  4 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_SENT     =>  5 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_CONTACTS =>  6 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_EVENTS   =>  7 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_MEMOS    =>  8 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_TASKS    =>  9 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_ALL      => 10 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_ARCHIVE  => 11 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_TYPE_DRAFTS   => 12 +< CAMEL_FOLDER_TYPE_BIT,
  CAMEL_FOLDER_READONLY      =>                     1 +< 16,
  CAMEL_FOLDER_WRITEONLY     =>                     1 +< 17,
  CAMEL_FOLDER_FLAGGED       =>                     1 +< 18,
  CAMEL_FOLDER_FLAGS_LAST    =>                     1 +< 24,
);

constant CamelFolderSummaryFlags is export := guint32;
our enum CamelFolderSummaryFlagsEnum is export (
  CAMEL_FOLDER_SUMMARY_DIRTY          => 1 +< 0,
  CAMEL_FOLDER_SUMMARY_IN_MEMORY_ONLY => 1 +< 1,
);

constant CamelHTMLParserState is export := guint32;
our enum CamelHTMLParserStateEnum is export <
  CAMEL_HTML_PARSER_DATA
  CAMEL_HTML_PARSER_ENT
  CAMEL_HTML_PARSER_ELEMENT
  CAMEL_HTML_PARSER_TAG
  CAMEL_HTML_PARSER_DTDENT
  CAMEL_HTML_PARSER_COMMENT0
  CAMEL_HTML_PARSER_COMMENT
  CAMEL_HTML_PARSER_ATTR0
  CAMEL_HTML_PARSER_ATTR
  CAMEL_HTML_PARSER_VAL0
  CAMEL_HTML_PARSER_VAL
  CAMEL_HTML_PARSER_VAL_ENT
  CAMEL_HTML_PARSER_EOD
  CAMEL_HTML_PARSER_EOF
>;

constant CamelHeaderAddressType is export := guint32;
our enum CamelHeaderAddressTypeEnum is export <
  CAMEL_HEADER_ADDRESS_NONE
  CAMEL_HEADER_ADDRESS_NAME
  CAMEL_HEADER_ADDRESS_GROUP
>;

constant CamelJunkStatus is export := guint32;
our enum CamelJunkStatusEnum is export <
  CAMEL_JUNK_STATUS_ERROR
  CAMEL_JUNK_STATUS_INCONCLUSIVE
  CAMEL_JUNK_STATUS_MESSAGE_IS_JUNK
  CAMEL_JUNK_STATUS_MESSAGE_IS_NOT_JUNK
>;

constant CamelLockType is export := guint32;
our enum CamelLockTypeEnum is export <
  CAMEL_LOCK_READ
  CAMEL_LOCK_WRITE
>;

our constant EbSqlLockType is export := guint32;
our enum EbSqlLockTypeEnum is export <
  EBSQL_LOCK_READ
  EBSQL_LOCK_WRITE
>;

constant CamelMemPoolFlags is export := guint32;
our enum CamelMemPoolFlagsEnum is export (
  'CAMEL_MEMPOOL_ALIGN_STRUCT',
  'CAMEL_MEMPOOL_ALIGN_WORD',
  'CAMEL_MEMPOOL_ALIGN_BYTE',
  CAMEL_MEMPOOL_ALIGN_MASK   => 0x3,
);

constant CamelMimeFilterBasicType is export := guint32;
our enum CamelMimeFilterBasicTypeEnum is export <
  CAMEL_MIME_FILTER_BASIC_INVALID
  CAMEL_MIME_FILTER_BASIC_BASE64_ENC
  CAMEL_MIME_FILTER_BASIC_BASE64_DEC
  CAMEL_MIME_FILTER_BASIC_QP_ENC
  CAMEL_MIME_FILTER_BASIC_QP_DEC
  CAMEL_MIME_FILTER_BASIC_UU_ENC
  CAMEL_MIME_FILTER_BASIC_UU_DEC
>;

constant CamelMimeFilterCRLFDirection is export := guint32;
our enum CamelMimeFilterCRLFDirectionEnum is export <
  CAMEL_MIME_FILTER_CRLF_ENCODE
  CAMEL_MIME_FILTER_CRLF_DECODE
>;

constant CamelMimeFilterCRLFMode is export := guint32;
our enum CamelMimeFilterCRLFModeEnum is export <
  CAMEL_MIME_FILTER_CRLF_MODE_CRLF_DOTS
  CAMEL_MIME_FILTER_CRLF_MODE_CRLF_ONLY
>;

constant CamelMimeFilterGZipMode is export := guint32;
our enum CamelMimeFilterGZipModeEnum is export <
  CAMEL_MIME_FILTER_GZIP_MODE_ZIP
  CAMEL_MIME_FILTER_GZIP_MODE_UNZIP
>;

constant CamelMimeFilterToHTMLFlags is export := guint32;
our enum CamelMimeFilterToHTMLFlagsEnum is export (
  CAMEL_MIME_FILTER_TOHTML_PRE               =>  1 +< 0,
  CAMEL_MIME_FILTER_TOHTML_CONVERT_NL        =>  1 +< 1,
  CAMEL_MIME_FILTER_TOHTML_CONVERT_SPACES    =>  1 +< 2,
  CAMEL_MIME_FILTER_TOHTML_CONVERT_URLS      =>  1 +< 3,
  CAMEL_MIME_FILTER_TOHTML_MARK_CITATION     =>  1 +< 4,
  CAMEL_MIME_FILTER_TOHTML_CONVERT_ADDRESSES =>  1 +< 5,
  CAMEL_MIME_FILTER_TOHTML_ESCAPE_8BIT       =>  1 +< 6,
  CAMEL_MIME_FILTER_TOHTML_CITE              =>  1 +< 7,
  CAMEL_MIME_FILTER_TOHTML_PRESERVE_8BIT     =>  1 +< 8,
  CAMEL_MIME_FILTER_TOHTML_FORMAT_FLOWED     =>  1 +< 9,
  CAMEL_MIME_FILTER_TOHTML_QUOTE_CITATION    => 1 +< 10,
  CAMEL_MIME_FILTER_TOHTML_DIV               => 1 +< 11,
);

constant CamelMimeFilterYencDirection is export := guint32;
our enum CamelMimeFilterYencDirectionEnum is export <
  CAMEL_MIME_FILTER_YENC_DIRECTION_ENCODE
  CAMEL_MIME_FILTER_YENC_DIRECTION_DECODE
>;

constant CamelMimeParserState is export := guint32;
our enum CamelMimeParserStateEnum is export (
  'CAMEL_MIME_PARSER_STATE_INITIAL',
  'CAMEL_MIME_PARSER_STATE_PRE_FROM',
  'CAMEL_MIME_PARSER_STATE_FROM',
  'CAMEL_MIME_PARSER_STATE_HEADER',
  'CAMEL_MIME_PARSER_STATE_BODY',
  'CAMEL_MIME_PARSER_STATE_MULTIPART',
  'CAMEL_MIME_PARSER_STATE_MESSAGE',
  'CAMEL_MIME_PARSER_STATE_PART',
  CAMEL_MIME_PARSER_STATE_END           => 8,
  CAMEL_MIME_PARSER_STATE_EOF           => 8,
  'CAMEL_MIME_PARSER_STATE_PRE_FROM_END',
  'CAMEL_MIME_PARSER_STATE_FROM_END',
  'CAMEL_MIME_PARSER_STATE_HEADER_END',
  'CAMEL_MIME_PARSER_STATE_BODY_END',
  'CAMEL_MIME_PARSER_STATE_MULTIPART_END',
  'CAMEL_MIME_PARSER_STATE_MESSAGE_END'
);

constant CamelNetworkSecurityMethod is export := guint32;
our enum CamelNetworkSecurityMethodEnum is export <
  CAMEL_NETWORK_SECURITY_METHOD_NONE
  CAMEL_NETWORK_SECURITY_METHOD_SSL_ON_ALTERNATE_PORT
  CAMEL_NETWORK_SECURITY_METHOD_STARTTLS_ON_STANDARD_PORT
>;

constant CamelProviderConfType is export := guint32;
our enum CamelProviderConfTypeEnum is export <
  CAMEL_PROVIDER_CONF_END
  CAMEL_PROVIDER_CONF_SECTION_START
  CAMEL_PROVIDER_CONF_SECTION_END
  CAMEL_PROVIDER_CONF_CHECKBOX
  CAMEL_PROVIDER_CONF_CHECKSPIN
  CAMEL_PROVIDER_CONF_ENTRY
  CAMEL_PROVIDER_CONF_LABEL
  CAMEL_PROVIDER_CONF_HIDDEN
  CAMEL_PROVIDER_CONF_OPTIONS
  CAMEL_PROVIDER_CONF_PLACEHOLDER
>;

constant CamelProviderFlags is export := guint32;
our enum CamelProviderFlagsEnum is export (
  CAMEL_PROVIDER_IS_REMOTE                    =>  1 +<  0,
  CAMEL_PROVIDER_IS_LOCAL                     =>  1 +<  1,
  CAMEL_PROVIDER_IS_EXTERNAL                  =>  1 +<  2,
  CAMEL_PROVIDER_IS_SOURCE                    =>  1 +<  3,
  CAMEL_PROVIDER_IS_STORAGE                   =>  1 +<  4,
  CAMEL_PROVIDER_SUPPORTS_SSL                 =>  1 +<  5,
  CAMEL_PROVIDER_HAS_LICENSE                  =>  1 +<  6,
  CAMEL_PROVIDER_DISABLE_SENT_FOLDER          =>  1 +<  7,
  CAMEL_PROVIDER_ALLOW_REAL_TRASH_FOLDER      =>  1 +<  8,
  CAMEL_PROVIDER_ALLOW_REAL_JUNK_FOLDER       =>  1 +<  9,
  CAMEL_PROVIDER_SUPPORTS_MOBILE_DEVICES      =>  1 +< 10,
  CAMEL_PROVIDER_SUPPORTS_BATCH_FETCH         =>  1 +< 11,
  CAMEL_PROVIDER_SUPPORTS_PURGE_MESSAGE_CACHE =>  1 +< 12,
);

constant CamelProviderType is export := guint32;
our enum CamelProviderTypeEnum is export <
  CAMEL_PROVIDER_STORE
  CAMEL_PROVIDER_TRANSPORT
  CAMEL_NUM_PROVIDER_TYPES
>;

constant CamelRecipientCertificateFlags is export := guint32;
our enum CamelRecipientCertificateFlagsEnum is export (
  CAMEL_RECIPIENT_CERTIFICATE_SMIME => 1 +< 0,
  CAMEL_RECIPIENT_CERTIFICATE_PGP   => 1 +< 1,
);

constant CamelSExpResultType is export := guint32;
our enum CamelSExpResultTypeEnum is export <
  CAMEL_SEXP_RES_ARRAY_PTR
  CAMEL_SEXP_RES_INT
  CAMEL_SEXP_RES_STRING
  CAMEL_SEXP_RES_BOOL
  CAMEL_SEXP_RES_TIME
  CAMEL_SEXP_RES_UNDEFINED
>;

constant CamelSExpTermType is export := guint32;
our enum CamelSExpTermTypeEnum is export <
  CAMEL_SEXP_TERM_INT
  CAMEL_SEXP_TERM_BOOL
  CAMEL_SEXP_TERM_STRING
  CAMEL_SEXP_TERM_TIME
  CAMEL_SEXP_TERM_FUNC
  CAMEL_SEXP_TERM_IFUNC
  CAMEL_SEXP_TERM_VAR
>;

constant CamelSMIMEDescribe is export := guint32;
our enum CamelSMIMEDescribeEnum is export (
  CAMEL_SMIME_SIGNED    => 1 +< 0,
  CAMEL_SMIME_ENCRYPTED => 1 +< 1,
  CAMEL_SMIME_CERTS     => 1 +< 2,
  CAMEL_SMIME_CRLS      => 1 +< 3,
);

constant CamelSMIMESign is export := guint32;
our enum CamelSMIMESignEnum is export <
  CAMEL_SMIME_SIGN_CLEARSIGN
  CAMEL_SMIME_SIGN_ENVELOPED
>;

constant CamelSaslAnonTraceType is export := guint32;
our enum CamelSaslAnonTraceTypeEnum is export <
  CAMEL_SASL_ANON_TRACE_EMAIL
  CAMEL_SASL_ANON_TRACE_OPAQUE
  CAMEL_SASL_ANON_TRACE_EMPTY
>;

constant CamelServiceConnectionStatus is export := guint32;
our enum CamelServiceConnectionStatusEnum is export <
  CAMEL_SERVICE_DISCONNECTED
  CAMEL_SERVICE_CONNECTING
  CAMEL_SERVICE_CONNECTED
  CAMEL_SERVICE_DISCONNECTING
>;

constant CamelServiceError is export := guint32;
our enum CamelServiceErrorEnum is export <
  CAMEL_SERVICE_ERROR_INVALID
  CAMEL_SERVICE_ERROR_URL_INVALID
  CAMEL_SERVICE_ERROR_UNAVAILABLE
  CAMEL_SERVICE_ERROR_CANT_AUTHENTICATE
  CAMEL_SERVICE_ERROR_NOT_CONNECTED
>;

constant CamelSessionAlertType is export := guint32;
our enum CamelSessionAlertTypeEnum is export <
  CAMEL_SESSION_ALERT_INFO
  CAMEL_SESSION_ALERT_WARNING
  CAMEL_SESSION_ALERT_ERROR
>;

constant CamelSortType is export := guint32;
our enum CamelSortTypeEnum is export <
  CAMEL_SORT_ASCENDING
  CAMEL_SORT_DESCENDING
>;

constant CamelStoreError is export := guint32;
our enum CamelStoreErrorEnum is export <
  CAMEL_STORE_ERROR_INVALID
  CAMEL_STORE_ERROR_NO_FOLDER
>;

constant CamelStoreFlags is export := guint32;
our enum CamelStoreFlagsEnum is export (
  CAMEL_STORE_VTRASH                     => 1 +< 0,
  CAMEL_STORE_VJUNK                      => 1 +< 1,
  CAMEL_STORE_PROXY                      => 1 +< 2,
  CAMEL_STORE_IS_MIGRATING               => 1 +< 3,
  CAMEL_STORE_REAL_JUNK_FOLDER           => 1 +< 4,
  CAMEL_STORE_CAN_EDIT_FOLDERS           => 1 +< 5,
  CAMEL_STORE_USE_CACHE_DIR              => 1 +< 6,
  CAMEL_STORE_CAN_DELETE_FOLDERS_AT_ONCE => 1 +< 7,
  CAMEL_STORE_SUPPORTS_INITIAL_SETUP     => 1 +< 8,
);

constant CamelStoreGetFolderFlags is export := guint32;
our enum CamelStoreGetFolderFlagsEnum is export (
  CAMEL_STORE_FOLDER_NONE       =>      0,
  CAMEL_STORE_FOLDER_CREATE     => 1 +< 0,
  CAMEL_STORE_FOLDER_EXCL       => 1 +< 1,
  CAMEL_STORE_FOLDER_BODY_INDEX => 1 +< 2,
  CAMEL_STORE_FOLDER_PRIVATE    => 1 +< 3,
);

constant CamelStoreGetFolderInfoFlags is export := guint32;
our enum CamelStoreGetFolderInfoFlagsEnum is export (
  CAMEL_STORE_FOLDER_INFO_FAST              => 1 +< 0,
  CAMEL_STORE_FOLDER_INFO_RECURSIVE         => 1 +< 1,
  CAMEL_STORE_FOLDER_INFO_SUBSCRIBED        => 1 +< 2,
  CAMEL_STORE_FOLDER_INFO_NO_VIRTUAL        => 1 +< 3,
  CAMEL_STORE_FOLDER_INFO_SUBSCRIPTION_LIST => 1 +< 4,
  CAMEL_STORE_FOLDER_INFO_REFRESH           => 1 +< 5,
);

constant CamelStoreInfoFlags is export := guint32;
our enum CamelStoreInfoFlagsEnum is export (
  CAMEL_STORE_INFO_FOLDER_NOSELECT      =>                                 1 +< 0,
  CAMEL_STORE_INFO_FOLDER_NOINFERIORS   =>                                 1 +< 1,
  CAMEL_STORE_INFO_FOLDER_CHILDREN      =>                                 1 +< 2,
  CAMEL_STORE_INFO_FOLDER_NOCHILDREN    =>                                 1 +< 3,
  CAMEL_STORE_INFO_FOLDER_SUBSCRIBED    =>                                 1 +< 4,
  CAMEL_STORE_INFO_FOLDER_VIRTUAL       =>                                 1 +< 5,
  CAMEL_STORE_INFO_FOLDER_SYSTEM        =>                                 1 +< 6,
  CAMEL_STORE_INFO_FOLDER_VTRASH        =>                                 1 +< 7,
  CAMEL_STORE_INFO_FOLDER_SHARED_TO_ME  =>                                 1 +< 8,
  CAMEL_STORE_INFO_FOLDER_SHARED_BY_ME  =>                                 1 +< 9,
  CAMEL_STORE_INFO_FOLDER_TYPE_NORMAL   =>  0 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_INBOX    =>  1 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_OUTBOX   =>  2 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_TRASH    =>  3 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_JUNK     =>  4 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_SENT     =>  5 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_CONTACTS =>  6 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_EVENTS   =>  7 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_MEMOS    =>  8 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_TASKS    =>  9 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_ALL      => 10 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_ARCHIVE  => 11 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_TYPE_DRAFTS   => 12 +< CAMEL_STORE_INFO_FOLDER_TYPE_BIT,
  CAMEL_STORE_INFO_FOLDER_READONLY      =>                                1 +< 16,
  CAMEL_STORE_INFO_FOLDER_WRITEONLY     =>                                1 +< 17,
  CAMEL_STORE_INFO_FOLDER_FLAGGED       =>                                1 +< 18,
  CAMEL_STORE_INFO_FOLDER_LAST          =>                                1 +< 24,
);

constant CamelStorePermissionFlags is export := guint32;
our enum CamelStorePermissionFlagsEnum is export (
  CAMEL_STORE_READ  => 1 +< 0,
  CAMEL_STORE_WRITE => 1 +< 1,
);

constant CamelStreamBufferMode is export := guint32;
our enum CamelStreamBufferModeEnum is export (
  CAMEL_STREAM_BUFFER_BUFFER =>    0,
  'CAMEL_STREAM_BUFFER_NONE',
  CAMEL_STREAM_BUFFER_READ   => 0x00,
  CAMEL_STREAM_BUFFER_WRITE  => 0x80,
  CAMEL_STREAM_BUFFER_MODE   => 0x80,
);

constant CamelThreeState is export := guint32;
our enum CamelThreeStateEnum is export (
  CAMEL_THREE_STATE_OFF          => 0,
  'CAMEL_THREE_STATE_ON',
  'CAMEL_THREE_STATE_INCONSISTENT'
);

constant CamelTimeUnit is export := guint32;
our enum CamelTimeUnitEnum is export (
  CAMEL_TIME_UNIT_DAYS   => 1,
  'CAMEL_TIME_UNIT_WEEKS',
  'CAMEL_TIME_UNIT_MONTHS',
  'CAMEL_TIME_UNIT_YEARS'
);

constant CamelTransferEncoding is export := guint32;
our enum CamelTransferEncodingEnum is export <
  CAMEL_TRANSFER_ENCODING_DEFAULT
  CAMEL_TRANSFER_ENCODING_7BIT
  CAMEL_TRANSFER_ENCODING_8BIT
  CAMEL_TRANSFER_ENCODING_BASE64
  CAMEL_TRANSFER_ENCODING_QUOTEDPRINTABLE
  CAMEL_TRANSFER_ENCODING_BINARY
  CAMEL_TRANSFER_ENCODING_UUENCODE
  CAMEL_TRANSFER_NUM_ENCODINGS
>;

constant CamelURLFlags is export := guint32;
our enum CamelURLFlagsEnum is export (
  CAMEL_URL_HIDE_PARAMS => 1 +< 0,
  CAMEL_URL_HIDE_AUTH   => 1 +< 1,
);

constant CamelUUDecodeState is export := guint32;
our enum CamelUUDecodeStateEnum is export (
  CAMEL_UUDECODE_STATE_INIT  =>         0,
  CAMEL_UUDECODE_STATE_BEGIN => (1 +< 16),
  CAMEL_UUDECODE_STATE_END   => (1 +< 17),
);

constant CamelVTrashFolderType is export := guint32;
our enum CamelVTrashFolderTypeEnum is export <
  CAMEL_VTRASH_FOLDER_TRASH
  CAMEL_VTRASH_FOLDER_JUNK
  CAMEL_VTRASH_FOLDER_LAST
>;

constant ECalClientError is export := guint32;
our enum ECalClientErrorEnum is export <
  E_CAL_CLIENT_ERROR_NO_SUCH_CALENDAR
  E_CAL_CLIENT_ERROR_OBJECT_NOT_FOUND
  E_CAL_CLIENT_ERROR_INVALID_OBJECT
  E_CAL_CLIENT_ERROR_UNKNOWN_USER
  E_CAL_CLIENT_ERROR_OBJECT_ID_ALREADY_EXISTS
  E_CAL_CLIENT_ERROR_INVALID_RANGE
>;

constant ECalClientSourceType is export := guint32;
our enum ECalClientSourceTypeEnum is export <
  E_CAL_CLIENT_SOURCE_TYPE_EVENTS
  E_CAL_CLIENT_SOURCE_TYPE_TASKS
  E_CAL_CLIENT_SOURCE_TYPE_MEMOS
  E_CAL_CLIENT_SOURCE_TYPE_LAST
>;

constant ECalClientViewFlags is export := guint32;
our enum ECalClientViewFlagsEnum is export (
  E_CAL_CLIENT_VIEW_FLAGS_NONE           =>        0,
  E_CAL_CLIENT_VIEW_FLAGS_NOTIFY_INITIAL => (1 +< 0),
);

constant ECalComponentAlarmAction is export := guint32;
our enum ECalComponentAlarmActionEnum is export <
  E_CAL_COMPONENT_ALARM_NONE
  E_CAL_COMPONENT_ALARM_AUDIO
  E_CAL_COMPONENT_ALARM_DISPLAY
  E_CAL_COMPONENT_ALARM_EMAIL
  E_CAL_COMPONENT_ALARM_PROCEDURE
  E_CAL_COMPONENT_ALARM_UNKNOWN
>;

constant ECalComponentAlarmTriggerKind is export := guint32;
our enum ECalComponentAlarmTriggerKindEnum is export <
  E_CAL_COMPONENT_ALARM_TRIGGER_NONE
  E_CAL_COMPONENT_ALARM_TRIGGER_RELATIVE_START
  E_CAL_COMPONENT_ALARM_TRIGGER_RELATIVE_END
  E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE
>;

constant ECalComponentClassification is export := guint32;
our enum ECalComponentClassificationEnum is export <
  E_CAL_COMPONENT_CLASS_NONE
  E_CAL_COMPONENT_CLASS_PUBLIC
  E_CAL_COMPONENT_CLASS_PRIVATE
  E_CAL_COMPONENT_CLASS_CONFIDENTIAL
  E_CAL_COMPONENT_CLASS_UNKNOWN
>;

constant ECalComponentPeriodKind is export := guint32;
our enum ECalComponentPeriodKindEnum is export <
  E_CAL_COMPONENT_PERIOD_DATETIME
  E_CAL_COMPONENT_PERIOD_DURATION
>;

constant ECalComponentRangeKind is export := guint32;
our enum ECalComponentRangeKindEnum is export <
  E_CAL_COMPONENT_RANGE_SINGLE
  E_CAL_COMPONENT_RANGE_THISPRIOR
  E_CAL_COMPONENT_RANGE_THISFUTURE
>;

constant ECalComponentTransparency is export := guint32;
our enum ECalComponentTransparencyEnum is export <
  E_CAL_COMPONENT_TRANSP_NONE
  E_CAL_COMPONENT_TRANSP_TRANSPARENT
  E_CAL_COMPONENT_TRANSP_OPAQUE
  E_CAL_COMPONENT_TRANSP_UNKNOWN
>;

constant ECalComponentVType is export := guint32;
our enum ECalComponentVTypeEnum is export <
  E_CAL_COMPONENT_NO_TYPE
  E_CAL_COMPONENT_EVENT
  E_CAL_COMPONENT_TODO
  E_CAL_COMPONENT_JOURNAL
  E_CAL_COMPONENT_FREEBUSY
  E_CAL_COMPONENT_TIMEZONE
>;

constant ECalObjModType is export := guint32;
our enum ECalObjModTypeEnum is export (
  E_CAL_OBJ_MOD_THIS            => 1 +< 0,
  E_CAL_OBJ_MOD_THIS_AND_PRIOR  => 1 +< 1,
  E_CAL_OBJ_MOD_THIS_AND_FUTURE => 1 +< 2,
  E_CAL_OBJ_MOD_ALL             =>   0x07,
  E_CAL_OBJ_MOD_ONLY_THIS       => 1 +< 3,
);

constant ECalOperationFlags is export := guint32;
our enum ECalOperationFlagsEnum is export (
  E_CAL_OPERATION_FLAG_NONE                 =>        0,
  E_CAL_OPERATION_FLAG_CONFLICT_FAIL        => (1 +< 0),
  E_CAL_OPERATION_FLAG_CONFLICT_USE_NEWER   => (1 +< 1),
  E_CAL_OPERATION_FLAG_CONFLICT_KEEP_SERVER => (1 +< 2),
  E_CAL_OPERATION_FLAG_CONFLICT_KEEP_LOCAL  =>        0,
  E_CAL_OPERATION_FLAG_CONFLICT_WRITE_COPY  => (1 +< 3),
  E_CAL_OPERATION_FLAG_DISABLE_ITIP_MESSAGE => (1 +< 4),
);

constant ECalRecurDescribeRecurrenceFlags is export := guint32;
our enum ECalRecurDescribeRecurrenceFlagsEnum is export (
  E_CAL_RECUR_DESCRIBE_RECURRENCE_FLAG_NONE     =>        0,
  E_CAL_RECUR_DESCRIBE_RECURRENCE_FLAG_PREFIXED => (1 +< 0),
  E_CAL_RECUR_DESCRIBE_RECURRENCE_FLAG_FALLBACK => (1 +< 1),
);

constant EClientError is export := guint32;
our enum EClientErrorEnum is export <
  E_CLIENT_ERROR_INVALID_ARG
  E_CLIENT_ERROR_BUSY
  E_CLIENT_ERROR_SOURCE_NOT_LOADED
  E_CLIENT_ERROR_SOURCE_ALREADY_LOADED
  E_CLIENT_ERROR_AUTHENTICATION_FAILED
  E_CLIENT_ERROR_AUTHENTICATION_REQUIRED
  E_CLIENT_ERROR_REPOSITORY_OFFLINE
  E_CLIENT_ERROR_OFFLINE_UNAVAILABLE
  E_CLIENT_ERROR_PERMISSION_DENIED
  E_CLIENT_ERROR_CANCELLED
  E_CLIENT_ERROR_COULD_NOT_CANCEL
  E_CLIENT_ERROR_NOT_SUPPORTED
  E_CLIENT_ERROR_TLS_NOT_AVAILABLE
  E_CLIENT_ERROR_UNSUPPORTED_AUTHENTICATION_METHOD
  E_CLIENT_ERROR_SEARCH_SIZE_LIMIT_EXCEEDED
  E_CLIENT_ERROR_SEARCH_TIME_LIMIT_EXCEEDED
  E_CLIENT_ERROR_INVALID_QUERY
  E_CLIENT_ERROR_QUERY_REFUSED
  E_CLIENT_ERROR_DBUS_ERROR
  E_CLIENT_ERROR_OTHER_ERROR
  E_CLIENT_ERROR_NOT_OPENED
  E_CLIENT_ERROR_OUT_OF_SYNC
>;

constant ECollatorError is export := guint32;
our enum ECollatorErrorEnum is export <
  E_COLLATOR_ERROR_OPEN
  E_COLLATOR_ERROR_CONVERSION
  E_COLLATOR_ERROR_INVALID_LOCALE
>;

constant EConflictResolution is export := guint32;
our enum EConflictResolutionEnum is export (
  E_CONFLICT_RESOLUTION_FAIL           => 0,
  'E_CONFLICT_RESOLUTION_USE_NEWER',
  'E_CONFLICT_RESOLUTION_KEEP_SERVER',
  'E_CONFLICT_RESOLUTION_KEEP_LOCAL',
  'E_CONFLICT_RESOLUTION_WRITE_COPY'
);

constant EMdnResponsePolicy is export := guint32;
our enum EMdnResponsePolicyEnum is export <
  E_MDN_RESPONSE_POLICY_NEVER
  E_MDN_RESPONSE_POLICY_ALWAYS
  E_MDN_RESPONSE_POLICY_ASK
>;

constant EProxyMethod is export := guint32;
our enum EProxyMethodEnum is export <
  E_PROXY_METHOD_DEFAULT
  E_PROXY_METHOD_MANUAL
  E_PROXY_METHOD_AUTO
  E_PROXY_METHOD_NONE
>;

constant EReminderWatcherDescribeFlags is export := guint32;
our enum EReminderWatcherDescribeFlagsEnum is export (
  E_REMINDER_WATCHER_DESCRIBE_FLAG_NONE   =>        0,
  E_REMINDER_WATCHER_DESCRIBE_FLAG_MARKUP => (1 +< 1),
);

constant ESExpResultType is export := guint32;
our enum ESExpResultTypeEnum is export (
  ESEXP_RES_ARRAY_PTR   => 0,
  'ESEXP_RES_INT',
  'ESEXP_RES_STRING',
  'ESEXP_RES_BOOL',
  'ESEXP_RES_TIME',
  'ESEXP_RES_UNDEFINED'
);

constant ESExpTermType is export := guint32;
our enum ESExpTermTypeEnum is export (
  ESEXP_TERM_INT       => 0,
  'ESEXP_TERM_BOOL',
  'ESEXP_TERM_STRING',
  'ESEXP_TERM_TIME',
  'ESEXP_TERM_FUNC',
  'ESEXP_TERM_IFUNC',
  'ESEXP_TERM_VAR'
);

constant ESourceAuthenticationResult is export := gint32;
our enum ESourceAuthenticationResultEnum is export (
  E_SOURCE_AUTHENTICATION_UNKNOWN              => -1,
  'E_SOURCE_AUTHENTICATION_ERROR',
  'E_SOURCE_AUTHENTICATION_ERROR_SSL_FAILED',
  'E_SOURCE_AUTHENTICATION_ACCEPTED',
  'E_SOURCE_AUTHENTICATION_REJECTED',
  'E_SOURCE_AUTHENTICATION_REQUIRED'
);

constant ESourceConnectionStatus is export := guint32;
our enum ESourceConnectionStatusEnum is export <
  E_SOURCE_CONNECTION_STATUS_DISCONNECTED
  E_SOURCE_CONNECTION_STATUS_AWAITING_CREDENTIALS
  E_SOURCE_CONNECTION_STATUS_SSL_FAILED
  E_SOURCE_CONNECTION_STATUS_CONNECTING
  E_SOURCE_CONNECTION_STATUS_CONNECTED
>;

constant ESourceCredentialsReason is export := guint32;
our enum ESourceCredentialsReasonEnum is export <
  E_SOURCE_CREDENTIALS_REASON_UNKNOWN
  E_SOURCE_CREDENTIALS_REASON_REQUIRED
  E_SOURCE_CREDENTIALS_REASON_REJECTED
  E_SOURCE_CREDENTIALS_REASON_SSL_FAILED
  E_SOURCE_CREDENTIALS_REASON_ERROR
>;

constant ESourceLDAPAuthentication is export := guint32;
our enum ESourceLDAPAuthenticationEnum is export <
  E_SOURCE_LDAP_AUTHENTICATION_NONE
  E_SOURCE_LDAP_AUTHENTICATION_EMAIL
  E_SOURCE_LDAP_AUTHENTICATION_BINDDN
>;

constant ESourceLDAPScope is export := guint32;
our enum ESourceLDAPScopeEnum is export <
  E_SOURCE_LDAP_SCOPE_ONELEVEL
  E_SOURCE_LDAP_SCOPE_SUBTREE
>;

constant ESourceLDAPSecurity is export := guint32;
our enum ESourceLDAPSecurityEnum is export <
  E_SOURCE_LDAP_SECURITY_NONE
  E_SOURCE_LDAP_SECURITY_LDAPS
  E_SOURCE_LDAP_SECURITY_STARTTLS
>;

constant ESourceMailCompositionReplyStyle is export := guint32;
our enum ESourceMailCompositionReplyStyleEnum is export (
  E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_DEFAULT         => 0,
  'E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_QUOTED',
  'E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_DO_NOT_QUOTE',
  'E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_ATTACH',
  'E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_OUTLOOK'
);

constant ESourceWeatherUnits is export := guint32;
our enum ESourceWeatherUnitsEnum is export (
  E_SOURCE_WEATHER_UNITS_FAHRENHEIT => 0,
  'E_SOURCE_WEATHER_UNITS_CENTIGRADE',
  'E_SOURCE_WEATHER_UNITS_KELVIN'
);

constant EThreeState is export := guint32;
our enum EThreeStateEnum is export (
  E_THREE_STATE_OFF          => 0,
  'E_THREE_STATE_ON',
  'E_THREE_STATE_INCONSISTENT'
);

constant ETimeParseStatus is export := guint32;
our enum ETimeParseStatusEnum is export <
  E_TIME_PARSE_OK
  E_TIME_PARSE_NONE
  E_TIME_PARSE_INVALID
>;

constant ETrustPromptResponse is export := gint32;
our enum ETrustPromptResponseEnum is export (
  E_TRUST_PROMPT_RESPONSE_UNKNOWN            => -1,
  E_TRUST_PROMPT_RESPONSE_REJECT             =>  0,
  E_TRUST_PROMPT_RESPONSE_ACCEPT             =>  1,
  E_TRUST_PROMPT_RESPONSE_ACCEPT_TEMPORARILY =>  2,
  E_TRUST_PROMPT_RESPONSE_REJECT_TEMPORARILY =>  3,
);

constant EWebDAVACEFlag is export := guint32;
our enum EWebDAVACEFlagEnum is export (
  E_WEBDAV_ACE_FLAG_UNKNOWN   =>      0,
  E_WEBDAV_ACE_FLAG_GRANT     => 1 +< 0,
  E_WEBDAV_ACE_FLAG_DENY      => 1 +< 1,
  E_WEBDAV_ACE_FLAG_INVERT    => 1 +< 2,
  E_WEBDAV_ACE_FLAG_PROTECTED => 1 +< 3,
  E_WEBDAV_ACE_FLAG_INHERITED => 1 +< 4,
);

constant EWebDAVACEPrincipalKind is export := guint32;
our enum EWebDAVACEPrincipalKindEnum is export (
  E_WEBDAV_ACE_PRINCIPAL_UNKNOWN         => 0,
  'E_WEBDAV_ACE_PRINCIPAL_HREF',
  'E_WEBDAV_ACE_PRINCIPAL_ALL',
  'E_WEBDAV_ACE_PRINCIPAL_AUTHENTICATED',
  'E_WEBDAV_ACE_PRINCIPAL_UNAUTHENTICATED',
  'E_WEBDAV_ACE_PRINCIPAL_PROPERTY',
  'E_WEBDAV_ACE_PRINCIPAL_SELF',
  'E_WEBDAV_ACE_PRINCIPAL_OWNER'
);

constant EWebDAVACLRestrictions is export := guint32;
our enum EWebDAVACLRestrictionsEnum is export (
  E_WEBDAV_ACL_RESTRICTION_NONE               =>      0,
  E_WEBDAV_ACL_RESTRICTION_GRANT_ONLY         => 1 +< 0,
  E_WEBDAV_ACL_RESTRICTION_NO_INVERT          => 1 +< 1,
  E_WEBDAV_ACL_RESTRICTION_DENY_BEFORE_GRANT  => 1 +< 2,
  E_WEBDAV_ACL_RESTRICTION_REQUIRED_PRINCIPAL => 1 +< 3,
);

constant EWebDAVResourceSupports is export := guint32;
our enum EWebDAVResourceSupportsEnum is export (
  E_WEBDAV_RESOURCE_SUPPORTS_NONE         =>                                       0,
  E_WEBDAV_RESOURCE_SUPPORTS_CONTACTS     =>                                  1 +< 0,
  E_WEBDAV_RESOURCE_SUPPORTS_EVENTS       =>                                  1 +< 1,
  E_WEBDAV_RESOURCE_SUPPORTS_MEMOS        =>                                  1 +< 2,
  E_WEBDAV_RESOURCE_SUPPORTS_TASKS        =>                                  1 +< 3,
  E_WEBDAV_RESOURCE_SUPPORTS_FREEBUSY     =>                                  1 +< 4,
  E_WEBDAV_RESOURCE_SUPPORTS_TIMEZONE     =>                                  1 +< 5,
  E_WEBDAV_RESOURCE_SUPPORTS_WEBDAV_NOTES =>                                  1 +< 6,
  E_WEBDAV_RESOURCE_SUPPORTS_LAST         =>                                  1 +< 6
);

constant EWebDAVDiscoverSupports is export := guint32;
our enum EWebDAVDiscoverSupportsEnum is export (
  E_WEBDAV_DISCOVER_SUPPORTS_NONE                   =>                        E_WEBDAV_RESOURCE_SUPPORTS_NONE,
  E_WEBDAV_DISCOVER_SUPPORTS_CONTACTS               =>                    E_WEBDAV_RESOURCE_SUPPORTS_CONTACTS,
  E_WEBDAV_DISCOVER_SUPPORTS_EVENTS                 =>                      E_WEBDAV_RESOURCE_SUPPORTS_EVENTS,
  E_WEBDAV_DISCOVER_SUPPORTS_MEMOS                  =>                       E_WEBDAV_RESOURCE_SUPPORTS_MEMOS,
  E_WEBDAV_DISCOVER_SUPPORTS_TASKS                  =>                       E_WEBDAV_RESOURCE_SUPPORTS_TASKS,
  E_WEBDAV_DISCOVER_SUPPORTS_WEBDAV_NOTES           =>                E_WEBDAV_RESOURCE_SUPPORTS_WEBDAV_NOTES,
  E_WEBDAV_DISCOVER_SUPPORTS_CALENDAR_AUTO_SCHEDULE =>                   E_WEBDAV_RESOURCE_SUPPORTS_LAST +< 1,
  E_WEBDAV_DISCOVER_SUPPORTS_SUBSCRIBED_ICALENDAR   =>          ( E_WEBDAV_RESOURCE_SUPPORTS_LAST +< 1 ) +< 1,
);

constant EWebDAVLockScope is export := guint32;
our enum EWebDAVLockScopeEnum is export <
  E_WEBDAV_LOCK_EXCLUSIVE
  E_WEBDAV_LOCK_SHARED
>;

constant EWebDAVPrivilegeHint is export := guint32;
our enum EWebDAVPrivilegeHintEnum is export (
  E_WEBDAV_PRIVILEGE_HINT_UNKNOWN                         => 0,
  'E_WEBDAV_PRIVILEGE_HINT_READ',
  'E_WEBDAV_PRIVILEGE_HINT_WRITE',
  'E_WEBDAV_PRIVILEGE_HINT_WRITE_PROPERTIES',
  'E_WEBDAV_PRIVILEGE_HINT_WRITE_CONTENT',
  'E_WEBDAV_PRIVILEGE_HINT_UNLOCK',
  'E_WEBDAV_PRIVILEGE_HINT_READ_ACL',
  'E_WEBDAV_PRIVILEGE_HINT_WRITE_ACL',
  'E_WEBDAV_PRIVILEGE_HINT_READ_CURRENT_USER_PRIVILEGE_SET',
  'E_WEBDAV_PRIVILEGE_HINT_BIND',
  'E_WEBDAV_PRIVILEGE_HINT_UNBIND',
  'E_WEBDAV_PRIVILEGE_HINT_ALL',
  'E_WEBDAV_PRIVILEGE_HINT_CALDAV_READ_FREE_BUSY'
);

constant EWebDAVPrivilegeKind is export := guint32;
our enum EWebDAVPrivilegeKindEnum is export (
  E_WEBDAV_PRIVILEGE_KIND_UNKNOWN   => 0,
  'E_WEBDAV_PRIVILEGE_KIND_ABSTRACT',
  'E_WEBDAV_PRIVILEGE_KIND_AGGREGATE',
  'E_WEBDAV_PRIVILEGE_KIND_COMMON'
);

constant EWebDAVPropertyChangeKind is export := guint32;
our enum EWebDAVPropertyChangeKindEnum is export <
  E_WEBDAV_PROPERTY_SET
  E_WEBDAV_PROPERTY_REMOVE
>;

constant EWebDAVResourceKind is export := guint32;
our enum EWebDAVResourceKindEnum is export <
  E_WEBDAV_RESOURCE_KIND_UNKNOWN
  E_WEBDAV_RESOURCE_KIND_ADDRESSBOOK
  E_WEBDAV_RESOURCE_KIND_CALENDAR
  E_WEBDAV_RESOURCE_KIND_PRINCIPAL
  E_WEBDAV_RESOURCE_KIND_COLLECTION
  E_WEBDAV_RESOURCE_KIND_RESOURCE
  E_WEBDAV_RESOURCE_KIND_SUBSCRIBED_ICALENDAR
  E_WEBDAV_RESOURCE_KIND_WEBDAV_NOTES
>;

constant EXmlHashStatus is export := guint32;
our enum EXmlHashStatusEnum is export <
  E_XMLHASH_STATUS_SAME
  E_XMLHASH_STATUS_DIFFERENT
  E_XMLHASH_STATUS_NOT_FOUND
>;

constant EXmlHashType is export := guint32;
our enum EXmlHashTypeEnum is export <
  E_XML_HASH_TYPE_OBJECT_UID
  E_XML_HASH_TYPE_PROPERTY
>;

constant camel_search_flags_t is export := guint32;
our enum camel_search_flags_tEnum is export (
  CAMEL_SEARCH_MATCH_START   => 1 +< 0,
  CAMEL_SEARCH_MATCH_END     => 1 +< 1,
  CAMEL_SEARCH_MATCH_REGEX   => 1 +< 2,
  CAMEL_SEARCH_MATCH_ICASE   => 1 +< 3,
  CAMEL_SEARCH_MATCH_NEWLINE => 1 +< 4,
);

constant camel_search_match_t is export := guint32;
our enum camel_search_match_tEnum is export <
  CAMEL_SEARCH_MATCH_EXACT
  CAMEL_SEARCH_MATCH_CONTAINS
  CAMEL_SEARCH_MATCH_WORD
  CAMEL_SEARCH_MATCH_STARTS
  CAMEL_SEARCH_MATCH_ENDS
  CAMEL_SEARCH_MATCH_SOUNDEX
>;

constant camel_search_t is export := guint32;
our enum camel_search_tEnum is export <
  CAMEL_SEARCH_TYPE_ASIS
  CAMEL_SEARCH_TYPE_ENCODED
  CAMEL_SEARCH_TYPE_ADDRESS
  CAMEL_SEARCH_TYPE_ADDRESS_ENCODED
  CAMEL_SEARCH_TYPE_MLIST
>;

constant camel_search_word_t is export := guint32;
our enum camel_search_word_tEnum is export (
  CAMEL_SEARCH_WORD_SIMPLE  => 1,
  CAMEL_SEARCH_WORD_COMPLEX => 2,
  CAMEL_SEARCH_WORD_8BIT    => 4,
);

constant EBookChangeType is export := guint32;
our enum EBookChangeTypeEnum is export <
  E_BOOK_CHANGE_CARD_ADDED
  E_BOOK_CHANGE_CARD_DELETED
  E_BOOK_CHANGE_CARD_MODIFIED
>;

constant EBookClientError is export := guint32;
our enum EBookClientErrorEnum is export <
  E_BOOK_CLIENT_ERROR_NO_SUCH_BOOK
  E_BOOK_CLIENT_ERROR_CONTACT_NOT_FOUND
  E_BOOK_CLIENT_ERROR_CONTACT_ID_ALREADY_EXISTS
  E_BOOK_CLIENT_ERROR_NO_SUCH_SOURCE
  E_BOOK_CLIENT_ERROR_NO_SPACE
>;

constant EBookClientViewFlags is export := guint32;
our enum EBookClientViewFlagsEnum is export (
  E_BOOK_CLIENT_VIEW_FLAGS_NONE           =>        0,
  E_BOOK_CLIENT_VIEW_FLAGS_NOTIFY_INITIAL => (1 +< 0),
);

constant EBookCursorOrigin is export := guint32;
our enum EBookCursorOriginEnum is export <
  E_BOOK_CURSOR_ORIGIN_CURRENT
  E_BOOK_CURSOR_ORIGIN_BEGIN
  E_BOOK_CURSOR_ORIGIN_END
>;

constant EbSqlCursorOrigin is export := guint32;
our enum EbSqlCursorOriginEnum is export <
  EBSQL_CURSOR_ORIGIN_CURRENT
  EBSQL_CURSOR_ORIGIN_BEGIN
  EBSQL_CURSOR_ORIGIN_END
>;

constant EBookCursorSortType is export := guint32;
our enum EBookCursorSortTypeEnum is export (
  E_BOOK_CURSOR_SORT_ASCENDING  => 0,
  'E_BOOK_CURSOR_SORT_DESCENDING'
);

constant EBookCursorStepFlags is export := guint32;
our enum EBookCursorStepFlagsEnum is export (
  E_BOOK_CURSOR_STEP_MOVE  => (1 +< 0),
  E_BOOK_CURSOR_STEP_FETCH => (1 +< 1),
);

constant EbSqlChangeType is export := guint32;
our enum EbSqlChangeTypeEnum is export <
  EBSQL_CHANGE_CONTACT_ADDED
  EBSQL_CHANGE_LOCALE_CHANGED
  EBSQL_CHANGE_LAST
>;

constant EbSqlCursorStepFlags is export := guint32;
our enum EbSqlCursorStepFlagsEnum is export (
  EBSQL_CURSOR_STEP_MOVE  => (1 +< 0),
  EBSQL_CURSOR_STEP_FETCH => (1 +< 1),
);

constant EbSqlUnlockAction is export := guint32;
enum  EbSqlUnlockActionEnum is export <
  EBSQL_UNLOCK_NONE
  EBSQL_UNLOCK_COMMIT
  EBSQL_UNLOCK_ROLLBACK
>;

constant EBookIndexType is export := guint32;
our enum EBookIndexTypeEnum is export (
  E_BOOK_INDEX_PREFIX   => 0,
  'E_BOOK_INDEX_SUFFIX',
  'E_BOOK_INDEX_PHONE',
  'E_BOOK_INDEX_SORT_KEY'
);

constant EBookOperationFlags is export := guint32;
our enum EBookOperationFlagsEnum is export (
  E_BOOK_OPERATION_FLAG_NONE                 =>        0,
  E_BOOK_OPERATION_FLAG_CONFLICT_FAIL        => (1 +< 0),
  E_BOOK_OPERATION_FLAG_CONFLICT_USE_NEWER   => (1 +< 1),
  E_BOOK_OPERATION_FLAG_CONFLICT_KEEP_SERVER => (1 +< 2),
  E_BOOK_OPERATION_FLAG_CONFLICT_KEEP_LOCAL  =>        0,
  E_BOOK_OPERATION_FLAG_CONFLICT_WRITE_COPY  => (1 +< 3),
);

constant EBookQueryTest is export := guint32;
our enum EBookQueryTestEnum is export (
  E_BOOK_QUERY_IS                           => 0,
  'E_BOOK_QUERY_CONTAINS',
  'E_BOOK_QUERY_BEGINS_WITH',
  'E_BOOK_QUERY_ENDS_WITH',
  'E_BOOK_QUERY_EQUALS_PHONE_NUMBER',
  'E_BOOK_QUERY_EQUALS_NATIONAL_PHONE_NUMBER',
  'E_BOOK_QUERY_EQUALS_SHORT_PHONE_NUMBER',
  'E_BOOK_QUERY_REGEX_NORMAL',
  'E_BOOK_QUERY_REGEX_RAW',
  'E_BOOK_QUERY_LAST'
);

constant EBookViewStatus is export := guint32;
our enum EBookViewStatusEnum is export <
  E_BOOK_VIEW_STATUS_OK
  E_BOOK_VIEW_STATUS_TIME_LIMIT_EXCEEDED
  E_BOOK_VIEW_STATUS_SIZE_LIMIT_EXCEEDED
  E_BOOK_VIEW_ERROR_INVALID_QUERY
  E_BOOK_VIEW_ERROR_QUERY_REFUSED
  E_BOOK_VIEW_ERROR_OTHER_ERROR
>;

constant EContactPhotoType is export := guint32;
our enum EContactPhotoTypeEnum is export <
  E_CONTACT_PHOTO_TYPE_INLINED
  E_CONTACT_PHOTO_TYPE_URI
>;

constant EPhoneNumberCountrySource is export := guint32;
our enum EPhoneNumberCountrySourceEnum is export (
  E_PHONE_NUMBER_COUNTRY_FROM_FQTN    =>  1,
  E_PHONE_NUMBER_COUNTRY_FROM_IDD     =>  5,
  E_PHONE_NUMBER_COUNTRY_FROM_DEFAULT => 20,
);

constant EPhoneNumberError is export := guint32;
our enum EPhoneNumberErrorEnum is export <
  E_PHONE_NUMBER_ERROR_NOT_IMPLEMENTED
  E_PHONE_NUMBER_ERROR_UNKNOWN
  E_PHONE_NUMBER_ERROR_NOT_A_NUMBER
  E_PHONE_NUMBER_ERROR_INVALID_COUNTRY_CODE
  E_PHONE_NUMBER_ERROR_TOO_SHORT_AFTER_IDD
  E_PHONE_NUMBER_ERROR_TOO_SHORT
  E_PHONE_NUMBER_ERROR_TOO_LONG
>;

constant EPhoneNumberFormat is export := guint32;
our enum EPhoneNumberFormatEnum is export <
  E_PHONE_NUMBER_FORMAT_E164
  E_PHONE_NUMBER_FORMAT_INTERNATIONAL
  E_PHONE_NUMBER_FORMAT_NATIONAL
  E_PHONE_NUMBER_FORMAT_RFC3966
>;

constant EPhoneNumberMatch is export := guint32;
our enum EPhoneNumberMatchEnum is export (
  'E_PHONE_NUMBER_MATCH_NONE',
  'E_PHONE_NUMBER_MATCH_EXACT',
  E_PHONE_NUMBER_MATCH_NATIONAL => 1024,
  E_PHONE_NUMBER_MATCH_SHORT    => 2048,
);

constant EVCardFormat is export := guint32;
our enum EVCardFormatEnum is export <
  EVC_FORMAT_VCARD_21
  EVC_FORMAT_VCARD_30
>;

constant EContactField is export := guint32;
our enum EContactFieldEnum is export (
  E_CONTACT_UID => 1,
  'E_CONTACT_FILE_AS',
  'E_CONTACT_BOOK_UID',
  'E_CONTACT_FULL_NAME',
  'E_CONTACT_GIVEN_NAME',
  'E_CONTACT_FAMILY_NAME',
  'E_CONTACT_NICKNAME',
  'E_CONTACT_EMAIL_1',
  'E_CONTACT_EMAIL_2',
  'E_CONTACT_EMAIL_3',
  'E_CONTACT_EMAIL_4',
  'E_CONTACT_MAILER',
  'E_CONTACT_ADDRESS_LABEL_HOME',
  'E_CONTACT_ADDRESS_LABEL_WORK',
  'E_CONTACT_ADDRESS_LABEL_OTHER',
  'E_CONTACT_PHONE_ASSISTANT',
  'E_CONTACT_PHONE_BUSINESS',
  'E_CONTACT_PHONE_BUSINESS_2',
  'E_CONTACT_PHONE_BUSINESS_FAX',
  'E_CONTACT_PHONE_CALLBACK',
  'E_CONTACT_PHONE_CAR',
  'E_CONTACT_PHONE_COMPANY',
  'E_CONTACT_PHONE_HOME',
  'E_CONTACT_PHONE_HOME_2',
  'E_CONTACT_PHONE_HOME_FAX',
  'E_CONTACT_PHONE_ISDN',
  'E_CONTACT_PHONE_MOBILE',
  'E_CONTACT_PHONE_OTHER',
  'E_CONTACT_PHONE_OTHER_FAX',
  'E_CONTACT_PHONE_PAGER',
  'E_CONTACT_PHONE_PRIMARY',
  'E_CONTACT_PHONE_RADIO',
  'E_CONTACT_PHONE_TELEX',
  'E_CONTACT_PHONE_TTYTDD',
  'E_CONTACT_ORG',
  'E_CONTACT_ORG_UNIT',
  'E_CONTACT_OFFICE',
  'E_CONTACT_TITLE',
  'E_CONTACT_ROLE',
  'E_CONTACT_MANAGER',
  'E_CONTACT_ASSISTANT',
  'E_CONTACT_HOMEPAGE_URL',
  'E_CONTACT_BLOG_URL',
  'E_CONTACT_CATEGORIES',
  'E_CONTACT_CALENDAR_URI',
  'E_CONTACT_FREEBUSY_URL',
  'E_CONTACT_ICS_CALENDAR',
  'E_CONTACT_VIDEO_URL',
  'E_CONTACT_SPOUSE',
  'E_CONTACT_NOTE',
  'E_CONTACT_IM_AIM_HOME_1',
  'E_CONTACT_IM_AIM_HOME_2',
  'E_CONTACT_IM_AIM_HOME_3',
  'E_CONTACT_IM_AIM_WORK_1',
  'E_CONTACT_IM_AIM_WORK_2',
  'E_CONTACT_IM_AIM_WORK_3',
  'E_CONTACT_IM_GROUPWISE_HOME_1',
  'E_CONTACT_IM_GROUPWISE_HOME_2',
  'E_CONTACT_IM_GROUPWISE_HOME_3',
  'E_CONTACT_IM_GROUPWISE_WORK_1',
  'E_CONTACT_IM_GROUPWISE_WORK_2',
  'E_CONTACT_IM_GROUPWISE_WORK_3',
  'E_CONTACT_IM_JABBER_HOME_1',
  'E_CONTACT_IM_JABBER_HOME_2',
  'E_CONTACT_IM_JABBER_HOME_3',
  'E_CONTACT_IM_JABBER_WORK_1',
  'E_CONTACT_IM_JABBER_WORK_2',
  'E_CONTACT_IM_JABBER_WORK_3',
  'E_CONTACT_IM_YAHOO_HOME_1',
  'E_CONTACT_IM_YAHOO_HOME_2',
  'E_CONTACT_IM_YAHOO_HOME_3',
  'E_CONTACT_IM_YAHOO_WORK_1',
  'E_CONTACT_IM_YAHOO_WORK_2',
  'E_CONTACT_IM_YAHOO_WORK_3',
  'E_CONTACT_IM_MSN_HOME_1',
  'E_CONTACT_IM_MSN_HOME_2',
  'E_CONTACT_IM_MSN_HOME_3',
  'E_CONTACT_IM_MSN_WORK_1',
  'E_CONTACT_IM_MSN_WORK_2',
  'E_CONTACT_IM_MSN_WORK_3',
  'E_CONTACT_IM_ICQ_HOME_1',
  'E_CONTACT_IM_ICQ_HOME_2',
  'E_CONTACT_IM_ICQ_HOME_3',
  'E_CONTACT_IM_ICQ_WORK_1',
  'E_CONTACT_IM_ICQ_WORK_2',
  'E_CONTACT_IM_ICQ_WORK_3',
  'E_CONTACT_REV',
  'E_CONTACT_NAME_OR_ORG',
  'E_CONTACT_ADDRESS',
  'E_CONTACT_ADDRESS_HOME',
  'E_CONTACT_ADDRESS_WORK',
  'E_CONTACT_ADDRESS_OTHER',
  'E_CONTACT_CATEGORY_LIST',
  'E_CONTACT_PHOTO',
  'E_CONTACT_LOGO',
  'E_CONTACT_NAME',
  'E_CONTACT_EMAIL',
  'E_CONTACT_IM_AIM',
  'E_CONTACT_IM_GROUPWISE',
  'E_CONTACT_IM_JABBER',
  'E_CONTACT_IM_YAHOO',
  'E_CONTACT_IM_MSN',
  'E_CONTACT_IM_ICQ',
  'E_CONTACT_WANTS_HTML',
  'E_CONTACT_IS_LIST',
  'E_CONTACT_LIST_SHOW_ADDRESSES',
  'E_CONTACT_BIRTH_DATE',
  'E_CONTACT_ANNIVERSARY',
  'E_CONTACT_X509_CERT',
  'E_CONTACT_PGP_CERT',
  'E_CONTACT_IM_GADUGADU_HOME_1',
  'E_CONTACT_IM_GADUGADU_HOME_2',
  'E_CONTACT_IM_GADUGADU_HOME_3',
  'E_CONTACT_IM_GADUGADU_WORK_1',
  'E_CONTACT_IM_GADUGADU_WORK_2',
  'E_CONTACT_IM_GADUGADU_WORK_3',
  'E_CONTACT_IM_GADUGADU',
  'E_CONTACT_GEO',
  'E_CONTACT_TEL',
  'E_CONTACT_IM_SKYPE_HOME_1',
  'E_CONTACT_IM_SKYPE_HOME_2',
  'E_CONTACT_IM_SKYPE_HOME_3',
  'E_CONTACT_IM_SKYPE_WORK_1',
  'E_CONTACT_IM_SKYPE_WORK_2',
  'E_CONTACT_IM_SKYPE_WORK_3',
  'E_CONTACT_IM_SKYPE',
  'E_CONTACT_SIP',
  'E_CONTACT_IM_GOOGLE_TALK_HOME_1',
  'E_CONTACT_IM_GOOGLE_TALK_HOME_2',
  'E_CONTACT_IM_GOOGLE_TALK_HOME_3',
  'E_CONTACT_IM_GOOGLE_TALK_WORK_1',
  'E_CONTACT_IM_GOOGLE_TALK_WORK_2',
  'E_CONTACT_IM_GOOGLE_TALK_WORK_3',
  'E_CONTACT_IM_GOOGLE_TALK',
  'E_CONTACT_IM_TWITTER',
  'E_CONTACT_FIELD_LAST',
  E_CONTACT_FIELD_FIRST        =>  1, #= E_CONTACT_UID,
  E_CONTACT_LAST_SIMPLE_STRING => 88, #= E_CONTACT_NAME_OR_ORG,
  E_CONTACT_FIRST_PHONE_ID     => 16, #= E_CONTACT_PHONE_ASSISTANT,
  E_CONTACT_LAST_PHONE_ID      => 34, #= E_CONTACT_PHONE_TTYTDD,
  E_CONTACT_FIRST_EMAIL_ID     =>  8, #= E_CONTACT_EMAIL_1,
  E_CONTACT_LAST_EMAIL_ID      => 11, #= E_CONTACT_EMAIL_4,
  E_CONTACT_FIRST_ADDRESS_ID   => 90, #= E_CONTACT_ADDRESS_HOME,
  E_CONTACT_LAST_ADDRESS_ID    => 92, #= E_CONTACT_ADDRESS_OTHER,
  E_CONTACT_FIRST_LABEL_ID     => 13, #= E_CONTACT_ADDRESS_LABEL_HOME,
  E_CONTACT_LAST_LABEL_ID      => 15  #= E_CONTACT_ADDRESS_LABEL_OTHER
);

### /usr/include/evolution-data-server/ebackend/e-backend-enums.h

constant EAuthenticationSessionResult is export := guint32;
our enum EAuthenticationSessionResultEnum is export <
  E_AUTHENTICATION_SESSION_ERROR
  E_AUTHENTICATION_SESSION_SUCCESS
  E_AUTHENTICATION_SESSION_DISMISSED
>;

constant EDBusServerExitCode is export := guint32;
our enum EDBusServerExitCodeEnum is export <
  E_DBUS_SERVER_EXIT_NONE
  E_DBUS_SERVER_EXIT_NORMAL
  E_DBUS_SERVER_EXIT_RELOAD
>;

constant EOfflineState is export := gint32;
our enum EOfflineStateEnum is export (
  E_OFFLINE_STATE_UNKNOWN          => -1,
  'E_OFFLINE_STATE_SYNCED',
  'E_OFFLINE_STATE_LOCALLY_CREATED',
  'E_OFFLINE_STATE_LOCALLY_MODIFIED',
  'E_OFFLINE_STATE_LOCALLY_DELETED'
);

constant ESourcePermissionFlags is export := guint32;
our enum ESourcePermissionFlagsEnum is export (
  E_SOURCE_PERMISSION_NONE      =>      0,
  E_SOURCE_PERMISSION_WRITABLE  => 1 +< 0,
  E_SOURCE_PERMISSION_REMOVABLE => 1 +< 1,
);

# /usr/src/evolution-data-server-3.38.1/tests/test-server-utils/e-test-server-utils.h

constant ETestServerFlags is export := guint32;
our enum ETestServerFlagsEnum is export (
  E_TEST_SERVER_KEEP_WORK_DIRECTORY => (1 +< 0),
);

constant ETestServiceType is export := guint32;
our enum ETestServiceTypeEnum is export (
  E_TEST_SERVER_NONE                    => 0,
  'E_TEST_SERVER_ADDRESS_BOOK',
  'E_TEST_SERVER_DIRECT_ADDRESS_BOOK',
  'E_TEST_SERVER_CALENDAR',
  'E_TEST_SERVER_DEPRECATED_ADDRESS_BOOK'
);
