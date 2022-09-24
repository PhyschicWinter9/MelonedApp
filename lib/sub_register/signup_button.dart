import 'package:flutter/material.dart';
import '../style/colortheme.dart';

//ปุ่ม SignUp
class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Sign Up',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              primary: ColorCustom.mediumgreencolor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
            )
          ),
        )
      ],
    );
  }
}