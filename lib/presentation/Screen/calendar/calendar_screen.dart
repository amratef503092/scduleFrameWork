
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';

import '../../../domain/bloc/Appstate/Appstate.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';


/// The hove page which hosts the calendar
class CalendarScreen extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // List<NeatCleanCalendarEvent> _todaysEvents = [
  //   NeatCleanCalendarEvent('Event A',
  //       startTime: DateTime(DateTime
  //           .now()
  //           .year, DateTime
  //           .now()
  //           .month,
  //           DateTime
  //               .now()
  //               .day, 10, 0),
  //       endTime: DateTime(DateTime
  //           .now()
  //           .year, DateTime
  //           .now()
  //           .month,
  //           DateTime
  //               .now()
  //               .day, 12, 0),
  //       description: 'A special event',
  //       color: Colors.blue[700]),
  // ];

  final List<NeatCleanCalendarEvent> _eventList = [
  NeatCleanCalendarEvent('Normal Event D',
  startTime: DateTime(DateTime.now().year, DateTime
      .now()
      .month,
  DateTime
      .now()
      .day, 14, 30),
  endTime: DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month,
  DateTime
      .now()
      .day, 17, 0),
  color: Colors.indigo),

  ] ;
  List<NeatCleanCalendarEvent> _getDataSource() {


    final List<NeatCleanCalendarEvent> meetings = [];
    for(int i = 0 ; i<AppCubit.get(context).projectModel.length;i++){
      meetings.add(
        NeatCleanCalendarEvent(AppCubit.get(context).projectModel[i].title.toString(),
            startTime: AppCubit.get(context).projectModel[i].time_upload.toDate(),
            endTime:AppCubit.get(context).projectModel[i].dead_line.toDate()
            ,
            color: Colors.indigo),
      );

    }
return meetings;
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
            body: (state is GetProjectTaskDone) ? Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Calendar(
                  startOnMonday: true,
                  weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
                  eventsList: _getDataSource(),
                  isExpandable: true,
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.pink,
                  todayColor: Colors.blue,
                  eventColor: null,
                  locale: 'de_DE',
                  todayButtonText: 'Heute',
                  allDayEventText: 'Ganztägig',
                  multiDayEndText: 'Ende',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  datePickerType: DatePickerType.date,
                  dayOfWeekStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
            ): const Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}




// /// An object to set the appointment collection data source to calendar, which
// /// used to map the custom appointment data to the calendar appointment, and
// /// allows to add, remove or reset the appointment collection.
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return _getMeetingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }
//
//   Meeting _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final Meeting meetingData;
//     if (meeting is Meeting) {
//       meetingData = meeting;
//     }
//
//     return meetingData;
//   }
// }
//
// /// Custom business object class which contains properties to hold the detailed
// /// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
// SfCalendar(
// view: CalendarView.day,
// dataSource: MeetingDataSource(_getDataSource()),
//
//
// monthViewSettings: const MonthViewSettings(
//
// appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
// )