import 'dart:convert';
import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class MedicationStatementService {
  static const String server = "http://10.0.2.2:5246";
  static const String resource = "MedicationStatement";

  static Future<MedicationStatement> getMedicationStatement(String medicationStatementId) async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/$medicationStatementId'), headers: headers);

    //var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    var medicationStatement = MedicationStatement.fromJson(json.decode(response.body));
    print(json.encode(medicationStatement.toJson()));
    return medicationStatement;
  }

  static Future<List<MedicationStatement>> getMedicationStatements() async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/'), headers: headers);

    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    List<MedicationStatement> listMedicationStatement = [];
    searchSetBundle.entry?.forEach((a) => {
      if (a.resource != null) {
        listMedicationStatement.add(MedicationStatement.fromJson(a.resource!.toJson()))
      }
    });
    return listMedicationStatement;
  }

  static Future postMedicationStatement(MedicationStatement medicationStatement) async {
    var headers = {'Content-type': 'application/json'};
    var result = await post(Uri.parse('$server/$resource'),
        headers: headers, body: json.encode(medicationStatement.toJson()));
    print(result.body + result.statusCode.toString());
  }

  static Future putMedicationStatement(MedicationStatement medicationStatement) async {
    var headers = {'Content-type': 'application/json'};
    var medicationStatementId = medicationStatement.id?.value;
    var result = await put(Uri.parse('$server/$resource/$medicationStatementId'),
        headers: headers, body: json.encode(medicationStatement.toJson()));
    print(result.body + result.statusCode.toString());
  }
}
