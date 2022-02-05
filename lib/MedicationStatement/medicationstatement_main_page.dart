import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/MedicationStatementService.dart';

import 'medicationstatement_detail_view.dart';

class MedicationStatementMainPage extends StatefulWidget {
  const MedicationStatementMainPage({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  _MedicationStatementMainPage createState() => _MedicationStatementMainPage();
}

class _MedicationStatementMainPage extends State<MedicationStatementMainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MedicationStatement>>(
        future: widget.patient.id?.value != null &&
                widget.patient.id!.value!.isNotEmpty
            ? MedicationStatementService.getMedicationStatementsFromSubject(
                widget.patient.id?.value ?? "")
            : MedicationStatementService.getMedicationStatements(),
        builder: (context, AsyncSnapshot<List<MedicationStatement>> snapshot) {
          if (snapshot.hasData) {
            var itemCount = snapshot.data?.length ?? 0;
            List<Widget> lista = [];
            snapshot.data?.forEach((element) {
              var medicationStatementName =
                  element.medicationCodeableConcept?.text ?? "";
              var status = element.status?.value ?? "";
              var a = Card(
                  child: ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(medicationStatementName),
                subtitle: Text(status),
                // trailing: Column(
                //   children: <Widget>[
                //     IconButton(
                //       icon: const Icon(Icons.more_vert),
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => MedicationStatementDetailView(patient: element)),
                //         );
                //       },
                //     )
                //   ],
                // ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MedicationStatementDetailView(medicationStatement: element)),
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
                : const Center(child: Text('No medicationStatements'));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
