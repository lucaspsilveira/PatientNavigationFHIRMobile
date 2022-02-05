import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_navigation_fhir_mobile/services/MedicationStatementService.dart';

class MedicationStatementCreateView extends StatelessWidget {
  const MedicationStatementCreateView({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Declaração de medicação'),
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    //controllerserviceCategory.text = widget.medicationStatement.serviceCategory?.first.coding?.first.display ?? "";
    //controllerServiceType.text = widget.medicationStatement.serviceType.
    var firstName = widget.patient.name?.first.given?.first ?? "";
    var familyName = widget.patient.name?.first.family ?? "";
    controllerPatientName.text = firstName + " " + familyName;

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //MedicationStatementService.putMedicationStatement(medicationStatement);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );

                      // MedicationStatementService.postMedicationStatement(
                      //     changedMedicationStatement);
                    }
                  },
                  child: const Text('Criar'),
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
