import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

  LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)
            )
        )
    );
  }
}
