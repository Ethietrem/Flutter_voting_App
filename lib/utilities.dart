import 'package:flutter/cupertino.dart';
import 'package:flutter_vote_app/state/authentication.dart';
import 'package:provider/provider.dart';

/*
        przekierowanie dla usera do okna logowania / okna home
        funkcje pracują w tle (funkcje microtask)
 */

void gotoHomeScreen(BuildContext context){
  Future.microtask(() {
    if(Provider.of<AuthenticationState>(context, listen: false).authStatus == kAuthSuccess){
      Navigator.pushReplacementNamed(context, "/home");
    }
  });
}

void gotoLoginScreen(BuildContext context, AuthenticationState authState){
  Future.microtask(() {
    if(Provider.of<AuthenticationState>(context, listen: false).authStatus == null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}