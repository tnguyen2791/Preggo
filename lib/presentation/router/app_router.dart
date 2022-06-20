import 'package:flutter/material.dart';
import 'package:preggo/presentation/screens/all_screens.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Homepage.id:
        return MaterialPageRoute(builder: (_) => Homepage());
      case Diet.id:
        return MaterialPageRoute(builder: (_) => Diet());
      case ExerciseRegimen.id:
        return MaterialPageRoute(builder: (_) => ExerciseRegimen());
      case GrowthChart.id:
        return MaterialPageRoute(builder: (_) => GrowthChart());
      case Resources.id:
        return MaterialPageRoute(builder: (_) => Resources());
      case Settings.id:
        return MaterialPageRoute(builder: (_) => Settings());
      case WaterLog.id:
        return MaterialPageRoute(builder: (_) => WaterLog());
      case WeighIn.id:
        return MaterialPageRoute(builder: (_) => WeighIn());
      default:
        return MaterialPageRoute(builder: (_) => Homepage());
    }
  }
}
