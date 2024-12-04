import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../widgets/cupertino_date_textbox.dart';

// ignore: must_be_immutable
class AddMaintenace extends StatefulWidget {

  const AddMaintenace({super.key});

  @override
  State<AddMaintenace> createState() => _AddMaintenaceState();
}

class _AddMaintenaceState extends State<AddMaintenace> {
   DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
    final selectedText = Text('You selected: $formattedDate');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Eventos'),
      ),
      body: Container(
        width: 800, // Ancho fijo
        height: 480,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CalendarScreen(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Add Maitenaice'),
                    content: Stack(
                      children: [
                        //const SizedBox(height: 200,),
                        SizedBox(
                          width: 400,
                          height: 400,
                          child: Column(
                            children: [
                              const Text('Fecha de Maitenace'),
                              CupertinoDateTextBox(initialValue:  _selectedDateTime, onDateChange: onBirthdayChange, hintText:  DateFormat.yMd().format(_selectedDateTime)),
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  ),
                ),
                backgroundColor: const Color(0xffb1ff85),
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

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  
  late Map<DateTime, List<String>> events;
  late List<String> selectedEvents;
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    events = {
      DateTime.utc(2024, 1, 1): ['Evento 1', 'Evento 2'],
      DateTime.utc(2024, 5, 28): ['Evento 1', 'Evento 2', 'Evento 3'],
      // Agrega más eventos aquí
    };
    DateTime now = DateTime.now();
    selectedDay = now.isBefore(DateTime.utc(2024, 12, 31)) ? now : DateTime.utc(2024, 12, 31);

    selectedEvents = events[selectedDay] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      selectedEvents = events[selectedDay] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
      return Column(
        children: [
          Container(
            width: constraints.maxWidth,
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              onDaySelected: onDaySelected,
              eventLoader: (day) => events[day] ?? [],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Eventos en ${selectedDay.toLocal()}'.split(' ')[0],
            style: TextStyle(fontSize: constraints.maxWidth > 600 ? 24 : 20, fontWeight: FontWeight.bold),
          ),
          ...selectedEvents.map((event) => ListTile(
                title: Text(event),
              )),
        ],
      );
      }
    );
  }
}


