import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:patient_navigation_fhir_mobile/Appointment/appointment_create_view.dart';
import 'package:patient_navigation_fhir_mobile/MedicationStatement/medicationstatement_create_view.dart';
import 'package:patient_navigation_fhir_mobile/procedure/procedure_create_view.dart';
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
        body: MyCustomForm(patient: patient),
        floatingActionButton:
            // FloatingActionButton(
            //     backgroundColor: Colors.red,
            //     child: const Icon(Icons.medication_outlined),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 MedicationStatementCreateView(patient: this.patient)),
            //       );
            //     })
            SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22),
          backgroundColor: Colors.blue,
          visible: patient.id?.value?.isNotEmpty == true,
          curve: Curves.bounceIn,
          children: [
            // FAB 1
            SpeedDialChild(
                child: const Icon(Icons.calendar_today_outlined),
                backgroundColor: Colors.blue,
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                             AppointmentCreateView(patient: patient)),
                   );
                },
                label: 'Registrar Apontamento',
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blue),
            // FAB 2
            SpeedDialChild(
                child: const Icon(Icons.healing),
                backgroundColor: Colors.blue,
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                             ProcedureCreateView(patient: patient)),
                   );
                },
                label: 'Registrar Procedimento',
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blue),
            SpeedDialChild(
                child: const Icon(Icons.medical_services),
                backgroundColor: Colors.blue,
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                             MedicationStatementCreateView(patient: patient)),
                   );
                },
                label: 'Registrar declaração de medicamento',
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blue)
          ],
        ));
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
    var familyName = widget.patient.name?.first.family ?? "";
    controllername.text = firstName + " " + familyName;
    controllerbirthDate.text =
        widget.patient.birthDate?.value?.toString() ?? "";
    var telecom = widget.patient.telecom
        ?.where((element) => element.use == ContactPointUse.mobile);
    controllertelecom.text =
        telecom != null && telecom.isNotEmpty ? telecom.first.value ?? "" : "";
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
                  controller: controllerbirthDate,
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
                  controller: controllertelecom,
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
                  controller: controlleraddressline,
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
                  controller: controlleraddressdistrict,
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
                  controller: controlleraddresspostalCode,
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
                  controller: controlleraddresscity,
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
                  controller: controlleraddressstate,
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
                  controller: controlleraddresscountry,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
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
                            HumanName(
                                family: controllername.text.split(" ")[1],
                                given: [controllername.text.split(" ")[0]])
                          ],
                          birthDate: Date.fromDateTime(
                              DateTime.parse(controllerbirthDate.text)),
                          address: [
                            Address(
                                city: controlleraddresscity.text,
                                district: controlleraddressdistrict.text,
                                country: controlleraddresscountry.text,
                                state: controlleraddressstate.text,
                                line: [controlleraddressline.text],
                                postalCode: controlleraddresspostalCode.text)
                          ],
                          telecom: [
                            ContactPoint(
                                use: ContactPointUse.mobile,
                                rank: PositiveInt(1),
                                system: ContactPointSystem.phone,
                                value: controllertelecom.text)
                          ]);

                      //patient.birthDate = Date.fromDateTime(DateTime.parse(controllerbirthDate.text));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );
                      if (changedPatient.id?.value != null) {
                        PatientService.putPatient(changedPatient);
                      } else {
                        PatientService.postPatient(changedPatient);
                      }
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
