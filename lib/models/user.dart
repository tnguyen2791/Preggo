class UserUID {
  final String uid;

  UserUID({this.uid = '00000'});
}

class UserData {
  //this has a lot of the same properties as the pregnancy information, HOWEVER, the pregnancyinfo does not have the UID

  //likely we can just use the pregnancy model again

  final String uid;
  final String date;
  final int epochduedate;
  final String weight;

  UserData(
      {this.uid = '00000',
      this.date = 'noDate',
      this.epochduedate = 1656882023322,
      this.weight = 'noweight'});
}
