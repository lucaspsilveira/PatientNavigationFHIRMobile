import 'dart:convert';
import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class PatientService {
  static const String server = "http://10.0.2.2:5128";
  static const String resource = "Patient";

  static Future<Patient> getPatient(String patientId) async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/$patientId'), headers: headers);

    //var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    var patient = Patient.fromJson(json.decode(response.body));
    print(json.encode(patient.toJson()));
    return patient;
  }

  static Future<List<Patient>> getPatients() async {
    var headers = {'Content-type': 'application/json'};
    var response =
        await get(Uri.parse('$server/$resource/'), headers: headers);

    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    List<Patient> listPatient = [];
    searchSetBundle.entry?.forEach((a) => {
      if (a.resource != null) {
        listPatient.add(Patient.fromJson(a.resource!.toJson()))
      }
    });
    return listPatient;
  }

  static Future postPatient(Patient patient) async {
    var headers = {'Content-type': 'application/json'};
    var result = await post(Uri.parse('$server/$resource'),
        headers: headers, body: json.encode(patient.toJson()));
    print(result.body + result.statusCode.toString());
  }
}
