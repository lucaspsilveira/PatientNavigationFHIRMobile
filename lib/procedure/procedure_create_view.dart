import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/ProcedureService.dart';

class ProcedureCreateView extends StatelessWidget {
  const ProcedureCreateView({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do procedimento'),
        ),
        body: MyCustomForm(patient: patient));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.patient}) : super(key: key);
  final Patient patient;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(patient: this.patient);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  Patient patient;
  MyCustomFormState({required this.patient});
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
  List<String> _options = ["Preparation","InProgress","NotDone","OnHold","Stopped","Completed","EnteredInError","Unknown"];
  String _selectedstatus = 'Preparation'; 
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    var firstName = widget.patient.name?.first.given?.first ?? "";
    var familyName = widget.patient.name?.first.family ?? "";
    controllersubject.text = firstName + " " + familyName;
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
                      enabled: true),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text("Estado do apontamento")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: DropdownButton(
                  hint: const Text(
                      'Please choose a status'), // Not necessary for Option 1
                  value: _selectedstatus,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedstatus = newValue.toString();
                    });
                  },
                  items: _options.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
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
                      enabled: false),
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
                      enabled: true),
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
                    enabled: true,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //ProcedureService.putProcedure(procedure);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );

                      var procedure = Procedure(
                        subject: Reference(
                            reference:
                                "Patient/" + (widget.patient.id?.value ?? ""),
                            display: controllersubject.text),
                        code: CodeableConcept(text: controllertype.text),
                        performedDateTime: FhirDateTime.fromDateTime(DateTime.parse(controllerperformeddatetime.text)),
                        reasonCode: [CodeableConcept(text: controllerreason.text)],
                        followUp: [CodeableConcept(text: controllerfollowup.text)],
                        status: Code(_selectedstatus)
                      );

                      ProcedureService.postProcedure(procedure);
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
