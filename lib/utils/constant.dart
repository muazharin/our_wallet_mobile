import 'package:shared_preferences/shared_preferences.dart';

String? baseurl = "http://10.227.22.3:8080/v1";

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

  static Future<Map<String, String>> getHeaderTokenFile() async {
    SharedPreferences? sp = await SharedPreferences.getInstance();
    var token = sp.getString("token");
    Map<String, String>? header = {
      "Content-Type": "multipart/form-data",
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
String? updatewallet = "${baseurl!}/wallet/update_wallet";

// owWallet
String? getmemberwallet = "${baseurl!}/ow/get_ow_user";
String? addmemberwallet = "${baseurl!}/ow/add_member";
String? getmemberforwallet = "${baseurl!}/ow/get_for_member";

// transaction
String? gettransactionwallet = "${baseurl!}/trans/get_all_by_wallet_id";
String? gettransactionuser = "${baseurl!}/trans/get_all_by_user_id";
String? createtransaction = "${baseurl!}/trans/create_trans";

// category
String? getcategory = "${baseurl!}/category/get_all_category";
String? createcategory = "${baseurl!}/category/add_category";
String? updatecategory = "${baseurl!}/category/update_category";
String? deletecategory = "${baseurl!}/category/delete_category";
