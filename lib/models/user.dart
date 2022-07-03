class UserModeling {
  final String uid;

  UserModeling({this.uid = '00000'});
}

class UserData {

  //this has a lot of the same properties as the pregnancy information, HOWEVER, the pregnancyinfo does not have the UID

  //likely we can just use the pregnancy model again

  final String uid;
  final String date;
  final String duedate;
  final String weight;

  UserData(
      {this.uid = '00000',
      this.date = 'noDate',
      this.duedate = 'noDD',
      this.weight = 'noweight'});


}
