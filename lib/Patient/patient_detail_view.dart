import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/PatientService.dart';

class PatientDetailView extends StatelessWidget {
  const PatientDetailView({Key? key, required this.patient}) : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do paciente'),
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

  final controllername = TextEditingController();
  final controllerbirthDate = TextEditingController();
  final controllertelecom = TextEditingController();
  final controlleraddressline = TextEditingController();
  final controlleraddressdistrict = TextEditingController();
  final controlleraddresspostalCode = TextEditingController();
  final controlleraddresscity = TextEditingController();
  final controlleraddressstate = TextEditingController();
  final controlleraddresscountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    var firstName = widget.patient.name?.first.given?.first ?? "";
    var familyName =  widget.patient.name?.first.family ?? "";
    controllername.text = firstName + " " + familyName;
    controllerbirthDate.text =
        widget.patient.birthDate?.value?.toString() ?? "";
    controllertelecom.text = widget.patient.telecom?[1].value ?? "";
    controlleraddressline.text =
        widget.patient.address?.first.line?.first ?? "";
    controlleraddressdistrict.text =
        widget.patient.address?.first.district ?? "";
    controlleraddresspostalCode.text =
        widget.patient.address?.first.postalCode ?? "";
    controlleraddresscity.text = widget.patient.address?.first.city ?? "";
    controlleraddressstate.text = widget.patient.address?.first.state ?? "";
    controlleraddresscountry.text = widget.patient.address?.first.country ?? "";
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
                  controller: controllername,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome do Paciente',
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
                  controller: TextEditingController(
                      text: widget.patient.birthDate?.value?.toString() ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Data de nascimento',
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
                  controller: TextEditingController(
                      text: widget.patient.telecom?[1].value ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Telefone do Paciente',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.line?.first ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Endereço',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.district ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Bairro',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.postalCode ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Código Postal',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.city ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Cidade',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.state ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Estado',
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
                  controller: TextEditingController(
                      text: widget.patient.address?.first.country ?? ""),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'País',
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //PatientService.putPatient(patient);
                      print(controllername.text);

                      var changedPatient = patient.copyWith(
                        name: [
                          HumanName(family: controllername.text.split(" ")[1], given: [controllername.text.split(" ")[0]])
                        ],
                        birthDate: Date.fromDateTime(DateTime.parse(controllerbirthDate.text))
                      );

                      //patient.birthDate = Date.fromDateTime(DateTime.parse(controllerbirthDate.text));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );
                      PatientService.putPatient(changedPatient);
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

// class PatientArguments {
//   final Patient patient;

//   PatientArguments(this.patient);
// }
