import 'package:flutter/material.dart';
import 'package:flutter_vote_app/services/authentication.dart';
import 'package:flutter_vote_app/services/constants.dart';

//stałe zmienne komunikaty
const String kAuthError = "error";
const String kAuthSuccess = "success";
const String kAuthLoading = "loading";
const String kAuthSignInGoogle = "google";
const String kAuthSignInAnonymous = "anonymous";

class AuthenticationState with ChangeNotifier{
  String _authStatus;
  String _username;
  String _uid;

  String get authStatus => _authStatus;//TODO tu jest problem daje null
  String get username => _username;
  String get uid => _uid;

  //konstruktor klasy
  AuthenticationState(){
    clearState();

    //to jest z services/authentic wywoływana zawsze podczas logowania, przepisanie danych
    onAuthenticationChange((user){
      if(user != null){
        _authStatus = kAuthSuccess;
        _username = user[kUsername];
        _uid = user[kUID];
      }else{
        clearState();
      }
      notifyListeners();
    });
  }

  //sprawdzenie autentyczności konta
  void checkAuthentication() async {
    _authStatus = kAuthLoading;

    if(await isUserSignedIn()){
      _authStatus = kAuthSuccess;
    }else{
      _authStatus = kAuthError;
    }

    Map<String, String>user = await getCurrentUser();
    _username = user != null ? user[kUsername] : '';
    _uid = user != null ? user[kUID] : '';

    notifyListeners();
  }

  //czyszczenie stanu
  void clearState(){
    _authStatus = null;
    _username = null;
    _uid = null;
  }

  //logowanie google / anonimo
  void login({String serviceName}){
    if(serviceName == kAuthSignInGoogle){
      signInWithGoogle();
    }else if(serviceName == kAuthSignInAnonymous){
      signInAnonymously();
    }
  }

  //wylogowanie
  void logout(){
    clearState();
    signOut();
  }
}