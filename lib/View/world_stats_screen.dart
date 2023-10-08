import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:practice_covid_19/Models/Services/stats_services.dart';

import '../Models/WorldStatsModel.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync:this)..repeat();
  final colorList =<Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const  Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices _statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
             SizedBox(height:  MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                future: _statsServices.fetchWorldStatsApi(),
                  builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          size: 50,
                          controller: _controller,
                          color: Colors.white,
                        ),
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                              dataMap: {
                                'Total': double.parse(snapshot.data!.cases.toString()),
                                'Recovered': double.parse(snapshot.data!.recovered.toString()),
                                'Deaths': double.parse(snapshot.data!.deaths.toString()),
                              },
                            chartType: ChartType.ring,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            colorList: colorList,
                            animationDuration: Duration(milliseconds: 1200),
                            chartRadius: MediaQuery.of(context).size.width /3.2 ,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                              ),
                          SizedBox(height:  MediaQuery.of(context).size.height * .02,),
                          Padding(
                            padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .03),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: "Total Cases", value:snapshot.data!.cases.toString()),
                                  ReusableRow(title: "Total Recovered", value:snapshot.data!.recovered.toString()),
                                  ReusableRow(title: "Critical", value:snapshot.data!.critical.toString()),
                                  ReusableRow(title: "Countries Affected", value:snapshot.data!.affectedCountries.toString()),
                                  ReusableRow(title: "Today Cases", value:snapshot.data!.todayCases.toString()),
                                  ReusableRow(title: "Total Deaths", value:snapshot.data!.todayDeaths.toString()),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .03,),
                          InkWell(
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 5
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
         const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}

