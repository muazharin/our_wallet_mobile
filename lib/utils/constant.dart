import 'package:shared_preferences/shared_preferences.dart';

String? baseurl = "http://192.168.137.253:8080/v1";

// headers
Map<String, String>? headers = {
  "X-API-KEY": "d934019a-7ea4-4be5-b413-707ea6d60643"
};

class BaseHeader {
  static Future<Map<String, String>?> getHeaderToken({String? data}) async {
    SharedPreferences? sp = await SharedPreferences.getInstance();
    var token = sp.getString("token");
    if (data != null) {
      token = data;
    }
    Map<String, String>? header = {
      "X-API-KEY": "d934019a-7ea4-4be5-b413-707ea6d60643",
      "Authorization": "Bearer $token",
    };
    return header;
  }
}

// path assets
String? pngpath = "assets/png/";
String? svgpath = "assets/svg/";

// endpoint

// auth
String? authcheckphonenumber = "${baseurl!}/auth/check_phone_number";
String? authlogin = "${baseurl!}/auth/signin";
String? authregister = "${baseurl!}/auth/signup";

// user
String? authcreatepassword = "${baseurl!}/user/create_password";

// wallet
String? getourwallet = "${baseurl!}/wallet/get_all_wallet";
String? createwallet = "${baseurl!}/wallet/create_wallet";

// owWallet
String? getmemberwallet = "${baseurl!}/ow/get_ow_user";

// transaction
String? gettransactionwallet = "${baseurl!}/trans/get_all_by_wallet_id";

String? getusertowallet = "${baseurl!}/wallet/get_user_to_wallet";
String? updatewallet = "${baseurl!}/wallet/update_wallet";
String? addmemberwallet = "${baseurl!}/wallet/add_member_wallet";
