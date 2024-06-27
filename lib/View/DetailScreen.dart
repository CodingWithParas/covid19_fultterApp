import 'dart:core';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image ;
  String  name ;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test, population;

  DetailScreen({
    required this.image ,
    required this.name ,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.population,

  }) ;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                      child: Card(
                        elevation: 4,
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * .06,),
                            ReusableRow(title: 'Cases', value: widget.totalCases.toString(),),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Recovered', value:  widget.totalRecovered.toString(),),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Death', value:  widget.totalDeaths.toString(),),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Critical', value: widget.critical.toString(),),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Active', value:widget.active.toString(),),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Population', value:widget.population.toString()),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Tests', value:widget.test.toString()),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),
                            ReusableRow(title: 'Today Recover', value:widget.todayRecovered.toString()),
                            SizedBox(height: MediaQuery.of(context).size.height * .03,),


                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title, value ;
  ReusableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20 , right: 20 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),)
            ],
          ),

        ],
      ),
    );
  }
}