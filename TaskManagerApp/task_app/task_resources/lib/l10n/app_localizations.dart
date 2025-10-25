import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ru'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @applogo.
  ///
  /// In en, this message translates to:
  /// **'Your best helper in timely task organization!'**
  String get applogo;

  /// No description provided for @appsubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in to create and synchronize your daily tasks across devices'**
  String get appsubtitle;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signin;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @emaillogin.
  ///
  /// In en, this message translates to:
  /// **'E-mail or login'**
  String get emaillogin;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmpassword;

  /// No description provided for @firstname.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstname;

  /// No description provided for @lastname.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastname;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @donthaveaccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have the account?'**
  String get donthaveaccount;

  /// No description provided for @clicktosignup.
  ///
  /// In en, this message translates to:
  /// **'Click to sign up'**
  String get clicktosignup;

  /// No description provided for @enterdetails.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to create your free account'**
  String get enterdetails;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @dailytasks.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Tasks'**
  String get dailytasks;

  /// No description provided for @newtask.
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get newtask;

  /// No description provided for @inprogress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inprogress;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Task paused'**
  String get paused;

  /// No description provided for @wontdo.
  ///
  /// In en, this message translates to:
  /// **'Won\'t do task'**
  String get wontdo;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @edittask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get edittask;

  /// No description provided for @selectedday.
  ///
  /// In en, this message translates to:
  /// **'Selected day'**
  String get selectedday;

  /// No description provided for @startfrom.
  ///
  /// In en, this message translates to:
  /// **'Start from'**
  String get startfrom;

  /// No description provided for @endat.
  ///
  /// In en, this message translates to:
  /// **'End at'**
  String get endat;

  /// No description provided for @taskdescription.
  ///
  /// In en, this message translates to:
  /// **'Task description'**
  String get taskdescription;

  /// No description provided for @createtask.
  ///
  /// In en, this message translates to:
  /// **'Create task'**
  String get createtask;

  /// No description provided for @updatetask.
  ///
  /// In en, this message translates to:
  /// **'Update task'**
  String get updatetask;

  /// No description provided for @taskdetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskdetails;

  /// No description provided for @taskstatus.
  ///
  /// In en, this message translates to:
  /// **'Task status'**
  String get taskstatus;

  /// No description provided for @markinprogress.
  ///
  /// In en, this message translates to:
  /// **'Mark as In progress'**
  String get markinprogress;

  /// No description provided for @markpaused.
  ///
  /// In en, this message translates to:
  /// **'Mark as Paused'**
  String get markpaused;

  /// No description provided for @markwontdo.
  ///
  /// In en, this message translates to:
  /// **'Mark as Won\'t do'**
  String get markwontdo;

  /// No description provided for @markdone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Done'**
  String get markdone;

  /// No description provided for @deletethis.
  ///
  /// In en, this message translates to:
  /// **'Delete this task'**
  String get deletethis;

  /// No description provided for @apierrorheader.
  ///
  /// In en, this message translates to:
  /// **'Unable to do requested action at this moment'**
  String get apierrorheader;

  /// No description provided for @apierror.
  ///
  /// In en, this message translates to:
  /// **'There was an error during your request. Please check your Internet connection and try again later'**
  String get apierror;

  /// No description provided for @passworderrorheader.
  ///
  /// In en, this message translates to:
  /// **'Passwords does not match'**
  String get passworderrorheader;

  /// No description provided for @passworderror.
  ///
  /// In en, this message translates to:
  /// **'Please check your input details and try again'**
  String get passworderror;

  /// No description provided for @texterrorheader.
  ///
  /// In en, this message translates to:
  /// **'One or more fields are empty'**
  String get texterrorheader;

  /// No description provided for @texterror.
  ///
  /// In en, this message translates to:
  /// **'Please check your input details and try again'**
  String get texterror;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @confirmdelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this task?'**
  String get confirmdelete;

  /// No description provided for @confirmlogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmlogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
