import 'package:crafty_bay/common/services/api_request.dart';

import '../../../common/services/network_urls/network_urls.dart';

class ProfileDetailService extends ApiRequest {
  Future<Object> readProfile(String token) async {
    return await getRequest(
        url: NetworkUrls.readProfile, headers: {"token": token});
  }

  Future<Object> createProfile(String token, Map<String, String> json) async {
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
