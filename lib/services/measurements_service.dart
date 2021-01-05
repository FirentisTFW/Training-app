import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/models/measurement.dart';

class MeasurementsService {
  static MeasurementType getMeasurementType(String type) {
    switch (type) {
      case 'Bodyweight':
        return MeasurementType.Bodyweight;
      case 'Bodyfat':
        return MeasurementType.Bodyfat;
      default:
        return MeasurementType.BodyMeasurement;
    }
  }

  static Bodypart getBodypart(String bodypart) {
    switch (bodypart) {
      case 'Arm':
        return Bodypart.Arm;
      case 'Calf':
        return Bodypart.Calf;
      case 'Chest':
        return Bodypart.Chest;
      case 'Forearm':
        return Bodypart.Forearm;
      case 'Hips':
        return Bodypart.Hips;
      case 'Thigh':
        return Bodypart.Thigh;
      case 'Waist':
        return Bodypart.Waist;
      default:
        return Bodypart.Waist;
    }
  }
}
