import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'prepregweightcubit_state.dart';

class PrepregweightCubit extends Cubit<PrepregnancyWeightState> {
  PrepregweightCubit()
      : super(PrepregnancyWeightState(prepregnancyweight: 0.0));
}
