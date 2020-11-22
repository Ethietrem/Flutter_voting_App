import 'package:flutter/material.dart';//podstawowa paczka do fluttera
import 'package:flutter_vote_app/const.dart';//paczka z moimi stałymi

/*
        główne okno przy odpaleniu apki, tu jest logowanie
 */

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              AppName,
              style: TextStyle(
                fontSize: 37.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
          ),

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
              color: Colors.amberAccent,
              child: Text(
                "Zaloguj się",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black
                ),
              ),
              onPressed: () => signIn(context),
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
              color: Colors.amberAccent,
              child: Text(
                "Bez logowania",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black
                ),
              ),
              onPressed: () => signIn(context),
            ),
          )
        ],
      ),
    );
  }


  //funkcja do obsługi przycisku logowania, powoduje podmianę na nowe okno -> /home
  void signIn(BuildContext context){
    Navigator.pushReplacementNamed(context, "/home");
  }
}
