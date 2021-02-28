import 'dart:convert';

import 'package:app/exceptions/exception.dart';
import 'package:app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

class AuthenticationDataProvider {
  final _baseUrl = "http://10.0.2.2:8383/api";

  Future<User> getCurrentUser() async {
    var user = getUserFromToken(await getToken()); // return null for now
    return user;
  }

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "jwt_token");
    return "'Bearer $token';";
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final response = await http.post('$_baseUrl/signin',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("data is ${data}");
      storeJwt(data['token']);

      return User.fromJson(data["user"]);
    } else {
      throw AuthenticationException(message: 'Wrong username or password');
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String username, String email, String password, String role_id) async {
    print("$username $password $role_id $email is the user register info");
    final response = await http.post('$_baseUrl/signup',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
          'role_id': role_id
        }));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw AuthenticationException(message: 'Wrong username or password');
    }
  }

  @override
  Future<void> signOut() {
    deleteJwt();
  }

  void storeJwt(token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'jwt_token', value: token);
  }

  void deleteJwt() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(
      key: 'jwt_token',
    );
  }

  User getUserFromToken(token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    // To check if token is expired
    bool isExpired = Jwt.isExpired(token);
    print(isExpired);

    // Can be used for auth state
    if (!isExpired) {
      //   Token isn't expired
      var email = payload['email'];
      var username = payload['username'];
      var role = payload['role'];
      print("payload is $email $username $role");
      User result = User(username: username, email: email, role: role);
      return result;
    } else {
      return null;
    }
  }
}

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // Create storage
// final storage = new FlutterSecureStorage();

// // Read value
// String value = await storage.read(key: key);

// // Read all values
// Map<String, String> allValues = await storage.readAll();

// // Delete value
// await storage.delete(key: key);

// // Delete all
// await storage.deleteAll();

// // Write value
// await storage.write(key: key, value: value);

// Future<String> getToken() async {
//   final storage = new FlutterSecureStorage();

// // // Read value
//   String value = await storage.read(key: "jwt_token");

// // Create storage
// final storage = new FlutterSecureStorage();

// // Write value
// await storage.write(key: 'jwt', value: token);
//   String token = "";
//   return "'Bearer $token';";
// }

// Future<Dio> networkInterCeptor() async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
// String token = prefs.getString('token');

// String refreshToken = prefs.getString('refreshToken');
// print('Refresh Token $refreshToken');
