import 'dart:convert';

import 'package:fanchip_mobile/model/hewan_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HewanService {
  final _base = 'http://127.0.0.1:8000/api';

  Future getDataHewan() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? idUser = prefs.getString('id_user');

      final response =
          await http.get(Uri.parse('$_base/hewan/$idUser'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        Iterable it = jsonResponse;
        List<HewanModel> home = it.map((e) => HewanModel.fromJson(e)).toList();
        return home;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataHewanId(String idHewan) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response =
          await http.get(Uri.parse('$_base/hewan/show/$idHewan'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var hewanJson = jsonDecode(response.body);
        var hewan = HewanModel.fromJson(hewanJson); 
        return hewan;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postHewan(String nama, String idJenis, String pemeriksaanFisik,
      String pemeriksaanLanjutan) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? userId = prefs.getString('id_user');

      final response = await http.post(Uri.parse('$_base/hewan'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        "nama": nama,
        "id_jenis": idJenis,
        "pemeriksaan_fisik": pemeriksaanFisik,
        "pemeriksaan_lanjutan": pemeriksaanLanjutan,
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

  Future<bool> updateHewan(String id, String nama, String idJenis,
      String pemeriksaanFisik, String pemeriksaanLanjutan) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.put(
        Uri.parse('$_base/hewan/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "nama": nama,
          "id_jenis": idJenis,
          "pemeriksaan_fisik": pemeriksaanFisik,
          "pemeriksaan_lanjutan": pemeriksaanLanjutan,
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

  Future<bool> deleteHewan(String idHewan) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.delete(
        Uri.parse('$_base/hewan/$idHewan'),
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
