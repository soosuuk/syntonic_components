import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';

class SyntonicStackedBarChart extends StatelessWidget {
  const SyntonicStackedBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [
      {
        "units": 50,
        "color":
            Colors.pink.harmonizeWith(Theme.of(context).colorScheme.primary),
      },
      {
        "units": 10,
        "color":
            Colors.purple.harmonizeWith(Theme.of(context).colorScheme.primary),
      },
      {
        "units": 70,
        "color": Colors.purpleAccent
            .harmonizeWith(Theme.of(context).colorScheme.primary),
      },
      {
        "units": 100,
        "color": Colors.blueAccent
            .harmonizeWith(Theme.of(context).colorScheme.primary),
      },
    ];
    double maxWidth = MediaQuery.of(context).size.width - 36;
    var totalUnitNum = 0;
    for (int i = 0; i < chartData.length; i++) {
      totalUnitNum = totalUnitNum + int.parse(chartData[i]["units"].toString());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Row(
              children: [
                for (int i = 0; i < chartData.length; i++)
                  i == chartData.length - 1
                      ? Expanded(
                          child: SizedBox(
                            height: 24,
                            child: ColoredBox(
                              color: chartData[i]["color"],
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: chartData[i]["units"] /
                                  totalUnitNum *
                                  maxWidth,
                              height: 24,
                              child: ColoredBox(
                                color: chartData[i]["color"],
                              ),
                            ),
                            // const SizedBox(width: 6),
                          ],
                        )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: OverlineText(
                text: 'Total: JPY 120,300',
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
