import 'package:flutter_vote_app/state/vote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vote_app/service.dart';
import 'package:flutter_vote_app/models/vote.dart';
import 'package:provider/provider.dart';

class VoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Vote activeVote = Provider.of<VoteState>(context).activeVote;
    List<String> options = List<String>();
    for (Map<String, int> option in activeVote.options){
      option.forEach((title, value) {
        options.add(title);
      });
    }
    return Column(
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text(
              activeVote.voteTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        ),
        for (String option in options)
          Card(
            child: InkWell(//to jest do obsłużenia kliknięcia w daną odpwiedź
              onTap: (){
                Provider.of<VoteState>(context).selectedOptionInActiveVote = option;
              },
              child: IntrinsicHeight(//to do tych kolorowych paskó przy odpowiedziach żęby na całą wysokosc
                child: Row(//to do ropoczecia tego kolorowego paska od góry każej odpowiedzi
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(//kontener z kolorowym pakiem przy odpowiedzi
                      constraints: BoxConstraints(minHeight: 60),
                      width: 8,
                      color: Colors.green,
                    ),
                    Expanded(//to jest dodane eby zawijać tekst możliwych odpowiedzi jak sa za szerokie
                      child: Container(//to jest do kontenera z tekstem odpowiedzi
                        padding: EdgeInsets.only(left: 10, right: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          option,
                          maxLines: 5,
                          style: TextStyle(fontSize: 22),
                        ),
                        color: Provider.of<VoteState>(context).
                        selectedOptionInActiveVote == option
                            ? Colors.green : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
