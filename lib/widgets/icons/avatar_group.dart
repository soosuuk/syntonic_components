import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';

import '../../models/person_model.dart';

class AvatarGroup extends StatelessWidget {
  final List<PersonModel> persons;

  const AvatarGroup({required this.persons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: [
          for (var i = 0; i < persons.length + 1; i++)
            Row(mainAxisSize: MainAxisSize.min, children: [SizedBox(width: (i * (1 - .4) * 27).toDouble(),), Flexible(child: i < persons.length ? SyntonicPersonIcon(needsMainStaffBorder: true, person: persons[i], type: IconSize.small, hasPadding: false,) : SyntonicIcon(icon: Icons.add, padding: 0,))],)
        ],
      ),
    );
  }
}