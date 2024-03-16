import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:ubereatsresturants/constants/constant.dart';
import 'package:ubereatsresturants/controller/provider/authProvider/authProvider.dart';
import 'package:ubereatsresturants/view/authScreens/mobileLoginScreen.dart';
import 'package:ubereatsresturants/view/authScreens/otpScreen.dart';
import 'package:ubereatsresturants/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:ubereatsresturants/view/resturantRegistrationScreen/resturantRegistrationScreen.dart';
import 'package:ubereatsresturants/view/signInLogicScreen/signInLogicScreen.dart';

class MobileAuthServices {
  static checkResturantRegistration({required BuildContext context}) async {
    bool resturantIsRegistered = false;
    try {
      await firestore
          .collection('Resturant')
          .where('restaurantUID', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0
            ? resturantIsRegistered = true
            : resturantIsRegistered = false;
        log('Resturant is Registered=$resturantIsRegistered');
        if (resturantIsRegistered) {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavigationBarUberEats(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const ResturantRegistrationScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const mobileLoginScreen()),
          (route) => false);
      return false;
    }
    checkResturantRegistration(context: context);
    return true;
  }

  static receiveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (PhoneAuthCredential credentials) {
          log(credentials.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
          throw Exception(exception);
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerficationID(verificationID);
          Navigator.push(
            context,
            PageTransition(
              child: const OTPScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verficationID) {},
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        PageTransition(
          child: const SignInLogicScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static signOut(BuildContext context) {
    auth.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const SignInLogicScreen();
    }), (route) => false);
  }
}
