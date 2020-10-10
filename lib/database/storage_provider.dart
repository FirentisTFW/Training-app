import 'package:path_provider/path_provider.dart';

class StorageProvider {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
