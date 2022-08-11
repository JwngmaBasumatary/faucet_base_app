
import 'dart:async';
import 'package:flutter/material.dart';

class TimerStopWatch extends StatefulWidget {
  final Duration durationTime;
  const TimerStopWatch({Key? key, required this.durationTime})
      : super(key: key);

  @override
  State<TimerStopWatch> createState() => _TimerStopWatchState();
}

class _TimerStopWatchState extends State<TimerStopWatch> {
  // Duration countdownDuration = const Duration(hours: 0);
  Duration duration = const Duration();
  Timer? timer;

  bool isCountDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = widget.durationTime);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;

    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;

        if (seconds < 0) {
          timer?.cancel();
        } else {
          duration = Duration(seconds: seconds);
        }
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return buildTimer();
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text("${widget.durationTime}"),
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(header)
      ],
    );
  }
}
