
import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 4),
       ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WorldStates())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: MediaQuery.of(context).size.height*.26,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Image(image: AssetImage("images/virus.png"),),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                  child: child,);
                }),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App",textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25
              ),),
            )
          ],
        ),
      ),
    );
  }
}

