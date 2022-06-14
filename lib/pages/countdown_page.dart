import 'dart:async';

import 'package:countdown_timer/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  static const countdownDuration = Duration(seconds: 90);
  Duration duration = Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState(){
    super.initState();

    // startTimer();
    reset();
  }
  void reset() {
    isCountdown ? setState(() => duration = countdownDuration) : setState(() => duration = Duration());
  }
  void addTime(){
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if(seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }
  
  void startTimer({bool resets = true}){
    if(resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      addTime();
    });
  }
  void stopTimer({bool resets = true}){
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
          SizedBox(height: 100,),
          buildButtons()
        ],
      ),),
    );
  }

  Widget buildTime() {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigit(duration.inHours.remainder(60));
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(width: 8,),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8,),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)

          ),
          child: Text(time,
            style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.black),),
        ),
        SizedBox(height: 20,),
        Text(header),
      ],
    );
  
  Widget buildButtons(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

     return isRunning || !isCompleted ?
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ButtonWidget(onClicked: (){
               if(isRunning) {
                 stopTimer(resets: false);
               } else {
                 startTimer(resets: false);
               }
               }, text: isRunning ? 'Stop' : "Resume", ),
             SizedBox(width: 20,),
             ButtonWidget(onClicked: () => stopTimer(), text: 'Cancel')
           ],
         )
         : ButtonWidget(onClicked: () => startTimer(), text: 'Start Timer',);
  }

}


