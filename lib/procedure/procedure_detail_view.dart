import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/ProcedureService.dart';

class ProcedureDetailView extends StatelessWidget {
  const ProcedureDetailView({Key? key, required this.procedure}) : super(key: key);
  final Procedure procedure;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do procedimento'),
        ),
        body: MyCustomForm(procedure: procedure));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.procedure}) : super(key: key);
  final Procedure procedure;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(procedure: this.procedure);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  Procedure procedure;
  MyCustomFormState({required this.procedure});
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final controllertype = TextEditingController();
  final controllerstatus = TextEditingController();
  final controllersubject = TextEditingController();
  final controllerperformeddatetime = TextEditingController();
  final controllerreason = TextEditingController();
  final controllerfollowup = TextEditingController();
  // maybe add practitioner info

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    controllertype.text = widget.procedure.code?.text ?? "";
    controllerstatus.text = widget.procedure.status?.value ?? "";
    controllersubject.text = widget.procedure.subject.display ?? "";
    controllerperformeddatetime.text = widget.procedure.performedDateTime.toString();
    controllerreason.text = widget.procedure.reasonCode?.first.text ?? ""; 
    controllerfollowup.text = widget.procedure.followUp?.first.text ?? "";

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllertype,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Tipo de Procedimento',
                    enabled: false
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllerstatus,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Estado do procedimento',
                    enabled: false
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllersubject,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome do paciente',
                    enabled: false
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllerperformeddatetime,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Data de realização do procedimento',
                    enabled: false
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  maxLines: 3,
                  controller: controllerreason,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Motivo para procedimento',
                    enabled: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Esse campo não pode ser vazio';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllerfollowup,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Acompanhamento',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //ProcedureService.putProcedure(procedure);

                      //procedure.birthDate = Date.fromDateTime(DateTime.parse(controllerbirthDate.text));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );

                        // ProcedureService.putProcedure(changedProcedure);
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              ),
            ],
          ),
        ));
  }
}

// class ProcedureArguments {
//   final Procedure procedure;

//   ProcedureArguments(this.procedure);
// }
