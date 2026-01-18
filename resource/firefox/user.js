// security & privacy
user_pref("dom.security.https_only_mode", true); // HTTPS Only
user_pref("media.peerconnection.enabled", false); // WebRTC
user_pref("privacy.donottrackheader.enabled", false); // DNT header (Deprecated)
user_pref("privacy.globalprivacycontrol.enabled", true); // Global Privacy Control

// display
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // userChrome.css & userContent.css
user_pref("browser.download.autohideButton", false); // Automatically hide download button
user_pref("browser.ml.chat.page", false); // AI chat功能下边巨丑的按钮

// autofill
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("signon.autofillForms", false);
