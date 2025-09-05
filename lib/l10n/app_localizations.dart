import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Baran'**
  String get appTitle;

  /// No description provided for @menuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuTooltip;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @langFa.
  ///
  /// In en, this message translates to:
  /// **'فارسی'**
  String get langFa;

  /// No description provided for @langEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEn;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutTitle;

  /// No description provided for @aboutInfo.
  ///
  /// In en, this message translates to:
  /// **'Baran Company specializes in supplying, processing, and exporting Iranian pistachios and saffron.\n\nRelying on experience and technical knowledge in the production and export chain of agricultural products, our mission is based on delivering high-quality, reliable products aligned with international standards.\n\nBaran’s products are sourced from carefully selected farms and orchards in Iran and are processed and packaged under strict supervision using scientific methods and quality control systems.\n\nThis guarantees that our customers in both domestic and international markets receive authentic, healthy products tailored to modern demands.\n\nAt Baran, we remain committed to transparency, responsibility, and quality, always striving to be a trusted business partner for our clients and associates.'**
  String get aboutInfo;

  /// No description provided for @homeInfo.
  ///
  /// In en, this message translates to:
  /// **'With pride and commitment, we begin our journey into the fragrant and flavorful world of authentic Iranian pistachios and saffron.\n\nFrom today onwards, this is your home to discover:\n\n✓ Authenticity and Freshness\n\n✓ Unparalleled Aroma and Color'**
  String get homeInfo;

  /// No description provided for @workWithUs.
  ///
  /// In en, this message translates to:
  /// **'Work With Us'**
  String get workWithUs;

  /// No description provided for @workWithUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If you are active in any of the following areas, we would be honored to collaborate and partner with you:'**
  String get workWithUsSubtitle;

  /// No description provided for @workWithUsList.
  ///
  /// In en, this message translates to:
  /// **'Exporters of pistachios and saffron\nInternational buyers and overseas trade representatives\nBulk consumers (factories, packaging companies, confectionery and chocolate workshops, food industries)\nNut shop owners and retail stores\nChain stores and large supermarkets\nRestaurants, hotels, and cafés\nDistributors and wholesale suppliers of nuts'**
  String get workWithUsList;

  /// No description provided for @sideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Specialized export and sales of premium pistachios and saffron'**
  String get sideSubtitle;

  /// No description provided for @menuHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menuHome;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get menuAbout;

  /// No description provided for @menuWorkWithUs.
  ///
  /// In en, this message translates to:
  /// **'Work With Us'**
  String get menuWorkWithUs;

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get contactCall;

  /// No description provided for @contactInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get contactInstagram;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmail;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactAddress;

  /// No description provided for @emailSubjectWebsite.
  ///
  /// In en, this message translates to:
  /// **'Contact from website'**
  String get emailSubjectWebsite;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
