import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:getx/utils/constant.dart';
import 'package:http/http.dart' as http;

class GlobalServices {
  Future post(path, body, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    try {
      return await http
          .post(url, body: body, headers: header ?? headers)
          .timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future get(path, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    try {
      return await http
          .get(url, headers: header ?? headers)
          .timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future dioPost(path, body) async {
    try {
      return await Dio()
          .post(path, data: body)
          .timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }
}
