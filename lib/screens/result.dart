import 'package:flutter/material.dart';//podstawowa paczka do fluttera
import 'package:charts_flutter/flutter.dart' as charts;//paczka do obsługi wykresow
import 'package:flutter_vote_app/services/service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vote_app/models/vote.dart';
import 'package:flutter_vote_app/state/vote.dart';

/*
            ekran wyswietlajacy ekran wynikow - wykres
 */

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {//tu jest wbudowanie okna wykresu
    retrieveActiveVoteData(context);
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: createChart(context),
    );
  }

  //tworzenie wykresu
  Widget createChart(BuildContext context){
    return Consumer<VoteState>(
      builder: (context, voteState, child){
        return charts.BarChart(
          retrieveVoteResult(context),
          animate: true,
        );
      },
    );
  }

  //pobranie wynikow glosowania i  przerobienie pod wysietlenie
  List<charts.Series<VoteData, String>> retrieveVoteResult(BuildContext context){
    Vote activeVote = Provider.of<VoteState>(context, listen: false).activeVote;

    List<VoteData> data = List<VoteData>();
    for(var option in activeVote.options){
      option.forEach((key, value) {
        data.add(VoteData(key, value));
      });
    }
    return [
      charts.Series<VoteData, String>(
        id: "VoteResult",
        colorFn: (_, pos){
          if(pos % 2 == 0){
            return charts.MaterialPalette.green.shadeDefault;
          }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data,
        )
    ];
  }
  //otrzymanie danych po oddaniu glosu i aktualizacji w bazie
  void retrieveActiveVoteData(BuildContext context) {
    final voteId = Provider.of<VoteState>(context, listen: false)
        .activeVote?.voteId;
    retrieveMarkedVoteFirestore(voteId: voteId, context: context);
  }
}

//tu jest struktura glosowania
class VoteData{
  final String option;
  final int total;
  VoteData(this.option, this.total);
}