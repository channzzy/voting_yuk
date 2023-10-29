import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:voting_yuk/models/chart.dart';
import 'package:voting_yuk/providers/chart.dart';

import '../utils/style.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<ChartProvider>().fetchData(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fontColor,
          ),
        ),
        title: Text(
          "Grafik Paslon",
          style: TextStyle(
            fontSize: 16.sp,
            color: fontColor,
            fontFamily: bold,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<ChartProvider>(
          builder: (context, chart, _) {
            if (chart.chartResult == ChartResult.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (chart.chartResult == ChartResult.error) {
              return Center(
                child: Text(chart.errorMessage),
              );
            } else if (chart.chartResult == ChartResult.noData) {
              return Center(
                child: Text(chart.errorMessage),
              );
            } else if (chart.chartResult == ChartResult.hasData) {
              return Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<Data, String>>[
                      LineSeries<Data, String>(
                        color: accentColor,
                        dataSource: chart.chart.data,
                        xValueMapper: (Data data, _) =>
                            "Paslon ${data.sequence}",
                        yValueMapper: (Data data, _) => data.count,
                        name: 'Paslon',
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
