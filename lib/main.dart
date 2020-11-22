import 'package:flutter/material.dart';//podstawowa paczka do fluttera
import 'package:provider/provider.dart';//import dla providera
import 'package:flutter_vote_app/const.dart';//import stałych do projektu
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
          builder: (_) => VoteState(),
        )
      ],
      child: MaterialApp(//tu budowana jest struktura apki, wstawiane są okna utworzone w screensach
        initialRoute: "/",
        routes: {

          //metoda Scaffold zapewnia ogólny układ widoku (górny pasek = appBar i reszta = body, poniżej
          "/": (context) => Scaffold(
            body: Launch(),
          ),

          "/home": (context) => Scaffold(
            appBar: AppBar(
              title: Text(AppName),
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
                  },),
            ),
            body: Result(),
          )
        }
      ),
    );
  }
}