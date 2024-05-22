import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';

import '../../models/person_model.dart';

class AvatarGroup extends StatelessWidget {
  final List<PersonModel> persons;
  final VoidCallback? onPressed;

  const AvatarGroup({required this.persons, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onPressed, child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        for (var i = 0; i < persons.length + 1; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: (i * (1 - .4) * 18).toDouble(),
              ),
              Flexible(
                  child: i < persons.length
                      ? SyntonicPersonIcon(
                    needsMainStaffBorder: true,
                    person: persons[i],
                    type: IconSize.mini,
                    hasPadding: false,
                  )
                      : onPressed != null ? const SyntonicIcon(
                    isFilledColor: true,
                    hasBorder: true,
                    icon: Icons.add,
                    padding: 0,
                  ) : SizedBox())
            ],
          )
      ],
    ),);
  }
}
