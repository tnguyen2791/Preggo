class PregnancyInfo {
  /* The context of this is to create a model for when the information from the database comes back */

  final String date;
  final int epochduedate;
  final String weight;

  PregnancyInfo(
      {this.date = 'Nodate',
      this.epochduedate = 000000,
      this.weight = 'noweight'});
}
