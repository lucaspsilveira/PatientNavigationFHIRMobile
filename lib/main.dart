import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:patient_navigation_fhir_mobile/Appointment/appointment_create_view.dart';
import 'package:patient_navigation_fhir_mobile/procedure/procedure_create_view.dart';
import 'package:patient_navigation_fhir_mobile/procedure/procedure_main_page.dart';

import 'Appointment/appointment_main_page.dart';
import 'Patient/patient_detail_view.dart';
import 'Patient/patient_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Navigation FHIR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Patient Navigation FHIR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  
  

  static const List<Widget> _widgetOptions = <Widget>[
    PatientMainPage(),
    AppointmentMainPage(),
    ProcedureMainPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<FloatingActionButton> _floatingButtonsList = <FloatingActionButton>[
      
      FloatingActionButton(
          onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientDetailView(patient: Patient())),
                        );
                },
          backgroundColor: Colors.green,
          child: const Icon(Icons.person_add,
        ),
      ),
      FloatingActionButton(
          onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentCreateView()),
                        );
                },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.date_range,
        ),
      ),
      FloatingActionButton(
           onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcedureCreateView(patient: Patient())),
                        );
                },
          backgroundColor: Colors.red,
          child: const Icon(Icons.medication_outlined
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      floatingActionButton: _floatingButtonsList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Apontamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Procedimentos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}