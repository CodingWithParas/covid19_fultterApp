
import 'package:covid_tracker/View/countries.dart';
import 'package:covid_tracker/services/State%20Services/States_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("COVID-19"),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.01,),
          FutureBuilder(
              future: statesServices.fetchWorldStatesRecord(),
              builder: (context, AsyncSnapshot<WorldStatesModel>snapshot){
            if(!snapshot.hasData){
              return Expanded(
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: Colors.black,
                      size: 50,
                      controller: _controller,
                    ),
                  ) );
            }else{
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    children: [
                      PieChart(dataMap: {
                        "Total"  : double.parse(snapshot.data!.cases.toString()),
                        "Recovered" : double.parse(snapshot.data!.recovered.toString()),
                        "Deaths" : double.parse(snapshot.data!.deaths.toString()),
                      },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: 160,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                        ),
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: [Color(0xff4285F4),
                          Color(0xff1aa260),
                          Color(0xffde5246),],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              ResuableRow(title: "Total", value: snapshot.data!.cases.toString()),
                              ResuableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                              ResuableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                              ResuableRow(title: "Active", value: snapshot.data!.active.toString()),

                              ResuableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                              ResuableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),

                              ResuableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),

                              ResuableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),

                              ResuableRow(title: "Affected Countries", value: snapshot.data!.affectedCountries.toString()),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                        },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                            backgroundColor: Color(0xff1aa260),
                            overlayColor: Colors.black
                          ),
                          child: Text("Track Countries", style: TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.w300),),),
                      )
                    ],
                  ),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ],
          ),

        ],
      ),
    );
  }
}

