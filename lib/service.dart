import 'package:flutter_vote_app/models/vote.dart';
import 'package:uuid/uuid.dart';

//zaimportowanie listy z dostępnymi głosowaniami
List<Vote> getVoteList(){
  List<Vote> voteList = List<Vote>();

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