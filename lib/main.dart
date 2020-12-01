import 'package:flutter/material.dart';//podstawowa paczka do fluttera
import 'package:flutter_vote_app/state/authentication.dart';//import paczki do sanu authenticate
import 'package:flutter_vote_app/utilities.dart';//import dla przejścia między home scrren a login screen
import 'package:provider/provider.dart';//import dla providera
import 'package:flutter_vote_app/screens/home.dart';//import dla okna home
import 'package:flutter_vote_app/screens/launch.dart';//import dla okna launch
import 'package:flutter_vote_app/screens/result.dart';//import dla okna result
import 'package:flutter_vote_app/state/vote.dart';//import dla stanu głosowania

void main() {
  runApp(VotingApp());
}

//stateless widget bezstanowy nie zmienia się w skutek interakcji z userem
//stateful widget potrafiący się zmienić w momencie interakcji z userem
class VotingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //obsługa stanu przez providera
      providers: [
        ChangeNotifierProvider(
          //builder: (_) => VoteState(), create: (BuildContext context) {  },
          create: (context) => VoteState(),
        ),
        ChangeNotifierProvider(
          //builder: (_) => AuthenticationState(), create: (BuildContext context) {  },
          create: (context) => AuthenticationState(),
        )
      ],
      child: MaterialApp(//tu budowana jest struktura apki, wstawiane są okna utworzone w screensach
        initialRoute: "/",
        routes: {

          //metoda Scaffold zapewnia ogólny układ widoku (górny pasek = appBar i reszta = body, poniżej
          "/": (context) => Scaffold(
            body: DecoratedBox(
              position: DecorationPosition.background,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('img.jpg'),
              fit: BoxFit.cover),
              ),
              child: Launch(),
            )
          ),

          "/home": (context) => Scaffold(
            appBar: AppBar(
              title: Text("My Flutter Vote App"),
              actions: [
                getActions(context),
              ],
            ),
            body: Home(),
          ),

          "/result": (context) => Scaffold(
            appBar: AppBar(
              title: Text("Result"),
              leading: IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.lightGreenAccent,
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, "/home");
                  },
              ),
              actions: [
                getActions(context),
              ],
            ),
            body: Result(),
          )
        }
      ),
    );
  }

  //dodanie wylogowania w prawym gornym orgu
  PopupMenuButton getActions(BuildContext context){
    return PopupMenuButton<int>(
        itemBuilder: (context) =>[
          PopupMenuItem(
            value: 1,
            child: Text("Logout"),
          )
        ],
        onSelected: (value){
          if(value == 1){
            Provider.of<AuthenticationState>(context, listen: false).logout();
            gotoLoginScreen(context);
          }
        },
    );
  }
}