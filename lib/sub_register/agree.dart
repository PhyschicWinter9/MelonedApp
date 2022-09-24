import 'package:flutter/material.dart';
import '../style/textstyle.dart';

//agree part
class AgreeTerms extends StatelessWidget {
  const AgreeTerms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.check_circle, 
            color: Colors.grey[300],
          ),
        ),
        Row(
          children: [
            Text('Agree with',
              style: TextCustom.tiletext(),
            ),
            TextButton(
              onPressed: (){},
              child: Text('Terms & Conditions',
                style: TextCustom.tiletext2(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}