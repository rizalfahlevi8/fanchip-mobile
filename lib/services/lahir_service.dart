import 'dart:convert';
import 'package:fanchip_mobile/model/lahir_model.dart';
import 'package:fanchip_mobile/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LahirService {
  final _base = Config.baseUrl;

  Future getDataLahir() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? idUser = prefs.getString('id_user');

      final response =
          await http.get(Uri.parse('$_base/kawin/$idUser'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        Iterable it = jsonResponse;
        List<LahirModel> home = it.map((e) => LahirModel.fromJson(e)).toList();
        return home;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataLahirId(String idLahir) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response =
          await http.get(Uri.parse('$_base/kawin/show/$idLahir'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var lahirJson = jsonDecode(response.body);
        var lahir = LahirModel.fromJson(lahirJson);
        return lahir;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postLahir(String idHewan, String tanggalKawin) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? userId = prefs.getString('id_user');

      print("idHewan: $idHewan");
      print("tanggalKawin: $tanggalKawin");

      final response = await http.post(Uri.parse('$_base/kawin'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        "id_hewan": idHewan,
        "tanggal_kawin": tanggalKawin,
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

  Future<bool> updateLahir(
      String id, String idHewan, String tanggalKawin) async {
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
          "id_hewan": idHewan,
          "tanggal_kawin": tanggalKawin,
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

  Future<bool> deleteHewan(String idLahir) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.delete(
        Uri.parse('$_base/lahir/$idLahir'),
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
