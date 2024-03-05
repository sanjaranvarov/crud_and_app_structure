import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:crud_and_app_structure/src/data/entity/item_model.dart';

class NetworkService {
  //BASEURL =https://655deeb99f1e1093c59a2eda.mockapi.io/Item
  static const baseURL = "655deeb99f1e1093c59a2eda.mockapi.io";

  //APIS
  static const apiITEM = "/Item";

// headers
  static Map<String, String>? headers = {
    'Content-Type': 'application/json',
  };

// GET method
  static Future<String?> gET(String api, Map<String, String> params) async {
    final url = Uri.https(baseURL, api);
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  // POST method
  static Future<String?> post(String api, Map<String, dynamic> body) async {
    Uri url = Uri.https(baseURL, api);
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      // Handle any errors here
      log('Failed to add product: ${response.statusCode}');
      return null;
    }
  }

  // PUT method
  static Future<String?> put(String api, Map<String, dynamic> body) async {
    final url = Uri.https(baseURL, api);
    final response =
        await http.put(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully updated');
      return response.body;
    } else {
      log('Failed to update product: ${response.statusCode}');
      return null;
    }
  }

  // DELETE method
  static Future<String?> delete(String api) async {
    final url = Uri.https(baseURL, api);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 204) {
      log('Deleted successfully');
      return response.body;
    } else {
      log('Failed to delete product: ${response.statusCode}');
      return null;
    }
  }

  static Future<List<Item>> readPosts() async {
    final url = Uri.https(baseURL, apiITEM);
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<Item> products =
          responseData.map((data) => Item.fromJson(data)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  /// params

  static Map<String, String> emptyParams() => <String, String>{};

  static Map<String, String> paramSignIn(String email, String password) =>
      <String, String>{"email": email, "password": password};

  /// body

  static Map<String, dynamic> bodyEmpty() => <String, dynamic>{};

  static Map<String, String> bodyLoginUser(
          {required String email, required String password}) =>
      <String, String>{"email": email, "password": password};

  static Map<String, String> bodyResetPassword({required String email}) =>
      <String, String>{"email": email};

  static Map<String, String> bodyConfirmPassword(
          {required String password,
          required String confirmPassword,
          required String token}) =>
      <String, String>{
        "password": password,
        "password2": confirmPassword,
        "token": token
      };
}
