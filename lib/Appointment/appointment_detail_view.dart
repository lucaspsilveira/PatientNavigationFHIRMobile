import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/services/AppointmentService.dart';

class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({Key? key, required this.appointment})
      : super(key: key);
  final Appointment appointment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do apontamento'),
        ),
        body: MyCustomForm(appointment: appointment));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.appointment}) : super(key: key);
  final Appointment appointment;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(appointment: this.appointment);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  Appointment appointment;
  MyCustomFormState({required this.appointment});

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
  final controllerdatescheduled = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    var status = widget.appointment.status.toString();
    controllerstatus.text = status.split(".")[1];

    //controllerserviceCategory.text = widget.appointment.serviceCategory?.first.coding?.first.display ?? "";
    //controllerServiceType.text = widget.appointment.serviceType.
    controllerSpecialty.text =
        widget.appointment.specialty?.first.coding?.first.display ?? "";
    controllerAppointmentType.text =
        widget.appointment.appointmentType?.coding?.first.code.toString() ?? "";
    controllerReason.text =
        widget.appointment.reasonReference?.first.display ?? "";
    controllerpriority.text = widget.appointment.priority.toString();
    controlleradescription.text = widget.appointment.description ?? "";
    controllerstartdate.text = widget.appointment.start.toString();
    controllerenddate.text = widget.appointment.end.toString();
    controllercomment.text = widget.appointment.comment ?? "";
    controllerdatescheduled.text = widget.appointment.start.toString() +
        "-" +
        widget.appointment.end.toString();

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerdatescheduled,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Data agendada',
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: controllerstatus,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Estado do apontamento',
                    enabled: false,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: controllerAppointmentType,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Tipo de apontamento',
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
                    controller: controllerReason,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Motivo de apontamento',
                      enabled: false,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //AppointmentService.putAppointment(appointment);
                      print(controlleradescription.text);

                      var changedAppointment = appointment.copyWith(
                          description: controlleradescription.text,
                          comment: controllercomment.text,
                          reasonReference: [
                            Reference(display: controllerReason.text)
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
                  child: const Text('Atualizar'),
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
