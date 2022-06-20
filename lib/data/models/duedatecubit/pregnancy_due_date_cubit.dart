import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pregnancy_due_date_state.dart';


class PregnancyDueDateCubit extends Cubit<PregnancyDueDateState> {
  PregnancyDueDateCubit()
      : super(PregnancyDueDateState(dueDate: DateTime(2022, 6, 19)));
}
