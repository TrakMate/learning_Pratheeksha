import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:landpage/src/ui/widgets/glassContainer.dart'; 

const List<Color> kAccentGradient = [
  Color(0xffC084FC),
  Color(0xffA855F7),
  Color(0xff6D28D9),
];

class CalendarEvent {
  final String title;
  final String description;
  final TimeOfDay? time;

  CalendarEvent({required this.title, this.description = "", this.time});
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // key = normalized (y, m, d) date
  final Map<DateTime, List<CalendarEvent>> _events = {};

  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  List<CalendarEvent> _eventsForDay(DateTime day) {
    return _events[_normalize(day)] ?? [];
  }

  void _addEvent(DateTime day, CalendarEvent event) {
    final key = _normalize(day);
    setState(() {
      _events.putIfAbsent(key, () => []).add(event);
    });
  }

  void _removeEvent(DateTime day, CalendarEvent event) {
    final key = _normalize(day);
    setState(() {
      _events[key]?.remove(event);
    });
  }

 
 
  Future<void> _showAddEventDialog() async {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    TimeOfDay? pickedTime;

    await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Colors.white.withValues(alpha: 0.18)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffA855F7).withValues(alpha: 0.2),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: kAccentGradient),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                CupertinoIcons.calendar_badge_plus,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "New Event",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDialogTextField(
                          controller: titleController,
                          hint: "Event title",
                          icon: CupertinoIcons.text_cursor,
                        ),
                        const SizedBox(height: 14),
                        _buildDialogTextField(
                          controller: descController,
                          hint: "Description (optional)",
                          icon: CupertinoIcons.doc_text,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: Color(0xffA855F7),
                                      surface: Color(0xff1A1B2E),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (time != null) {
                              setDialogState(() => pickedTime = time);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.clock,
                                    color: Colors.white70, size: 18),
                                const SizedBox(width: 10),
                                Text(
                                  pickedTime == null
                                      ? "Pick a time (optional)"
                                      : pickedTime!.format(context),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white.withValues(alpha: 0.2)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70, fontSize: 13.5),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient:
                                      const LinearGradient(colors: kAccentGradient),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (titleController.text.trim().isEmpty) {
                                      return;
                                    }
                                    _addEvent(
                                      _selectedDay,
                                      CalendarEvent(
                                        title: titleController.text.trim(),
                                        description: descController.text.trim(),
                                        time: pickedTime,
                                      ),
                                    );
                                    Navigator.pop(dialogContext);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Add Event",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.5),
        cursorColor: const Color(0xffC084FC),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Icon(icon, color: Colors.white54, size: 18),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 36),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13.5),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        ),
      ),
    );
  }

  // ===========================================================
  // Build
  // ===========================================================
  @override
  Widget build(BuildContext context) {
    final selectedEvents = _eventsForDay(_selectedDay);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/land1.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 32),
                  _buildCalendarCard(),
                  const SizedBox(height: 24),
                  _buildEventsCard(selectedEvents),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: kAccentGradient),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffA855F7).withValues(alpha: 0.4),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddEventDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(CupertinoIcons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return GlassContainer(
      radius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: kAccentGradient),
            ),
            alignment: Alignment.center,
            child: const Icon(CupertinoIcons.calendar, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 12),
          Text(
            "My Calendar",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    return GlassContainer(
      radius: 20,
      padding: const EdgeInsets.all(20),
      child: TableCalendar(
        firstDay: DateTime(2020),
        lastDay: DateTime(2035),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: _eventsForDay,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() => _calendarFormat = format);
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon:
              const Icon(CupertinoIcons.chevron_left, color: Colors.white70, size: 18),
          rightChevronIcon:
              const Icon(CupertinoIcons.chevron_right, color: Colors.white70, size: 18),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
          weekendStyle:
              GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          weekendTextStyle: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xffC084FC), width: 1.5),
          ),
          todayTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
          selectedDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: kAccentGradient),
          ),
          selectedTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          markerDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffC084FC),
          ),
          markersMaxCount: 3,
          markerSize: 5,
          markerMargin: const EdgeInsets.only(top: 4),
        ),
      ),
    );
  }

  Widget _buildEventsCard(List<CalendarEvent> events) {
    return GlassContainer(
      radius: 20,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Events on ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${events.length}",
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "No events for this day yet.",
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
            )
          else
            ...events.map((e) => _buildEventTile(e)),
        ],
      ),
    );
  }

  Widget _buildEventTile(CalendarEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: kAccentGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (event.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.5,
                    ),
                  ),
                ],
                if (event.time != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.clock,
                          color: Color(0xffC084FC), size: 13),
                      const SizedBox(width: 5),
                      Text(
                        event.time!.format(context),
                        style: GoogleFonts.poppins(
                          color: const Color(0xffC084FC),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _removeEvent(_selectedDay, event),
            child: const Icon(CupertinoIcons.xmark_circle, color: Colors.white38, size: 18),
          ),
        ],
      ),
    );
  }
}