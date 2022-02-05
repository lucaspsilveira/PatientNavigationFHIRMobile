import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_navigation_fhir_mobile/services/MedicationStatementService.dart';

class MedicationStatementDetailView extends StatelessWidget {
  const MedicationStatementDetailView({Key? key, required this.medicationStatement})
      : super(key: key);
  final MedicationStatement medicationStatement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Declaração de medicação'),
        ),
        body: MyCustomForm(medicationStatement: medicationStatement));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.medicationStatement}) : super(key: key);
  final MedicationStatement medicationStatement;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  final _formKey = GlobalKey<FormState>();

  final controllerPatientName = TextEditingController();
  final controllerMedicationName = TextEditingController();
  final controllerNotes = TextEditingController();
  final controllerEffectiveDatetime = TextEditingController();
  String _selectedStatus = "active";
  final _selectStatus = [
    "active",
    "completed",
    "enteredInError",
    "intended",
    "stopped",
    "onHold",
    "unknown",
    "notTake"
  ];

@override
  void initState() {
    controllerPatientName.text = widget.medicationStatement.subject.display ?? "";
    controllerMedicationName.text = widget.medicationStatement.medicationCodeableConcept?.text ?? "";
    controllerNotes.text = widget.medicationStatement.note?.first.text?.value ?? "";
    controllerEffectiveDatetime.text = widget.medicationStatement.effectiveDateTime.toString();
     _selectedStatus = widget.medicationStatement.status?.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    //controllerserviceCategory.text = widget.medicationStatement.serviceCategory?.first.coding?.first.display ?? "";
    //controllerServiceType.text = widget.medicationStatement.serviceType.
    
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerPatientName,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome do paciente',
                    enabled: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerMedicationName,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome da medicação',
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerEffectiveDatetime,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Data de administração',
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerNotes,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Notas',
                    enabled: true,
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text("Estado da declaração")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: DropdownButton(
                  hint: const Text(
                      'Please choose a status'), // Not necessary for Option 1
                  value: _selectedStatus,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStatus = newValue.toString();
                    });
                  },
                  items: _selectStatus.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );
                      var changedMedicationStatement = widget.medicationStatement.copyWith(
                          subject: 
                                  widget.medicationStatement.subject,
                          note: [
                            Annotation(text: Markdown(controllerNotes.text))
                          ],
                          effectiveDateTime: FhirDateTime.fromDateTime(
                              DateTime.parse(controllerEffectiveDatetime.text)),
                          medicationCodeableConcept: CodeableConcept(
                              text: controllerMedicationName.text),
                          status: Code(_selectedStatus));
                      MedicationStatementService.putMedicationStatement(
                          changedMedicationStatement);
                          
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

// class MedicationStatementArguments {
//   final MedicationStatement medicationStatement;

//   MedicationStatementArguments(this.medicationStatement);
// }
