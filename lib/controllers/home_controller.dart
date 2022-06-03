import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx/controllers/auth_controller.dart';
import 'package:getx/models/transaction_model.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  ResultWalletModel resultWalletModel = ResultWalletModel();
  List<WalletModel> list = [];
  ResultMemberWalletModel resultMemberWalletModel = ResultMemberWalletModel();
  List<MemberWalletModel> listmember = [];
  ResultTransactionModel resultTransactionModel = ResultTransactionModel();
  List<TransactionModel> listtransaction = [];
  var page = 1.obs;
  var index = 0.obs;
  var dataLocal = {}.obs;
  var isLoading = false.obs;
  var isLoadingCard = false.obs;
  var isLoadingMember = false.obs;
  var isLoadingTransaction = false.obs;

  void getLocalData() async {
    isLoadingCard(true);
    isLoadingMember(true);
    isLoadingTransaction(true);
    index.value = 0;
    SharedPreferences sp = await SharedPreferences.getInstance();
    var data = {
      "id": sp.getInt("id") ?? "",
      "username": sp.getString("username") ?? "",
      "email": sp.getString("email") ?? "",
      "phone": sp.getString("phone") ?? "",
      "photo": sp.getString("photo") ?? "",
      "gender": sp.getString("gender") ?? "",
      "tgllahir": sp.getString("tgllahir") ?? "",
      "address": sp.getString("address") ?? "",
    };
    dataLocal = RxMap.from(data);
    getOurWallet({'userId': dataLocal['id']});
  }

  void onIndexChanged(int i) {
    index.value = i;
    isLoadingMember(true);
    isLoadingTransaction(true);
    getOurWallet({'userId': dataLocal['id']});
  }

  void getOurWallet(Map params) async {
    GlobalServices()
        .get('${getourwallet!}?userId=${params['userId']}')
        .then((value) {
      isLoadingCard(false);
      if (value is String) {
        AuthController().snackbar(value, false);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultWalletModel = ResultWalletModel.fromJson(response);
          list = resultWalletModel.data!;
          if (list.isNotEmpty) {
            getMemberWallet({'id': list[index.value].owWalletId});
          } else {
            isLoadingMember(false);
            isLoadingTransaction(false);
          }
        } else {
          AuthController().snackbar(response["message"], false);
        }
      }
    });
  }

  void getMemberWallet(Map params) async {
    isLoadingMember(true);
    GlobalServices().get('${getmemberwallet!}/${params["id"]}').then((value) {
      isLoadingMember(false);
      if (value is String) {
        AuthController().snackbar(value, false);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultMemberWalletModel = ResultMemberWalletModel.fromJson(response);
          listmember = resultMemberWalletModel.data!;
          getLastTransaction({
            'walletId': list[index.value].owWalletId,
            'userId': '',
          });
        } else {
          AuthController().snackbar(response["message"], false);
        }
      }
    });
  }

  void getLastTransaction(Map params) async {
    isLoadingTransaction(true);
    GlobalServices()
        .get(
            '${gettransactionwallet!}?walletId=${params["walletId"]}&userId=${params["userId"]}&page=$page')
        .then((value) {
      isLoadingTransaction(false);
      if (value is String) {
        AuthController().snackbar(value, false);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultTransactionModel = ResultTransactionModel.fromJson(response);
          listtransaction = resultTransactionModel.data!;
        } else {
          AuthController().snackbar(response["message"], false);
        }
      }
    });
  }
}
