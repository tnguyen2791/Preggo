class UserUID {
  final String uid;

  UserUID({
    this.uid = '00000',
  });
}

class UserData {
  //this has a lot of the same properties as the pregnancy information, HOWEVER, the pregnancyinfo does not have the UID

  //likely we can just use the pregnancy model again

  final bool agreement;
  final int epochduedate;
  final int weight;
  final String email;
  final String weighpref;
  final List weightlist;
  final int heightininches;

  UserData(
      {this.agreement = false,
      this.epochduedate = 1656882023322,
      this.weight = 100,
      required this.weightlist,
      this.heightininches = 55,
      this.email = 'random@email.com',
      this.weighpref = 'Regular'});
}
