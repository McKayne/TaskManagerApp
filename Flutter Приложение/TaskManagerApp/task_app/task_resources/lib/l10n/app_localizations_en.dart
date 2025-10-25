// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome';

  @override
  String get applogo => 'Your best helper in timely task organization!';

  @override
  String get appsubtitle =>
      'Sign-in to create and synchronize your daily tasks across devices';

  @override
  String get signin => 'Sign In';

  @override
  String get signup => 'Sign Up';

  @override
  String get emaillogin => 'E-mail or login';

  @override
  String get password => 'Password';

  @override
  String get confirmpassword => 'Confirm Password';

  @override
  String get firstname => 'First Name';

  @override
  String get lastname => 'Last Name';

  @override
  String get logout => 'Log out';

  @override
  String get donthaveaccount => 'Don\'t have the account?';

  @override
  String get clicktosignup => 'Click to sign up';

  @override
  String get enterdetails => 'Enter your details to create your free account';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get dailytasks => 'Your Daily Tasks';

  @override
  String get newtask => 'New task';

  @override
  String get inprogress => 'In progress';

  @override
  String get paused => 'Task paused';

  @override
  String get wontdo => 'Won\'t do task';

  @override
  String get done => 'Done';

  @override
  String get deleted => 'Deleted';

  @override
  String get edittask => 'Edit Task';

  @override
  String get selectedday => 'Selected day';

  @override
  String get startfrom => 'Start from';

  @override
  String get endat => 'End at';

  @override
  String get taskdescription => 'Task description';

  @override
  String get createtask => 'Create task';

  @override
  String get updatetask => 'Update task';

  @override
  String get taskdetails => 'Task Details';

  @override
  String get taskstatus => 'Task status';

  @override
  String get markinprogress => 'Mark as In progress';

  @override
  String get markpaused => 'Mark as Paused';

  @override
  String get markwontdo => 'Mark as Won\'t do';

  @override
  String get markdone => 'Mark as Done';

  @override
  String get deletethis => 'Delete this task';

  @override
  String get apierrorheader => 'Unable to do requested action at this moment';

  @override
  String get apierror =>
      'There was an error during your request. Please check your Internet connection and try again later';

  @override
  String get passworderrorheader => 'Passwords does not match';

  @override
  String get passworderror => 'Please check your input details and try again';

  @override
  String get texterrorheader => 'One or more fields are empty';

  @override
  String get texterror => 'Please check your input details and try again';

  @override
  String get confirmation => 'Confirmation';

  @override
  String get confirmdelete => 'Are you sure you want to delete this task?';

  @override
  String get confirmlogout => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';
}
