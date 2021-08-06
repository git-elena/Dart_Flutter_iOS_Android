import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: const DataOwnerStateful()),
      ),
    );
  }

}

// TODO Data Owner - FUL
class DataOwnerStateful extends StatefulWidget {
  const DataOwnerStateful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DataOwnerStatefulState();
}
// TODO - FUL State Data Owner
class _DataOwnerStatefulState extends State<DataOwnerStateful> {
  var _value1 = 0;
  var _value2 = 0;

  void _incriment1() {
    _value1 += 1;
    setState(() {

    });
  }

  void _incriment2() {
    _value2 += 1;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed:  _incriment1,
            child: const Text('Жми рас')
        ),
        ElevatedButton(
            onPressed:  _incriment2,
            child: const Text('Жми два')
        ),
        DataProviderInherited(
            value1: _value1,
            value2: _value2,
            child: const DataConsumerStateless()),
      ],
    );
  }

}

// TODO Data Con Summer - LESS
class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>()
        ?.value1 ??
        0;

        //.findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$value'),
        const  DataConsumerStateful(),
        ],
      ),
    );
  }
}

// TODO Data Con Summer - FUL
class DataConsumerStateful extends StatefulWidget{
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  _DataConsumerStatefulState createState() => _DataConsumerStatefulState();
}
// TODO - FUL State < T >
class _DataConsumerStatefulState extends  State<DataConsumerStateful> {

  @override
  Widget build(BuildContext context) {
    // final element = context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
    // if (element != null) {
    //   context.dependOnInheritedElement(element);
    // }
    // final dataProvider = element?.widget as DataProviderInherited;
    // final value = dataProvider.value;

    //final value = getInherit<DataProviderInherited>(context)?.value ?? 0;

      //.findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
  final value = context
      .dependOnInheritedWidgetOfExactType<DataProviderInherited>()
      ?.value2 ??
      0;
  return Text('$value');
  }

}

// T? getInherit<T>(BuildContext context) {
//   final element = context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
//   final widget = element?.widget;
//   if (widget is T) {
//     return widget as T;
//   } else {
//     return null;
//   }
// }

class DataProviderInherited extends InheritedWidget {

  final int value1;
  final int value2;

  const DataProviderInherited({
    Key? key,
    required this.value1,
    required this.value2,
    required Widget child,
  }) : super(key: key, child: child);

  // static DataProviderInherited of(BuildContext context) {
  //   final DataProviderInherited? result =
  //       context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  //   assert(result != null, 'No DataProviderInherited found in context');
  //   return result!;
  // }

  @override
  bool updateShouldNotify(DataProviderInherited old) {
    return value1 != old.value1 || value2 != old.value2;
  }
}