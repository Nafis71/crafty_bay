import 'package:crafty_bay/core/services/network_repository.dart';

import 'network_urls/network_urls.dart';

class ProfileDetailService extends NetworkRepository {
  Future<Object> readProfile(String token) async {
    return await getRequest(
        url: NetworkUrls.readProfile, headers: {"token": token});
  }

  Future<Object> createProfile(String token, Map<String, dynamic> json) async {
    return await postRequest(
      url: NetworkUrls.createProfile,
      body: json,
      headers: {
        "content-type": "Application/json",
        "token": token,
      },
    );
  }
}
