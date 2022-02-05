import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/AppointmentService.dart';

import 'appointment_detail_view.dart';

class AppointmentMainPage extends StatefulWidget {
  const AppointmentMainPage({Key? key}) : super(key: key);

  @override
  _AppointmentMainPage createState() => _AppointmentMainPage();
}

class _AppointmentMainPage extends State<AppointmentMainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
        future: AppointmentService.getAppointments(),
        builder: (context, AsyncSnapshot<List<Appointment>> snapshot) {
          if (snapshot.hasData) {
            var itemCount = snapshot.data?.length ?? 0;
            List<Widget> lista = [];
            snapshot.data?.forEach((element) {
              var appointmentType = element.appointmentType?.coding?.first.code?.value ?? "";
              var patient = element.participant.where((el) => el.actor?.reference?.contains("Patient") == true);
              var participantName = patient.isNotEmpty ? patient.first.actor?.display : "";
              var startDate = element.start;
              var a = Card(
                  child: ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(appointmentType),
                subtitle: Text(startDate.toString()),
                // trailing: Column(
                //   children: <Widget>[
                //     IconButton(
                //       icon: const Icon(Icons.more_vert),
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => AppointmentDetailView(patient: element)),
                //         );
                //       },
                //     )
                //   ],
                // ),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetailView(appointment: element)),
                        );
                },
              ));
              lista.add(a);
            });
            return itemCount > 0
                ? Expanded(
                    child: ListView(
                    shrinkWrap: true,
                    children: lista,
                  ))
                : const Center(child: Text('No appointments'));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
