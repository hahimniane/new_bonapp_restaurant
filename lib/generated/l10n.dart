// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `CALL A BIKE`
  String get callBikeButton {
    return Intl.message(
      'CALL A BIKE',
      name: 'callBikeButton',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguageString {
    return Intl.message(
      'Select Language',
      name: 'selectLanguageString',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMeString {
    return Intl.message(
      'Remember me',
      name: 'rememberMeString',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonString {
    return Intl.message(
      'Login',
      name: 'loginButtonString',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccountString {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccountString',
      desc: '',
      args: [],
    );
  }

  /// `SingUp`
  String get signUpButtonString {
    return Intl.message(
      'SingUp',
      name: 'signUpButtonString',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Name`
  String get restaurantHintString {
    return Intl.message(
      'Restaurant Name',
      name: 'restaurantHintString',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant full address`
  String get restaurantFullAddressHintString {
    return Intl.message(
      'Restaurant full address',
      name: 'restaurantFullAddressHintString',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Foundation Date`
  String get restaurantFoundationDateString {
    return Intl.message(
      'Restaurant Foundation Date',
      name: 'restaurantFoundationDateString',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordHintString {
    return Intl.message(
      'password',
      name: 'passwordHintString',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordString {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordString',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPasswordString {
    return Intl.message(
      'confirm password',
      name: 'confirmPasswordString',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccountString {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccountString',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeIconLabel {
    return Intl.message(
      'Home',
      name: 'homeIconLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get orderIconLabel {
    return Intl.message(
      'Order',
      name: 'orderIconLabel',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menuIconLabel {
    return Intl.message(
      'Menu',
      name: 'menuIconLabel',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get supportIconLabel {
    return Intl.message(
      'Support',
      name: 'supportIconLabel',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get settingIconLabel {
    return Intl.message(
      'Setting',
      name: 'settingIconLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pending Orders`
  String get pendingOrderString {
    return Intl.message(
      'Pending Orders',
      name: 'pendingOrderString',
      desc: '',
      args: [],
    );
  }

  /// `Delivered Orders`
  String get deliveredOrderString {
    return Intl.message(
      'Delivered Orders',
      name: 'deliveredOrderString',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pendingString {
    return Intl.message(
      'Pending',
      name: 'pendingString',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get deliveredString {
    return Intl.message(
      'Delivered',
      name: 'deliveredString',
      desc: '',
      args: [],
    );
  }

  /// `How can we assist you?`
  String get assistString {
    return Intl.message(
      'How can we assist you?',
      name: 'assistString',
      desc: '',
      args: [],
    );
  }

  /// `Get help with a phone call`
  String get getHelpWithPhoneCallString {
    return Intl.message(
      'Get help with a phone call',
      name: 'getHelpWithPhoneCallString',
      desc: '',
      args: [],
    );
  }

  /// `Chat with a representative`
  String get chatWithRepresentativeString {
    return Intl.message(
      'Chat with a representative',
      name: 'chatWithRepresentativeString',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any orders yet`
  String get noOrdersAvailableString {
    return Intl.message(
      'You don\'t have any orders yet',
      name: 'noOrdersAvailableString',
      desc: '',
      args: [],
    );
  }

  /// `You don't have Deliveries Yet`
  String get noPastDeliveriesAvailableString {
    return Intl.message(
      'You don\'t have Deliveries Yet',
      name: 'noPastDeliveriesAvailableString',
      desc: '',
      args: [],
    );
  }

  /// `Please call the below number for support`
  String get numberToCallString {
    return Intl.message(
      'Please call the below number for support',
      name: 'numberToCallString',
      desc: '',
      args: [],
    );
  }

  /// `Call Bike for delivery`
  String get callBikeForDeliveryString {
    return Intl.message(
      'Call Bike for delivery',
      name: 'callBikeForDeliveryString',
      desc: '',
      args: [],
    );
  }

  /// `Decline Order`
  String get declineOrderString {
    return Intl.message(
      'Decline Order',
      name: 'declineOrderString',
      desc: '',
      args: [],
    );
  }

  /// `COMING ORDERS`
  String get incomingOrdersString {
    return Intl.message(
      'COMING ORDERS',
      name: 'incomingOrdersString',
      desc: '',
      args: [],
    );
  }

  /// `PENDING ORDERS`
  String get pendingOrdersString {
    return Intl.message(
      'PENDING ORDERS',
      name: 'pendingOrdersString',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERED ORDERS`
  String get deliveredOrders {
    return Intl.message(
      'DELIVERED ORDERS',
      name: 'deliveredOrders',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountString {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountString',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get areYouSureYouWantToDeleteAccountString {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'areYouSureYouWantToDeleteAccountString',
      desc: '',
      args: [],
    );
  }

  /// `YES,I'M SURE`
  String get yestImSureString {
    return Intl.message(
      'YES,I\'M SURE',
      name: 'yestImSureString',
      desc: '',
      args: [],
    );
  }

  /// `NO, DON'T DELETE`
  String get noDontDelete {
    return Intl.message(
      'NO, DON\'T DELETE',
      name: 'noDontDelete',
      desc: '',
      args: [],
    );
  }

  /// `Deleting your account is permanent and you'll be logged out immediately.`
  String get precautionString {
    return Intl.message(
      'Deleting your account is permanent and you\'ll be logged out immediately.',
      name: 'precautionString',
      desc: '',
      args: [],
    );
  }

  /// `Food Name`
  String get foodName {
    return Intl.message(
      'Food Name',
      name: 'foodName',
      desc: '',
      args: [],
    );
  }

  /// `Food Description`
  String get foodDescription {
    return Intl.message(
      'Food Description',
      name: 'foodDescription',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Enter Ingredient`
  String get enterIngredient {
    return Intl.message(
      'Enter Ingredient',
      name: 'enterIngredient',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOuntString {
    return Intl.message(
      'Log Out',
      name: 'logOuntString',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelString {
    return Intl.message(
      'Cancel',
      name: 'cancelString',
      desc: '',
      args: [],
    );
  }

  /// `How many orders will be delivered?`
  String get howManyOrdersToDeliver {
    return Intl.message(
      'How many orders will be delivered?',
      name: 'howManyOrdersToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Destinations:`
  String get destinationString {
    return Intl.message(
      'Destinations:',
      name: 'destinationString',
      desc: '',
      args: [],
    );
  }

  /// `Enter Destination`
  String get enterDestinationString {
    return Intl.message(
      'Enter Destination',
      name: 'enterDestinationString',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the empty fields`
  String get pleaseFillIntheDestinationString {
    return Intl.message(
      'Please fill in the empty fields',
      name: 'pleaseFillIntheDestinationString',
      desc: '',
      args: [],
    );
  }

  /// `Choose Photo`
  String get choosePhotoString {
    return Intl.message(
      'Choose Photo',
      name: 'choosePhotoString',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButtonString {
    return Intl.message(
      'Save',
      name: 'saveButtonString',
      desc: '',
      args: [],
    );
  }

  /// `Update Settings`
  String get updateSettingsString {
    return Intl.message(
      'Update Settings',
      name: 'updateSettingsString',
      desc: '',
      args: [],
    );
  }

  /// `Chat With a Customer Representative`
  String get getHelpWithaMessage {
    return Intl.message(
      'Chat With a Customer Representative',
      name: 'getHelpWithaMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Food average price:`
  String get chooseFoodAverageString {
    return Intl.message(
      'Choose Your Food average price:',
      name: 'chooseFoodAverageString',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Food Preparation averge time:`
  String get chooseFoodPreparationAverageTime {
    return Intl.message(
      'Choose Your Food Preparation averge time:',
      name: 'chooseFoodPreparationAverageTime',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextString {
    return Intl.message(
      'Next',
      name: 'nextString',
      desc: '',
      args: [],
    );
  }

  /// `Press and hold to delete`
  String get pressAndHoldString {
    return Intl.message(
      'Press and hold to delete',
      name: 'pressAndHoldString',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this menu?`
  String get areYouSureYouWantToDeleteMenuString {
    return Intl.message(
      'Are you sure you want to delete this menu?',
      name: 'areYouSureYouWantToDeleteMenuString',
      desc: '',
      args: [],
    );
  }

  /// `deletion of this menu is permanent and irreversible !`
  String get menuDeleteWarningString {
    return Intl.message(
      'deletion of this menu is permanent and irreversible !',
      name: 'menuDeleteWarningString',
      desc: '',
      args: [],
    );
  }

  /// `was successfully deleted`
  String get menuHasBeenDeletedString {
    return Intl.message(
      'was successfully deleted',
      name: 'menuHasBeenDeletedString',
      desc: '',
      args: [],
    );
  }

  /// `was successfully deactivated`
  String get menuHasBeenDeactivatedString {
    return Intl.message(
      'was successfully deactivated',
      name: 'menuHasBeenDeactivatedString',
      desc: '',
      args: [],
    );
  }

  /// `was successfully activated`
  String get menuHasBeenActivatedString {
    return Intl.message(
      'was successfully activated',
      name: 'menuHasBeenActivatedString',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activateString {
    return Intl.message(
      'Activate',
      name: 'activateString',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get DeactivateString {
    return Intl.message(
      'Deactivate',
      name: 'DeactivateString',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteString {
    return Intl.message(
      'Delete',
      name: 'deleteString',
      desc: '',
      args: [],
    );
  }

  /// `Please choose Your Community`
  String get chooseCommunity {
    return Intl.message(
      'Please choose Your Community',
      name: 'chooseCommunity',
      desc: '',
      args: [],
    );
  }

  /// `The total price is `
  String get theTotalPriceStrint {
    return Intl.message(
      'The total price is ',
      name: 'theTotalPriceStrint',
      desc: '',
      args: [],
    );
  }

  /// `Congrats you have successfully called a motorbike!`
  String get bikeIsOnItsWayString {
    return Intl.message(
      'Congrats you have successfully called a motorbike!',
      name: 'bikeIsOnItsWayString',
      desc: '',
      args: [],
    );
  }

  /// `A bike is Already on the way!`
  String get aBikeIsAlreadyOnTheWayString {
    return Intl.message(
      'A bike is Already on the way!',
      name: 'aBikeIsAlreadyOnTheWayString',
      desc: '',
      args: [],
    );
  }

  /// `Choisir le prix moyen`
  String get chooseAveragePriceString {
    return Intl.message(
      'Choisir le prix moyen',
      name: 'chooseAveragePriceString',
      desc: '',
      args: [],
    );
  }

  /// `Choose Average Price`
  String get chooseAveragePrice {
    return Intl.message(
      'Choose Average Price',
      name: 'chooseAveragePrice',
      desc: '',
      args: [],
    );
  }

  /// `Choose Average Time`
  String get chooseAverageTime {
    return Intl.message(
      'Choose Average Time',
      name: 'chooseAverageTime',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant full address`
  String get restaurantFullAddressString {
    return Intl.message(
      'Restaurant full address',
      name: 'restaurantFullAddressString',
      desc: '',
      args: [],
    );
  }

  /// `Email address is required`
  String get emailAddressIsRequired {
    return Intl.message(
      'Email address is required',
      name: 'emailAddressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `restaurant name is required`
  String get restaurantNameIsRequired {
    return Intl.message(
      'restaurant name is required',
      name: 'restaurantNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Community selection is required`
  String get communitySelectionIsRequired {
    return Intl.message(
      'Community selection is required',
      name: 'communitySelectionIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant full address is required`
  String get restaurantFullAddressIsRequired {
    return Intl.message(
      'Restaurant full address is required',
      name: 'restaurantFullAddressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneNumberIsRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneNumberIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm Password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Average Price is required`
  String get averagePriceIsRequired {
    return Intl.message(
      'Average Price is required',
      name: 'averagePriceIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Average Time is required`
  String get averageTimeIsRequired {
    return Intl.message(
      'Average Time is required',
      name: 'averageTimeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get continueString {
    return Intl.message(
      'continue',
      name: 'continueString',
      desc: '',
      args: [],
    );
  }

  /// `resend`
  String get resendString {
    return Intl.message(
      'resend',
      name: 'resendString',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get backString {
    return Intl.message(
      'back',
      name: 'backString',
      desc: '',
      args: [],
    );
  }

  /// `Your email has not been verified yet. check your inbox or click resend to receive another verification or click change email to enter another email`
  String get emailNotVerifiedWarningString {
    return Intl.message(
      'Your email has not been verified yet. check your inbox or click resend to receive another verification or click change email to enter another email',
      name: 'emailNotVerifiedWarningString',
      desc: '',
      args: [],
    );
  }

  /// `Change email`
  String get changeEmailString {
    return Intl.message(
      'Change email',
      name: 'changeEmailString',
      desc: '',
      args: [],
    );
  }

  /// `An  email has been sent to you`
  String get emailWasSentString {
    return Intl.message(
      'An  email has been sent to you',
      name: 'emailWasSentString',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
