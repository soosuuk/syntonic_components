import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';

class SyntonicStackedBarChartVertical extends StatelessWidget {
  final double width;
  SyntonicStackedBarChartVertical({Key? key, this.width = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [
      {
        "units": 30,
        "color": Colors.pink.harmonizeWith(Theme.of(context).colorScheme.primary),
      },
      {
        "units": 70,
        "color": Colors.blueAccent.harmonizeWith(Theme.of(context).colorScheme.primary),
      },
    ];
    double maxWidth = MediaQuery.of(context).size.width - 36;
    var totalUnitNum = 0;
    for (int i = 0; i < chartData.length; i++) {
      totalUnitNum = totalUnitNum + int.parse(chartData[i]["units"].toString());
    }

    return Container(
      height: 100,
      // padding: EdgeInsets.all(80),
      child: Stack(alignment: Alignment.center, children: [Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: LinearProgressIndicator(
                minHeight: width,
                value: 0.3,
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                backgroundColor: Colors.lime,
              ),
            ),
          ),
        ],
      ),
        FittedBox(child: Column(children: [Icon(Icons.train),
          SizedBox(height: 8,),
          Body2Text(text: 'JPY 23,000', textColor: Colors.white,)],),)],),
    );
  }
}
