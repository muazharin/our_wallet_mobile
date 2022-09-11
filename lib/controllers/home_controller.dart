import 'dart:convert';
import 'package:get/get.dart';
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
  var errorList = "".obs;
  var errorListMember = "".obs;
  var errorListTransaction = "".obs;
  var isErrorList = false.obs;
  var isErrorListMember = false.obs;
  var isErrorListTransaction = false.obs;
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
      "username": sp.getString("username") ?? "",
      "email": sp.getString("email") ?? "",
      "phone": sp.getString("phone") ?? "",
      "photo": sp.getString("photo") ?? "",
      "gender": sp.getString("gender") ?? "",
      "tgllahir": sp.getString("tgl_lahir") ?? "",
      "address": sp.getString("address") ?? "",
      "created_at": sp.getString("created_at") ?? "",
      "updated_at": sp.getString("updated_at") ?? "",
    };
    dataLocal = RxMap.from(data);
    getOurWallet();
  }

  void onIndexChanged(int i) {
    index.value = i;
    isLoadingMember(true);
    isLoadingTransaction(true);
    getOurWallet();
  }

  void getOurWallet() async {
    GlobalServices()
        .get('${getourwallet!}?page=$page',
            header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoadingCard(false);
      if (value is String) {
        isErrorList(true);
        errorList(value);
        isLoadingMember(false);
        isLoadingTransaction(false);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultWalletModel = ResultWalletModel.fromJson(response);
          list = resultWalletModel.data!;
          if (list.isNotEmpty) {
            getMemberWallet({'wallet_id': list[index.value].walletId});
          } else {
            isLoadingMember(false);
            isLoadingTransaction(false);
          }
        } else {
          isLoadingMember(false);
          isLoadingTransaction(false);
          isErrorList(true);
          errorList.value = response["message"];
        }
      }
    });
  }

  void getMemberWallet(Map params) async {
    isLoadingMember(true);
    GlobalServices()
        .get('${getmemberwallet!}?wallet_id=${params["wallet_id"]}&page=$page',
            header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoadingMember(false);
      if (value is String) {
        isErrorListMember(true);
        errorListMember.value = value;
        isLoadingTransaction(false);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultMemberWalletModel = ResultMemberWalletModel.fromJson(response);
          listmember = resultMemberWalletModel.data!;
          if (listmember.isNotEmpty) {
            getLastTransaction({
              'walletId': list[index.value].walletId,
            });
          } else {
            isLoadingTransaction(false);
          }
        } else {
          isLoadingTransaction(false);
          isErrorListMember(true);
          errorListMember(response['message']);
        }
      }
    });
  }

  void getLastTransaction(Map params) async {
    isLoadingTransaction(true);
    GlobalServices()
        .get(
            '${gettransactionwallet!}?wallet_id=${params["walletId"]}&page=$page',
            header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoadingTransaction(false);
      if (value is String) {
        isErrorListTransaction(true);
        errorListTransaction(value);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultTransactionModel = ResultTransactionModel.fromJson(response);
          listtransaction = resultTransactionModel.data!;
        } else {
          isErrorListTransaction(true);
          errorListTransaction(response['message']);
        }
      }
    });
  }
}
