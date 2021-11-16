import 'package:facebook_login/errorHandler.dart';
import 'package:facebook_login/view/Home.dart';
import 'package:facebook_login/view/HomeTwo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthServices{

  //to check previous loggin
  handeAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          //if user has not logout  return home Screen
          return HomeTwo();
        }else{
          //if user has log out return login screen
          return Home();
        }
      },
    );
  }

  //signout
  signOut(){
    FirebaseAuth.instance.signOut();
  }
  //signin

  signIn(String email,String password,context){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((val){
      print("signed In");
    }).catchError((e){
      ErrorHandler().errorDialog(context, e);

    });

  }

  //newuser
  Singup(String email,String password){
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

  }

  //resetpass
  ResetPassword(String email){
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  }

  //facebook singin

  fbSignin()async{

    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential=FacebookAuthProvider.credential(accessToken!.token);
        final result=await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data
        final profile = await
        fb.getUserProfile();
       // print('Hello, ${profile!.name}! You ID: ${profile!.userId}');

        // Get user profile image url
        final imageUrl = await
        fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await
        fb.getUserEmail();
        // But user can decline permission
        if (email != null)
          print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }


}