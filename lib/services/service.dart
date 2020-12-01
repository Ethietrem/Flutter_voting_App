import 'package:flutter_vote_app/models/vote.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';//paczka do komunikacji z baza danych firebase
import 'package:provider/provider.dart';
import 'package:flutter_vote_app/state/vote.dart';

//zaimportowanie listy z dostępnymi głosowaniami
List<Vote> getVoteList(){
  List<Vote> voteList = List<Vote>();


  //na razie wpisywanie glosowania z reki
  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: "Best mobile Frameworks?",
      options: [
        {"Flutter": 70},
        {"React Native": 10},
        {"Xamarin": 1},
      ],
    ),
  );

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: "The smallest country in the world?",
      options: [
        {"San Marino": 0},
        {"Monaco": 20},
        {"Vatican City": 75},
      ],
    ),
  );

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: "The fastest car in the worls?",
      options: [
        {"SSC Tuatara": 40},
        {"Bugatti Chiron Super Sport 300+": 45},
        {"Hannessey Venom F5": 10},
      ],
    ),
  );

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: "The most popular mobile phone company?",
      options: [
        {"Samsung": 33},
        {"Apple": 27},
        {"Xiaomi": 30},
      ],
    ),
  );

  return voteList;
}


//tu do pobierania danych z bazy

const String kVotes = "votes";
const String kTitle = "title";

void getVoteListFromFirebase(BuildContext context) async {
  Firestore.instance.collection(kVotes).getDocuments().then((snapshot){//znajdz i pobierz kolekcję / baze o nazwie kVotes, getDocuments to pobierz wsio z tej konkretnej bazy
    List<Vote> voteList = List<Vote>();

    //tu przechodzimy po każdym dokumencie z bazy danych kVotes i bierzemy pojedynczy dokument
    snapshot.documents.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));//tu jest pobranie zawarości dokumentu, fukcja niżej
    });

    //przepisanie glosow przez providera
    Provider.of<VoteState>(context, listen: false).voteList = voteList; // .voteList jest w state/vote
  });
}

//funkcja do zawartości dokumentu z bazy danych kVotes, korzystamy tu też z models/vote i tu jest mock do vote
Vote mapFirestoreDocToVote(document){
  Vote vote = Vote(voteId: document.documentID);//każde glosowanie ma swoje ID
  List<Map<String, int>> options = List();//tu jest lista opcji dla danego losowania
  document.data.forEach((key, value) {
    if(key == kTitle){//sprawdzenie tytulu
      vote.voteTitle = value;
    }
    else{
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

//tu wywołujemy baze, dokument i konkretne pole zwiekszamy
void markVote(String voteId, String option) async{
  Firestore.instance.collection(kVotes).document(voteId).updateData({
    option: FieldValue.increment(1),
  });
}

//tu przeslanie zaznaczonego pola
void retrieveMarkedVoteFirestore({String voteId, BuildContext context}) {
  //otrzymanie zaktualizowanego dokumentu z servera
  Firestore.instance.collection(kVotes).document(voteId).get().then((document) {
    Provider
        .of<VoteState>(context, listen: false)
        .activeVote =
        mapFirestoreDocToVote(document);
  });
}