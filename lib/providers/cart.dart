import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ecommerce/providers/Inspector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  //Get all products
  Future<dynamic> getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("AUTH_TOKEN");
    final http.Response response = await http.get(
      Inspector.baseAPIUrl + "/CartDetails/",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + authToken
      },
    );
    print(response.body);
    return response;
  }

  //Add First product
  Future<dynamic> addFirstProduct(productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("AUTH_TOKEN");
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails =
        await json.decode(userPrefs.get("userDetails"));
    final http.Response response = await http.post(
      Inspector.baseAPIUrl + "/order/",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + authToken
      },
      body: json.encode({
        'user_id': userDetails['userId'],
        'product_id': productId,
      }),
    );
    print(response.body);
    return response;
  }

  //Increment product count
  Future<dynamic> incrementProduct(productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("AUTH_TOKEN");
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails =
        await json.decode(userPrefs.get("userDetails"));
    final http.Response response = await http.post(
      Inspector.baseAPIUrl + "/OrderActionDetail/",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + authToken
      },
      body: json.encode({
        'user_id': userDetails['userId'],
        'product_id': productId,
        "action": "increment"
      }),
    );
    print(response.body);
    return response;
  }

  //Decrement product count
  Future<dynamic> decrementProduct(productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("AUTH_TOKEN");
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails =
        await json.decode(userPrefs.get("userDetails"));
    final http.Response response = await http.post(
      Inspector.baseAPIUrl + "/OrderActionDetail/",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + authToken
      },
      body: json.encode({
        'user_id': userDetails['userId'],
        'product_id': productId,
        "action": "decrement"
      }),
    );
    print(response.body);
    return response;
  }
}
