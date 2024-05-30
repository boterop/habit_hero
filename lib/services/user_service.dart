import 'package:habit_hero/services/storage_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  static UserService get instance => _instance;

  String _id = "";
  String _token = "";

  UserService._internal();

  String get id => _id;
  String get session => _token;

  void updateSession(String token) {
    _token = token;
    StorageService().save(key: "token", content: token);
  }

  void updateId(String id) {
    _id = id;
    StorageService().save(key: "id", content: id);
  }

  void updateUser(String id, String token) {
    updateId(id);
    updateSession(token);
  }
}
