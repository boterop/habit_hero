import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final _secretKey = dotenv.env['STORAGE_SECRET'];

  save({required String key, required String content}) async =>
      _storage.write(key: '$_secretKey-$key', value: content);

  load(String key) async => _storage.read(key: '$_secretKey-$key');

  clean(String key) async => _storage.delete(key: '$_secretKey-$key');

  cleanAll() async => _storage.deleteAll();
}
