import 'package:smart_spend_ai/api/api_constants.dart';
import 'package:smart_spend_ai/backend/api/api_service.dart';
import 'package:smart_spend_ai/backend/storage/token_storage.dart';

class AuthService {
  static Future<bool> register(
    String name,

    String email,

    String password,
  ) async {
    final response = await ApiService.post(ApiConstants.register, {
      "name": name,

      "email": email,

      "password": password,
    });

    return response["success"] ?? false;
  }

  static Future<bool> login(String email, String password) async {
    final response = await ApiService.post(ApiConstants.login, {
      "email": email,

      "password": password,
    });

    if (response["success"] == true) {
      await TokenStorage.saveToken(response["token"]);

      return true;
    }

    return false;
  }
}
