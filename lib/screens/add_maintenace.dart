import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AddMaintenace extends StatelessWidget {
  const AddMaintenace({super.key});
  

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Flutter Clean Calendar Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const CalendarScreen(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'MX'),
      ],
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool showEvents = true;

  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2017), 
      lastDate: DateTime(30000));

    if(picked != null ){
      setState(() {
        datePicked.text = picked.toString().split(" ")[0];
      });
    }
  }

  final datePicked = TextEditingController();


  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent(
      'MultiDay Event A',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 12, 0),
      color: Colors.orange,
      isMultiDay: true,
    ),
    NeatCleanCalendarEvent('Event X',
        description: 'test desc',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 11, 30),
        color: Colors.lightGreen,
        isAllDay: false,
        isDone: true,
        //icon: 'assets/event1.jpg',
        wide: false),
    NeatCleanCalendarEvent('Allday Event B',
        description: 'test desc',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink,
        isAllDay: true,
        //icon: 'assets/event1.jpg',
        wide: false),
    NeatCleanCalendarEvent(
      'Normal Event D',
      description: 'test desc',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0),
      color: Colors.indigo,
      wide: true,
      //icon: 'assets/event.png',
    ),
    NeatCleanCalendarEvent(
      'Normal Event E',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 45),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      color: Colors.indigo,
      wide: true,
      //icon: 'assets/profile.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget eventCell(BuildContext context, NeatCleanCalendarEvent event,
      String start, String end) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text('Calendar Event: ${event.summary} from $start to $end'));
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          startOnMonday: true,
          weekDays: const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
          eventsList: _eventList,
          isExpandable: true,
          // You can set your own event cell builder function to customize the event cells
          // Try it by uncommenting the line below
          // eventCellBuilder: eventCell,
          eventDoneColor: Colors.deepPurple,
          selectedColor: Colors.blue,
          selectedTodayColor: Colors.green,
          todayColor: Colors.teal,
          defaultDayColor: Colors.orange,
          defaultOutOfMonthDayColor: Colors.grey,
          datePickerDarkTheme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.yellow,
              surface: Colors.grey,
              onSurface: Colors.yellow,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
          datePickerLightTheme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.teal,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
          eventColor: null,
          locale: 'es_MX',
          todayButtonText: 'Heute',
          allDayEventText: 'Ganztägig',
          multiDayEndText: 'Ende',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
          onEventSelected: (value) {
            print('Event selected ${value.summary}');
          },
          onEventLongPressed: (value) {
            print('Event long pressed ${value.summary}');
          },
          // onMonthChanged: (value) {
          //   print('Month changed $value');
          // },
          onDateSelected: (value) {
            print('Date selected $value');
          },
          onRangeSelected: (value) {
            print('Range selected ${value.from} - ${value.to}');
          },
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: const TextStyle(
              color: Colors.red, fontWeight: FontWeight.w800, fontSize: 11),
          showEventListViewIcon: true,
          showEvents: showEvents,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Maitenaice'),
            content: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 3,
                        )
                      )
                    ),
                    onPressed: () {
                      _openDatePicker(context);
                    },
                    child: const Text('Date Picker'),
                  ),
                ),
                //const SizedBox(height: 200,),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 60),
                  child: TextFormField(
                  controller: datePicked, // Aquí se asigna el controlador
                  decoration: const InputDecoration(
                    labelText: 'Fecha seleccionada',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  ),)
                
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xffb1ff85),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      pickerTitle: const Text(
        'Set Manteinance Date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime(2024, 01, 01),
      maxDateTime: DateTime(3000),
      minDateTime: DateTime(2024),
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onChange: (index) {
        //print(index);
      },
      onSubmit: (index) {
        setState(() {
        datePicked.text = index.toString().split(" ")[0];
      });
        print(index);
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }
  
}


