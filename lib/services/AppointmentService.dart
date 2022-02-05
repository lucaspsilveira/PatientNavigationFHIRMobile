import 'dart:convert';
import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class AppointmentService {
  static const String server = "http://10.0.2.2:5150";
  static const String ipAddress = "10.0.2.2:5150";
  static const String resource = "Appointment";

  static Future<Appointment> getAppointment(String appointmentId) async {
    var headers = {'Content-type': 'application/json'};
    var response = await get(Uri.parse('$server/$resource/$appointmentId'),
        headers: headers);

    //var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    var appointment = Appointment.fromJson(json.decode(response.body));
    print(json.encode(appointment.toJson()));
    return appointment;
  }

  static Future<List<Appointment>> getAppointments() async {
    var headers = {'Content-type': 'application/json'};
    var response = await get(Uri.parse('$server/$resource/'), headers: headers);

    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    List<Appointment> listAppointment = [];
    searchSetBundle.entry?.forEach((a) => {
          if (a.resource != null)
            {listAppointment.add(Appointment.fromJson(a.resource!.toJson()))}
        });
    return listAppointment;
  }

  static Future<List<Appointment>> getAppointmentsFromSubject(String id) async {
    var headers = {'Content-type': 'application/json'};
    final queryParameters = {
      'subject': id,
    };
    var uri = Uri.http(ipAddress, resource, queryParameters);
    var response = await get(uri, headers: headers);

    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    List<Appointment> listAppointment = [];
    searchSetBundle.entry?.forEach((a) => {
          if (a.resource != null)
            {listAppointment.add(Appointment.fromJson(a.resource!.toJson()))}
        });
    return listAppointment;
  }

  static Future postAppointment(Appointment appointment) async {
    var headers = {'Content-type': 'application/json'};
    var result = await post(Uri.parse('$server/$resource'),
        headers: headers, body: json.encode(appointment.toJson()));
    print(result.body + result.statusCode.toString());
  }

  static Future putAppointment(Appointment appointment) async {
    var headers = {'Content-type': 'application/json'};
    var appointmentId = appointment.id?.value;
    var result = await put(Uri.parse('$server/$resource/$appointmentId'),
        headers: headers, body: json.encode(appointment.toJson()));
    print(result.body + result.statusCode.toString());
  }
}
