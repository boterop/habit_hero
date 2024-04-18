import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();
  final secretKey = dotenv.env['STORAGE_SECRET'];

  save({required String key, required String text}) async =>
      await storage.write(key: '$secretKey-$key', value: text);

  load(String key) async => storage.read(key: '$secretKey-$key');
}
