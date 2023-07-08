import 'dart:convert';

import 'package:siakad/helpers/api.dart';
import 'package:siakad/helpers/api_url.dart';
import 'package:siakad/model/matkul.dart';

class MatkulBloc {
  static Future<List<Matkul>> getMatkuls() async {
    String apiUrl = ApiUrl.listMatkul;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listMatkul = (jsonObj as Map<String, dynamic>)['data'];
    List<Matkul> Matkuls = [];
    for (int i = 0; i < listMatkul.length; i++) {
      Matkuls.add(Matkul.fromJson(listMatkul[i]));
    }
    return Matkuls;
  }

  static Future addMatkul({Matkul? matkul}) async {
    String apiUrl = ApiUrl.createMatkul;

    var body = {
      "kode_matkul": matkul!.kodeMatkul,
      "nama_matkul": matkul.namaMatkul,
      "sks": matkul.sks.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateMatkul({required Matkul matkul}) async {
    String apiUrl = ApiUrl.updateMatkul(matkul.id!);

    var body = {
      "kode_matkul": matkul.kodeMatkul,
      "nama_matkul": matkul.namaMatkul,
      "sks": matkul.sks.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteMatkul({int? id}) async {
    String apiUrl = ApiUrl.deleteMatkul(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
