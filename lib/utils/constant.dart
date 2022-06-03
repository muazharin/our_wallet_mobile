String? baseurl = "http://192.168.20.252/our_wallet_backend/api";

// path assets
String? pngpath = "assets/png/";
String? svgpath = "assets/svg/";

// endpoint

// auth
String? authcheckphonenumber = "${baseurl!}/auth/auth_check_phone_number";
String? authlogin = "${baseurl!}/auth/auth_login";
String? authregister = "${baseurl!}/auth/auth_register";
String? authcreatepassword = "${baseurl!}/auth/auth_create_password";

// wallet
String? getourwallet = "${baseurl!}/wallet/get_wallet";
String? getmemberwallet = "${baseurl!}/wallet/get_member_of_wallet";
String? gettransactionwallet = "${baseurl!}/transaction/list_transaction";
String? getusertowallet = "${baseurl!}/wallet/get_user_to_wallet";
String? createwallet = "${baseurl!}/wallet/create_wallet";
String? updatewallet = "${baseurl!}/wallet/update_wallet";
String? addmemberwallet = "${baseurl!}/wallet/add_member_wallet";
