import 'dart:convert';

import 'package:fanchip_mobile/model/user_model.dart';
import 'package:fanchip_mobile/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _base = Config.baseUrl;

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('$_base/auth'), headers: {
        'Accept': 'application/json',
      }, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data["token"]);
        await prefs.setString('id_user', data["id_user"].toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> register(String nama, String address,
      String phone, String email, String pass) async {
    try {
      final response =
          await http.post(Uri.parse('$_base/auth/register'), headers: {
        'Accept': 'application/json',
      }, body: {
        'nama': nama,
        'alamat': address,
        'no_telp': phone,
        'email': email,
        'password': pass,
      });
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data["token"]);
        await prefs.setString('id_user', data["id_user"].toString());
        return {'success': true, 'message': 'Registrasi berhasil'};
      } else {
        // Mengembalikan pesan error dari respons API jika gagal
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['errors'] ?? 'Registrasi gagal'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi masalah pada koneksi'};
    }
  }

  Future getDataUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? userId = prefs.getString('id_user');

      final response =
          await http.get(Uri.parse('$_base/auth/$userId'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var userJson = jsonDecode(response.body);
        var user = UserModel.fromJson(userJson); 
        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.post(Uri.parse('$_base/auth/logout'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
