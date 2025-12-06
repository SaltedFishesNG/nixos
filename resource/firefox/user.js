user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // userChrome.css & userContent.css
user_pref("dom.security.https_only_mode", true); // HTTPS Only
user_pref("privacy.donottrackheader.enabled", false); // DNT header (Deprecated)
user_pref("privacy.globalprivacycontrol.enabled", true); // Global Privacy Control

// language
user_pref("intl.locale.requested", "zh-TW,en-US");
user_pref("font.language.group", "zh-TW");
user_pref("intl.accept_languages", "zh-tw,zh,en-us,en");

// mozilla收集资料
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// autofill
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("signon.autofillForms", false);

// 数据同步
user_pref("services.sync.engine.forms", false);
user_pref("services.sync.engine.history", false);
user_pref("services.sync.engine.passwords", false);
user_pref("services.sync.engine.prefs.modified", false);

// 关闭浏览器时清除数据
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", false);
user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", false);
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown.cookies", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown.downloads", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown.history", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown.offlineApps", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown.sessions", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown_v2.formdata", true);
user_pref("services.sync.prefs.sync-seen.privacy.clearOnShutdown_v2.siteSettings", true);

// display
user_pref("browser.download.autohideButton", false); // 不自动隐藏下载按钮
user_pref("browser.ml.chat.page", false); // AI chat功能下边巨丑的按钮
user_pref("sidebar.revamp", true); //侧边栏
user_pref("sidebar.verticalTabs", true); //垂直标签页
user_pref("sidebar.main.tools", "aichat,syncedtabs,history,bookmarks"); //侧边栏工具
