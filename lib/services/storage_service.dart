import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static const String measurementsFileName = 'measurements.json';
  static const String clientsFileName = 'clients.json';
  static const String workoutProgramsFileName = 'workout_programs.json';
  static const String workoutsFileName = 'workouts.json';
}
