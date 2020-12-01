import 'package:flutter/material.dart';
import 'package:flutter_vote_app/models/vote.dart';
import 'package:flutter_vote_app/services/service.dart';

class VoteState with ChangeNotifier{
  List<Vote> _voteList = List<Vote>();
  Vote _activeVote;
  String _selectedOptionInActiveVote;

  //załadowanie listy dostępnych głosowań pobranych uprzednio w service.dart, async jest potrzebne do providera w home Future.microtask
  void loadVoteList(BuildContext context/*wczesniej tez tu nic nie bylo*/) async{
    /*
    to jest do stalych danych teraz jest zmiana jak baza danych
    _voteList = getVoteList();
    notifyListeners();*/
    getVoteListFromFirebase(context);
  }

  //wyczyszczenie stanu dla zmiennych
  void clearState(){
    _voteList = null;
    _activeVote = null;
    _selectedOptionInActiveVote = null;
  }

  //notacja ze strzałką (=>) odpowiada wywołaniu jednolinijkowej funkcji
  //pobranie tu wartości i dodanie do prywatnych
  List <Vote> get voteList => _voteList;
  set voteList(newValue) {
    _voteList = newValue;
    notifyListeners();
  }
  Vote get activeVote => _activeVote;
  String get selectedOptionInActiveVote => _selectedOptionInActiveVote;

  set activeVote(newValue){
    _activeVote = newValue;
    notifyListeners();
  }

  set selectedOptionInActiveVote(String newValue){
    _selectedOptionInActiveVote = newValue;
    notifyListeners();
  }
}