import 'dart:convert';
import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class ProcedureService {
  static const String server = "http://10.0.2.2:5126";
  static const String resource = "Procedure";

  static Future<Procedure> getProcedure(String procedureId) async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/$procedureId'), headers: headers);

    //var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    var procedure = Procedure.fromJson(json.decode(response.body));
    print(json.encode(procedure.toJson()));
    return procedure;
  }

  static Future<List<Procedure>> getProcedures() async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/'), headers: headers);

    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    List<Procedure> listProcedure = [];
    searchSetBundle.entry?.forEach((a) => {
      if (a.resource != null) {
        listProcedure.add(Procedure.fromJson(a.resource!.toJson()))
      }
    });
    return listProcedure;
  }

  static Future postProcedure(Procedure procedure) async {
    var headers = {'Content-type': 'application/json'};
    var result = await post(Uri.parse('$server/$resource'),
        headers: headers, body: json.encode(procedure.toJson()));
    print(result.body + result.statusCode.toString());
  }

  static Future putProcedure(Procedure procedure) async {
    var headers = {'Content-type': 'application/json'};
    var procedureId = procedure.id?.value;
    var result = await put(Uri.parse('$server/$resource/$procedureId'),
        headers: headers, body: json.encode(procedure.toJson()));
    print(result.body + result.statusCode.toString());
  }
}
