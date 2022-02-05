import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_navigation_fhir_mobile/services/AppointmentService.dart';

class AppointmentCreateView extends StatelessWidget {
  const AppointmentCreateView({Key? key, required this.patient}) : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Criação de um apontamento'),
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

  final controllerstatus = TextEditingController();
  final controllerserviceCategory = TextEditingController();
  final controllerServiceType = TextEditingController();
  final controllerSpecialty = TextEditingController();
  final controllerAppointmentType = TextEditingController();
  final controllerReason = TextEditingController();
  final controllerpriority = TextEditingController();
  final controlleradescription = TextEditingController();
  final controllerstartdate = TextEditingController();
  final controllerenddate = TextEditingController();
  final controllercomment = TextEditingController();

  final List<String> _locations = AppointmentStatus.values
      .map((e) => e.toString().split(".")[1])
      .toList(); // Option 2
  final List<String> _locationsType = [
    "CHECKUP",
    "EMERGENCY",
    "FOLLOWUP",
    "ROUTINE",
    "WALKIN"
  ]; // Option 2
  String _selectedLocation = 'booked'; // Option 2
  String _selectedLocationType = 'CHECKUP'; // Option 2

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    //controllerserviceCategory.text = widget.appointment.serviceCategory?.first.coding?.first.display ?? "";
    //controllerServiceType.text = widget.appointment.serviceType.

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerstartdate,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Início da consulta',
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerenddate,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Duração da consulta em horas',
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
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text("Estado do apontamento")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: DropdownButton(
                  hint: const Text(
                      'Please choose a status'), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue.toString();
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text("Tipo de apontamento")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: DropdownButton(
                  hint: const Text(
                      'Please choose a status'), // Not necessary for Option 1
                  value: _selectedLocationType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocationType = newValue.toString();
                    });
                  },
                  items: _locationsType.map((location) {
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
                    controller: controllerReason,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Motivo de apontamento',
                      enabled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Esse campo não pode ser vazio';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 3,
                  controller: controlleradescription,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Descrição',
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
                  minLines: 2,
                  maxLines: 3,
                  controller: controllercomment,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Comentário',
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
                      //AppointmentService.putAppointment(appointment);
                      print(controlleradescription.text);

                      var changedAppointment = Appointment(
                          description: controlleradescription.text,
                          comment: controllercomment.text,
                          reasonReference: [
                            Reference(display: controllerReason.text)
                          ],
                          start: Instant.fromDateTime(
                              DateTime.parse(controllerstartdate.text)),
                          end: Instant.fromDateTime(
                              DateTime.parse(controllerstartdate.text).add(
                                  Duration(
                                      hours:
                                          int.parse(controllerenddate.text)))),
                          appointmentType: CodeableConcept(coding: [
                            Coding(code: Code(_selectedLocationType))
                          ]),
                          status: AppointmentStatus.values
                              .where((element) =>
                                  element.name == _selectedLocation)
                              .first,
                          participant: [
                            AppointmentParticipant(
                                status: AppointmentParticipantStatus.accepted,
                                actor: Reference(display: "nome do paciente"))
                          ]);
                      //appointment.birthDate = Date.fromDateTime(DateTime.parse(controllerbirthDate.text));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Realizando ação')),
                      );
                      if (changedAppointment.id?.value != null) {
                        AppointmentService.putAppointment(changedAppointment);
                      } else {
                        AppointmentService.postAppointment(changedAppointment);
                      }
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

// class AppointmentArguments {
//   final Appointment appointment;

//   AppointmentArguments(this.appointment);
// }
