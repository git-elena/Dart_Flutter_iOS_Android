import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/products_widget.dart';
import 'test_inherited.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        MaterialApp(

          home: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1!,
              child:
            Example(),

          //AppBar(child: AllProducts()),
          //PageList(),
          //UserProfile(),

        )
    );
  }
}
