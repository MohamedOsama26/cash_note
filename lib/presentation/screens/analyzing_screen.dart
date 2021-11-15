import 'package:cash_note/logic/data/item_data.dart';
import 'package:cash_note/logic/models/item_data_model.dart';
import 'package:cash_note/presentation/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyzingScreen extends StatefulWidget {
  @override
  _AnalyzingScreenState createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  DatabaseHandler db = DatabaseHandler();
  late TooltipBehavior _tooltipBehavior1,_tooltipBehavior2;
  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior1 = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape:
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))
        ),
        title: Text('Analysis',style: TextStyle(fontSize: 25),),
        backgroundColor: Color(0xff4f6ef4),
        shadowColor: Color(0xff4f6ef4),
      ),
      drawer: sideDrawer(context: context),
      body: Container(
        child: FutureBuilder(
          future: db.readItems(),
          builder: (BuildContext futureBuilderContext,
              AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              List<SalesData> itemsSumIn = [];
              List<SalesData> itemsSumOut = [];

              var i, y;
              for (i = 0; i < (snapshot.data?.length); i++) {
                var sum = snapshot.data![i].amount;
                var date = snapshot.data![i].creationDate;
                for (y = 0; y < snapshot.data?.length; y++) {
                  if (snapshot.data![i].creationDate ==
                          snapshot.data![y].creationDate &&
                      i != y) {
                    sum += snapshot.data![y].amount;
                  }
                }
                if (snapshot.data![i].type == 'income')
                  itemsSumIn.add(SalesData(date, sum));
                else
                  itemsSumOut.add(SalesData(date, sum));
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Income'),
                      series: <ChartSeries>[
                        LineSeries<SalesData, String>(
                          name: 'Income',
                          color: Color(0xFF07B100),
                          dataSource: itemsSumIn,
                          xValueMapper: (SalesData sales, _) => sales.month,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                        ),
                      ],
                      tooltipBehavior: _tooltipBehavior1,
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    child: SfCartesianChart(
                      title: ChartTitle(
                        text: 'Expense',
                      ),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        LineSeries<SalesData, String>(
                          name: 'Expense',
                          color: Color(0xFFFF0000),
                          dataSource: itemsSumOut,
                          xValueMapper: (SalesData sales, _) => sales.month,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                        )
                      ],
                      tooltipBehavior: _tooltipBehavior2,
                    ),
                  ),
                ],
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double? sales;
}
