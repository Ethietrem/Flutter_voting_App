//model systemu głosowania - unikatowy id, nazwa głosowania, opcje wyboru glosow
class Vote {
  String voteId;
  String voteTitle;
  List<Map<String, int>> options;

  Vote({this.voteId, this.voteTitle, this.options});
}