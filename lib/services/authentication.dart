import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

/*
              funkcja jest w większoci ze strony google -> github przykładowe zastosowania
 */


//wyciagniecie danych usera
Map<String, String> exposeUser({@required kUsername, @required kUID}){
  return{
    kUsername: kUsername,
    kUID: kUID,
  };
}

//pobranie danych usera jesli jest zalogowany
Future<Map<String, String>> getCurrentUser() async{
  final FirebaseUser user = await _auth.currentUser as FirebaseUser;
  if(user != null){
    return exposeUser(kUsername: user.displayName, kUID: user.uid);
  }
  return null;
}

//sprawdzenie czy user jest zalogowany z sieci
Future<bool> isUserSignedIn() async{
  final FirebaseUser currentUser = await _auth.currentUser as FirebaseUser;
  return currentUser != null;
}

//sprawdzenie czy wylogowany, ewentualnie daj blad
void signOut(){
  try{
    _auth.signOut();
  }
  catch(error){
    print(error);
  }
}

//funkcja wywoływana przy logowaniu i wylogowaniu usera
void onAuthenticationChange(Function isLogin){
  _auth.onAuthStateChanged.listen((FirebaseUser user){
    if(user != null){
      isLogin(exposeUser(kUsername:user.displayName, kUID: user.uid));
    }
    else{
      isLogin(null);
    }
  });
}

//funkcja do logowania przez google
Future<Map<String, String>> signInWithGoogle() async{
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

  if(user != null){
    return exposeUser(kUsername: user.displayName, kUID: user.uid);
  }
  return null;
}

//funkcja do logowania jako user anonimowy
Future<Map<String, String>> signInAnonymously() async{
  final FirebaseUser user = (await _auth.signInAnonymously()).user;

  if (user != null){
    return exposeUser(kUsername: '', kUID: user.uid);
  }
  return null;
}