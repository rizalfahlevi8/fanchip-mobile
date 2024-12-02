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
}
