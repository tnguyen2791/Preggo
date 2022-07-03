class PregnancyInfo {
  /* The context of this is to create a model for when the information from the database comes back */

  final String date;
  final String duedate;
  final String weight;

  PregnancyInfo(
      {this.date = 'Nodate', this.duedate = 'noDD', this.weight = 'noweight'});
}
