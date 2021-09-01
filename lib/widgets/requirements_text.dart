import 'package:flutter/material.dart';

import '../theme.dart';

class RequirementsText extends StatelessWidget {
  final String requirementText;

  RequirementsText({this.requirementText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/dot.png',
              width: 12,
              height: 12,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                requirementText,
                style: requirementsTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
