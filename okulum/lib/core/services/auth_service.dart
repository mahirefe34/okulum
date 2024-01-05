import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okulum/core/services/i_auth_service.dart';

import '../../product/utils/showSnackbar.dart';

class AuthService /* implements IAuthService */ {
  final FirebaseAuth _authInstance;
  AuthService(this._authInstance);
  /* MyAppUser _getUser(User? user){
	return MyAppUser(uid:user!.uid,email:user.email!);
	} */

  //? STATE PERSISTENCE STREAM
  // @override
  // Stream<MyAppUser?> get onAuthStateChanged => _authInstance.authStateChanges().map(_getUser);

  //! STATE PERSISTENCE STREAM
  User get user => _authInstance.currentUser!;

  @override
  Stream<User?> get onAuthStateChanges => _authInstance.authStateChanges();

  // //? EMAIL SIGN UP
  // @override
  // Future<MyAppUser> createUserWithEmailAndPassword({required String email, required String password}) async{
  // 	var _tempUser = await _authInstance.createUserWithEmailAndPassword(email:email,password:password);
  // 	return convertUser(_tempUser);
  // }

  //! EMAIL SIGN UP
  @override
  Future<void> createUserWithEmailAndPasswordAndContext({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerificationWithContext(context: context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        showSnackBar(context, e.message!);
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  // //? EMAIL LOGIN
  // @override
  // Future<MyAppUser> signInWithEmailAndPassword({required String email, required String password}){
  // 	var _tempUser = await _authInstance.signInWithEmailAndPassword(email:email,password:password);
  // 	return convertUser(_tempUser);
  // }

  //! EMAIL LOGIN
  @override
  Future<void> signInWithEmailAndPasswordAndContext({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      /* if (!user.emailVerified) {
        await sendEmailVerificationWithContext(context: context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      } */
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.message == "Given String is empty or null") {
        showSnackBar(context, "Email ve Şifre Boş Geçilemez");
      } else if (e.message ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        showSnackBar(context, "Email veya Şifre Yanlış");
      } else {
        showSnackBar(context, e.message!); // Display error message

      } // Displaying the error message
    }
  }

  //! EMAIL VERIFICATION
  @override
  Future<void> sendEmailVerificationWithContext(
      {required BuildContext context}) async {
    try {
      _authInstance.currentUser!.sendEmailVerification();
      showSnackBar(context,
          'Email doğrulaması gönderildi!\n Lütfen giriş için doğrulamayı yapınız!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message

    }
  }

  // //? SIGN OUT
  // @override
  // Future<void> signOut() async{
  // 	await _authInstance.signOut();
  // }

  //! SIGN OUT
  @override
  Future<void> signOutWithContext({required BuildContext context}) async {
    try {
      await _authInstance.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  //! DELETE ACCOUNT
  @override
  Future<void> deleteAccountWithContext({required BuildContext context}) async {
    try {
      await _authInstance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}

// // PHONE SIGN IN
// Future<void> phoneSignIn(
//   BuildContext context,
//   String phoneNumber,
// ) async {
//   TextEditingController codeController = TextEditingController();
//   if (kIsWeb) {
//     // !!! Works only on web !!!
//     ConfirmationResult result =
//         await _auth.signInWithPhoneNumber(phoneNumber);
//
//     // Diplay Dialog Box To accept OTP
//     showOTPDialog(
//       codeController: codeController,
//       context: context,
//       onPressed: () async {
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: result.verificationId,
//           smsCode: codeController.text.trim(),
//         );
//
//         await _auth.signInWithCredential(credential);
//         Navigator.of(context).pop(); // Remove the dialog box
//       },
//     );
//   } else {
//     // FOR ANDROID, IOS
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       //  Automatic handling of the SMS code
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // !!! works only on android !!!
//         await _auth.signInWithCredential(credential);
//       },
//       // Displays a message when verification fails
//       verificationFailed: (e) {
//         showSnackBar(context, e.message!);
//       },
//       // Displays a dialog box when OTP is sent
//       codeSent: ((String verificationId, int? resendToken) async {
//         showOTPDialog(
//           codeController: codeController,
//           context: context,
//           onPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: verificationId,
//               smsCode: codeController.text.trim(),
//             );
//
//             // !!! Works only on Android, iOS !!!
//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop(); // Remove the dialog box
//           },
//         );
//       }),
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//       },
//     );
//   }
// }
