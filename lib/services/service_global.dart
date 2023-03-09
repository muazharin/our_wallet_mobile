import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:getx/utils/constant.dart';
import 'package:http/http.dart' as http;

class GlobalServices {
  Future post(path, body, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    try {
      return await http
          .post(url, body: body, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (e) {
      return 'Unable to access server';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future post2(path, body, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http
          .post(url, body: body, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }

  Future postWithFile(path, body, List<File> file) async {
    Uri url = Uri.parse("$path");
    try {
      var request = http.MultipartRequest("POST", url);
      request.headers.addAll(await BaseHeader.getHeaderTokenFile());
      request.fields.addAll(body);
      for (var newFile in file) {
        request.files
            .add(await http.MultipartFile.fromPath("trans_file", newFile.path));
      }
      final response = await request.send().timeout(const Duration(seconds: 5));
      final respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);
      print("data => $data");
      return data;
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'Unable to access server';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future postWithFile2(path, body, List<File> file) async {
    Uri url = Uri.parse("$path");
    try {
      var request = http.MultipartRequest("POST", url);
      request.headers.addAll(await BaseHeader.getHeaderTokenFile());
      request.fields.addAll(body);
      for (var newFile in file) {
        request.files
            .add(await http.MultipartFile.fromPath("trans_file", newFile.path));
      }
      final response = await request.send().timeout(const Duration(seconds: 5));
      final respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);
      print("data => $data");
      return data;
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }

  Future put(path, body, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http
          .put(url, body: body, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'Unable to access server';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future put2(path, body, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http
          .put(url, body: body, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }

  Future get(path, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http
          .get(url, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'Unable to access server';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future get2(path, {Map<String, String>? header}) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http
          .get(url, headers: header ?? headers)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }
}
