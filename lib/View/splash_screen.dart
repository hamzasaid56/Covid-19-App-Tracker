import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practice_covid_19/View/world_stats_screen.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 4),
      vsync:this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStats()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.height * .25,
                child: const Center(
                  child: Image(image: AssetImage('assets/virus.png'),),
                )
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                child: child,
                );
              },

            ),
            SizedBox( height: MediaQuery.of(context).size.height * .05),
         const  Align(
             alignment: Alignment.center,
             child:  Text(
                  'Covid-19\nTacking App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
           ),
          ],
        ) ,
      ),
    );
  }
}
