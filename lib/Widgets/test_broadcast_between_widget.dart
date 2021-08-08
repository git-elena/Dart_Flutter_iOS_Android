

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: const SimpleCalcWidget()
      ),
    );
  }
}

class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  _SimpleCalcWidgetState createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final _model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Padding (
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalcWidgetProvider(
          model: _model,
          child: Column (
            mainAxisSize: MainAxisSize.min,
            children: [
              const FirstNumberWidget(),
              const SizedBox(height: 10,),
              const SecondNumberWidget(),
              const SizedBox(height: 10,),
              const SumButtonWidget(),
              const SizedBox(height: 10,),
              const ResultWidget()
            ],
          ),
        ),
      ),
    );
  }
}
class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => SimpleCalcWidgetProvider.of(context)?.firstNumber = value,
    );
  }
}
class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => SimpleCalcWidgetProvider.of(context)?.secondNumber = value,
    );
  }
}
class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => SimpleCalcWidgetProvider.of(context)?.sum(),
        child: const Text('Порахувать')
    );
  }
}
// class ResultWidget extends StatefulWidget {
//   const ResultWidget({Key? key}) : super(key: key);
//
//   @override
//   _ResultWidgetState createState() => _ResultWidgetState();
// }
//
// class _ResultWidgetState extends State<ResultWidget> {
//   String _value = '-1';
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     final model = SimpleCalcWidgetProvider.of(context)?.model;
//     model?.addListener(() {
//       _value = '${model.sumResult}';
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final value = SimpleCalcWidgetProvider.of(context)?.model.sumResult ?? 0;
//     return Text('Результат $value');
//   }
// }

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcWidgetProvider.of(context)?.sumResult ?? 0;
    return Text('Результат $value');
  }
}


// TODO Business Logic
class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void sum() {
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = null;
    }
    if (this.sumResult != sumResult) {
      this.sumResult = sumResult;
      notifyListeners();
    }
  }
}

// TODO Data Provider
class SimpleCalcWidgetProvider extends InheritedNotifier<SimpleCalcWidgetModel> {
  final SimpleCalcWidgetModel model;

  const SimpleCalcWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
      key: key,
      notifier: model,
      child: child);

  static SimpleCalcWidgetModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()?.model;
  }
}