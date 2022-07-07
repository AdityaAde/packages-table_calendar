import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarBody(),
    );
  }
}

class CalendarBody extends StatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  String? text = '', titleText = '';
  CalendarController controller = CalendarController();
  Color viewHeaderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          // Kalender
          _calenderView(viewHeaderColor, controller, (tes) {}),
          const SizedBox(height: 30),
          // Category Event
          _categoryEvent(),
          const SizedBox(height: 30),
          // Event
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Kamis, 7 Juli'),
                const SizedBox(height: 15),
                Row(
                  children: const [
                    CircleAvatar(radius: 5, backgroundColor: Colors.blue),
                    SizedBox(width: 7),
                    Text("Dividen"),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: _getDataSource().length,
                      itemBuilder: (context, index) {
                        final item = _getDataSource()[index];
                        return Text(item.eventName!);
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _calenderView(Color viewHeaderColor, CalendarController controller, CalendarTapCallback? calendarTapped) {
    return SfCalendar(
      controller: controller,
      viewHeaderStyle: ViewHeaderStyle(backgroundColor: viewHeaderColor),
      cellBorderColor: Colors.transparent,
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
      onTap: calendarTapped,
    );
  }

  Widget _categoryEvent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Row(
            children: const [
              CircleAvatar(backgroundColor: Colors.blue, radius: 4),
              SizedBox(width: 3),
              Text('Dividen'),
            ],
          ),
          const SizedBox(width: 15),
          Row(
            children: const [
              CircleAvatar(backgroundColor: Colors.yellow, radius: 4),
              SizedBox(width: 3),
              Text('RUPS'),
            ],
          ),
          const SizedBox(width: 15),
          Row(
            children: const [
              CircleAvatar(backgroundColor: Colors.red, radius: 4),
              SizedBox(width: 3),
              Text('Lap. Keuangan'),
            ],
          ),
          const SizedBox(width: 15),
          Row(
            children: const [
              CircleAvatar(backgroundColor: Colors.green, radius: 4),
              SizedBox(width: 3),
              Text('IPO'),
            ],
          ),
        ],
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.header) {
      text = DateFormat('MMMM yyyy').format(details.date!).toString();
      titleText = 'Header';
    } else if (details.targetElement == CalendarElement.viewHeader) {
      text = DateFormat('EEEE dd, MMMM yyyy').format(details.date!).toString();
      titleText = 'View Header';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      text = DateFormat('EEEE dd, MMMM yyyy').format(details.date!).toString();
      titleText = 'Calendar cell';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(" $titleText"),
            content: Text(" $text"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('close'))
            ],
          );
        });
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting(
        eventName: 'Dividen',
        from: DateTime(today.year, today.month, today.day),
        to: endTime,
        background: Colors.blue,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    Meeting(
      eventName: 'RUPS',
      from: DateTime(today.year, today.month, today.day),
      to: endTime,
      background: Colors.yellow,
      isAllDay: false,
      emiten: [
        Emiten(emitenName: '', codeEmiten: 'JTPE'),
        Emiten(emitenName: '', codeEmiten: 'INDS'),
        Emiten(emitenName: '', codeEmiten: 'AMAG'),
      ],
    );
    meetings.add(
      Meeting(
        eventName: 'RUPS',
        from: DateTime(today.year, today.month, today.day + 10),
        to: endTime,
        background: Colors.yellow,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'IPO',
        from: DateTime(today.year, today.month, today.day + 10),
        to: endTime,
        background: Colors.green,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'Lap. Keuangan',
        from: DateTime(today.year, today.month, today.day + 10),
        to: endTime,
        background: Colors.red,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'Lap. Keuangan',
        from: DateTime(today.year, today.month, today.day + 20),
        to: endTime,
        background: Colors.red,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'IPO',
        from: DateTime(today.year, today.month, today.day + 20),
        to: endTime,
        background: Colors.green,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'IPO',
        from: DateTime(today.year, today.month, today.day + 25),
        to: endTime,
        background: Colors.green,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );
    meetings.add(
      Meeting(
        eventName: 'RUPS',
        from: DateTime(today.year, today.month, today.day + 25),
        to: endTime,
        background: Colors.yellow,
        isAllDay: false,
        emiten: [
          Emiten(emitenName: '', codeEmiten: 'JTPE'),
          Emiten(emitenName: '', codeEmiten: 'INDS'),
          Emiten(emitenName: '', codeEmiten: 'AMAG'),
        ],
      ),
    );

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay, this.emiten});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  List<Emiten>? emiten;
}

class Emiten {
  String? emitenName;
  String? codeEmiten;

  Emiten({this.emitenName, this.codeEmiten});
}
