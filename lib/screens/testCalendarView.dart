import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:intl/intl.dart';
import 'package:inventario/widgets/cupertino_date_textbox.dart';

import '../Json/events.dart';
import '../Json/listP.dart';
import '../config/constants/enviroment.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: Enviroment.apiUrl, // Cambia esto a tu URL de API
  ),
);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late List<Events> events = [];
  List<ListP> items = [];
  late List<CalendarEventData> calendarEvents = [];
  DateTime _selectedDateTime = DateTime.now();
  String? _selectedPrinter; 
  String message = '';
  late List<String> selectedEvents;
  DateTime selectedDay = DateTime.now();
  

  @override
  void initState() {
    super.initState();
    loadEvents(); 
    //selectedDay = DateTime.now();
    getData();// Cargar eventos al iniciar
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> sendData() async {
    final data = {
      'date': _selectedDateTime.toString(),
      'printer': _selectedPrinter,
      'option': 'insert',
    };

    try {
      final response = await dio.post('/maintenance.php', data: data);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        message = data['status'].toString();
        if (message == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Element added successfully'),
                duration: Duration(seconds: 3),
              ),
            );
            await loadEvents();
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error adding element'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      } else {
        debugPrint('Failed to send data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> loadEvents() async {
    try {
      final response = await dio.get('/event.php'); // Cambia esto a tu endpoint de eventos
      final List<dynamic> jsonResponse = json.decode(response.data);
      setState(() {
        events = jsonResponse.map<Events>((item) => Events.fromJson(item)).toList();
        calendarEvents = events.map((event) {
          DateTime eventDate = DateTime.parse(event.fechaHora);
          return CalendarEventData(
            title: 'mntto: ${event.namePrinter}',
            date: eventDate,
            endDate: eventDate.add(const Duration(hours: 1)), // Duración del evento
          );
        }).toList();
      });
    } catch (e) {
      debugPrint('Error loading events: $e');
    }
  }

  Future<void> getData() async {
    final response = await dio.get('/getPrinters.php');
    final List<dynamic> jsonResponse = json.decode(response.data);
    setState(() {
      items = jsonResponse.map<ListP>((item) => ListP.fromJson(item)).toList();
      if (items.isNotEmpty) {
        _selectedPrinter = items[0].name; // Establece el primer item como seleccionado
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Eventos'),
      ),
      body: MonthView(
        controller: EventController()..addAll(calendarEvents),
        onCellTap: (events, date) {
          // Manejar el evento de selección de fecha
          print('Selected date: $date');
          print('Events: $events');
        },
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Maintenance'),
            content: SizedBox(
              width: 400,
              height: 400,
              child: Column(
                children: [
                  const Text('Fecha de Mantenimiento'),
                  CupertinoDateTextBox(
                    initialValue: _selectedDateTime,
                    onDateChange: onBirthdayChange,
                    hintText: DateFormat.yMd().format(_selectedDateTime),
                  ),
                  const SizedBox(height: 20),
                  const Text('Printer:'),
                  CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: 32,
                        scrollController: FixedExtentScrollController(
                          initialItem: items.indexWhere((item) => item.name == _selectedPrinter),
                        ),
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedPrinter = items[selectedItem].name;
                          });
                        },
                        children: List.generate(items.length, (int index) {
                          return Center(
                            child: Text(items[index].name), 
                          );
                        }),
                      ),
                    ),
                    child: Text(
                      _selectedPrinter ?? "Select a printer",
                      style: const TextStyle(
                        color: Color(0xff364461),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: sendData,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }

}