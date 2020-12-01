import 'package:flutter/material.dart';
import 'package:flutter_vote_app/state/authentication.dart';
import 'package:flutter_vote_app/utilities.dart';
import 'package:provider/provider.dart';//podstawowa paczka do fluttera

/*
        główne okno przy odpaleniu apki, tu jest logowanie
 */

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(
      builder: (builder, authState, child){
        gotoHomeScreen(context);
        return Container(//tu definiujemy poszczególne cechy danego screena
          width: 400,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //widget z napisem tytulu apki
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Text(
                  "My Flutter Vote App",
                  style: TextStyle(
                    fontSize: 37.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              //to wysleiwtla stan ladowania jesli jesze dane nie sa pobrane
              if(authState.authStatus == kAuthLoading)
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 12.0),
                ),

              //tu jezeli status nie ma wartosci to przechodzi do wyboru logowania
              if(authState.authStatus == null || authState.authStatus == kAuthError)
                Container(
                  child: Column(
                    children: [

                      //widget z przyciekiem zaloguj
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 240.0),
                        child: MaterialButton(
                          height: 60.0,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.green,
                          child: Text(
                            "Zaloguj się",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black
                            ),
                          ),
                          onPressed: () => signIn(context, kAuthSignInGoogle),
                        ),
                      ),

                      //widget z przyciekiem bez logowania
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          height: 60.0,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.green,
                          child: Text(
                            "Bez logowania",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black
                            ),
                          ),
                          onPressed: () => signIn(context, kAuthSignInAnonymous),
                        ),
                      )
                    ],
                  ),
                ),

              //tu sprawdzane sa błedy i wyswietlany error
              if(authState.authStatus == kAuthError)
                Text(
                  "Error...",
                  style: TextStyle(fontSize: 12.0, color: Colors.cyan),
                )
            ],
          ),
        );
      },
    );
  }


  //funkcja do obsługi przycisku logowania, powoduje podmianę na nowe okno -> /home
  void signIn(BuildContext context, String service){
    Provider.of<AuthenticationState>(context, listen: true).login(serviceName: service);
  }
}
