import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/modelView/patient_view.dart';
import 'package:patient_navigation_fhir_mobile/Patient/patient_detail_view.dart';
import 'package:patient_navigation_fhir_mobile/services/PatientService.dart';

class PatientMainPage extends StatefulWidget {
  const PatientMainPage({Key? key}) : super(key: key);

  @override
  _PatientMainPage createState() => _PatientMainPage();
}

class _PatientMainPage extends State<PatientMainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Patient>>(
        future: PatientService.getPatients(),
        builder: (context, AsyncSnapshot<List<Patient>> snapshot) {
          if (snapshot.hasData) {
            var itemCount = snapshot.data?.length ?? 0;
            List<Widget> lista = [];
            snapshot.data?.forEach((element) {
              var a = Card(
                  child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(element.name?.first.given?.first ?? ""),
                trailing: Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientDetailView(patient: element)),
                        );
                      },
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientDetailView(patient: element)),
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
                : const Center(child: Text('No patients'));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
