import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_client_application/Widgets/test_broadcast_between_widget.dart';

import 'model/products_widget.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        MaterialApp(

          home: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1!,
              child: Example(),
              // AllProducts(),
          // AppBar(child: AllProducts()),
          // PageList(),
          // UserProfile(),

        )
    );
  }
}
