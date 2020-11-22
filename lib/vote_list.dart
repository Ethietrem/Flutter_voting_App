import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vote_app/state/vote.dart';
import 'package:flutter_vote_app/models/vote.dart';

//przygotowanie pod wyświetlenie dostępnych ankiet do głosowania,
//wyświetlenie w kolumnie pobranych wartości z voteList i ich pokazanie w kolumnie z odpowiednimi ustawieniami fontów itd
class VoteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String activeVoidId = Provider.of<VoteState>(context).activeVote?.voteId ?? '';

    return Consumer<VoteState>(
      builder: (context, voteState, child){
        return Column(
          children: [
            for (Vote vote in voteState.voteList)
              Card(
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      vote.voteTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: activeVoidId == vote.voteId ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  //dodanie warunków na wybranie danego głosowania, zmiana stanu na aktywne głosowanie
                  selected: activeVoidId == vote.voteId ? true : false,
                  onTap: (){
                    Provider.of<VoteState>(context).activeVote = vote;
                  },
                ),
                //zmiana koloru jeżeli kliknięte to podświetla na inny kolor
                color: activeVoidId == vote.voteId ? Colors.amber : Colors.blueAccent,
              )
          ],
        );
      }
    );
  }
}
