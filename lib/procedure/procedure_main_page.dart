import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/ProcedureService.dart';

import 'procedure_detail_view.dart';

class ProcedureMainPage extends StatefulWidget {
  const ProcedureMainPage({Key? key, required this.patient}) : super(key: key);
  final Patient patient;
  @override
  _ProcedureMainPage createState() => _ProcedureMainPage();
}

class _ProcedureMainPage extends State<ProcedureMainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Procedure>>(
        future: widget.patient.id?.value != null &&
                widget.patient.id!.value!.isNotEmpty ? ProcedureService.getProceduresFromSubject(widget.patient.id?.value ?? "") : ProcedureService.getProcedures(),
        builder: (context, AsyncSnapshot<List<Procedure>> snapshot) {
          if (snapshot.hasData) {
            var itemCount = snapshot.data?.length ?? 0;
            List<Widget> lista = [];
            snapshot.data?.forEach((element) {
              var procedureType = element.code?.text ?? "";
              var patient = element.subject.display ?? "";
              var a = Card(
                  child: ListTile(
                leading: const Icon(Icons.healing),
                title: Text(procedureType),
                subtitle: Text(patient),
                // trailing: Column(
                //   children: <Widget>[
                //     IconButton(
                //       icon: const Icon(Icons.more_vert),
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ProcedureDetailView(patient: element)),
                //         );
                //       },
                //     )
                //   ],
                // ),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcedureDetailView(procedure: element)),
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
                : const Center(child: Text('No procedures'));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
