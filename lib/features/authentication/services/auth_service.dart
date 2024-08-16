import 'package:crafty_bay/common/services/api_request.dart';
import 'package:crafty_bay/common/services/network_urls/network_urls.dart';

class AuthService extends ApiRequest {
  static AuthService? _instance;

  AuthService._();

  factory AuthService() => _instance ??= AuthService._();

  Future<Object> sendOTP(String emailAddress) async {
    return await getRequest(url: "${NetworkUrls.userLogin}/$emailAddress");
  }

  Future<Object> verifyOTP(String emailAddress, String otp) async {
    return await getRequest(
        url: "${NetworkUrls.verifyLogin}/$emailAddress/$otp");
  }
}
