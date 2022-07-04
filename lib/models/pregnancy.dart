class PregnancyInfo {
  /* The context of this is to create a model for when the information from the database comes back */

  final int date;
  final int epochduedate;
  final int weight;
  final String email;

  PregnancyInfo(
      {this.date = 1656882023322,
      this.epochduedate = 000000,
      this.weight = 100,
      this.email = 'random@email.com'});
}
