import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static final _secretKey = dotenv.env['STORAGE_SECRET'];

  static save({required String key, required String content}) async =>
      _storage.write(key: '$_secretKey-$key', value: content);

  static load(String key) async => _storage.read(key: '$_secretKey-$key');
}
