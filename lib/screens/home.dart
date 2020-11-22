import 'package:flutter/material.dart';//podstawowa paczka do fluttera
import 'package:flutter_vote_app/vote_list.dart';
import 'package:flutter_vote_app/vote_widget.dart';
import 'package:provider/provider.dart';//paczka do providera
import 'package:flutter_vote_app/models/vote.dart';
import 'package:flutter_vote_app/state/vote.dart';

/*
                tu jest okno wyboru ankiety
 */

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentStep = 0;

  @override
  void initState(){
    super.initState();

    //ladowanie glosow - tu to async z state/vote
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //jest to klasa rozszerzająca do elem podrzednych typu wiersz kolumna elestyczny??? w celu wypełnienia dostępnego miejsca
          Expanded(
            //to widget ułatwiający tworzenie formularzy / listy elementów itp.
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              steps: [
                getStep(
                  title: "Choose",
                  //wywołanie z vote_list.dart
                  child: VoteListWidget(),
                  isActive: true,
                ),
                getStep(
                  title: "Vote",
                  child: VoteWidget(),
                  isActive: _currentStep == 1 ? true : false,
                ),
              ],

              //po kliknięciu w przycisk kontynuacji zmiana licznika na 1
              onStepContinue: (){
                if (_currentStep == 0){
                  if(step2Req()){
                    setState(() {
                      _currentStep = 1;
                    });
                  }
                  else{
                    showSnackBar(context, "Please select a vote first.");
                  }
                }
                else if(_currentStep == 1){
                  if(step3Req()){
                    Navigator.pushReplacementNamed(context, "/result");
                  }
                  else{
                    showSnackBar(context, "Please mark your vote!");
                  }
                }
              },

              //po kliknięciu w przycisk cancel zmiana licznika na 0
              onStepCancel: (){
                Provider.of<VoteState>(context).selectedOptionInActiveVote = null;
                if(_currentStep <= 0){
                  Provider.of<VoteState>(context).activeVote = null;
                }
                setState(() {
                  _currentStep = 0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  //warunek sprawdzający czy został wybrany jakiś zestaw do głosowania żeby zezwolić na dalsze kroki
  bool step2Req(){
    if (Provider.of<VoteState>(context).activeVote == null){
      return false;
    }
    return true;
  }

  //widget pokazujący wybor / glosowanie w pod navbarem w oknie home
  Step getStep({String title, Widget child, bool isActive = false}){
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  //do pokazania dynków na ekranie z komunikatem
  void showSnackBar(BuildContext context, String msg){
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          msg, style: TextStyle(fontSize: 22),
        ),
    ));
  }

  bool step3Req(){
    if (Provider.of<VoteState>(context).selectedOptionInActiveVote == null){
      return false;
    }
    return true;
  }
}