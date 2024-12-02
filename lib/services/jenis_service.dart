import 'dart:convert';
import 'package:fanchip_mobile/model/jenis_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JenisService {
  final _base = 'http://127.0.0.1:8000/api';

  Future getDataJenis() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? idUser = prefs.getString('id_user');

      final response =
          await http.get(Uri.parse('$_base/jenis/$idUser'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        Iterable it = jsonResponse;
        List<JenisModel> home = it.map((e) => JenisModel.fromJson(e)).toList();
        return home;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataJenisId(String idJenis) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response =
          await http.get(Uri.parse('$_base/jenis/show/$idJenis'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var jenisJson = jsonDecode(response.body);
        var jenis = JenisModel.fromJson(jenisJson); 
        return jenis;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postHewan(String nama) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? userId = prefs.getString('id_user');

      final response = await http.post(Uri.parse('$_base/jenis'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        "nama": nama,
        "id_user": userId,
      });

      print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

    Future<bool> updateJenis(String id, String nama) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.put(
        Uri.parse('$_base/jenis/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "nama": nama
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteJenis(String idJenis) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.delete(
        Uri.parse('$_base/jenis/$idJenis'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
