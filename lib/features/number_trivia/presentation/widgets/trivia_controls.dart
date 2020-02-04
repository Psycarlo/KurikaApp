import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController controller = TextEditingController();
  String inputStr;
  
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input a number'
        ),
        onChanged: (value) {
          inputStr = value;
        },
        onSubmitted: (_) {
          addConcrete();
        },
      ),
      const SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: addConcrete,
            textTheme: ButtonTextTheme.primary,
            color: Theme.of(context).accentColor,
            child: const Text('Search'),
          )
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
            onPressed: addRandom,
            child: const Text('Get random trivia'),
          )
        ),
      ])
    ]);
  }

  void addConcrete() {
    controller.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<NumberTriviaBloc>(context)
      .add(GetTriviaForConcreteNumber(inputStr));
  }

  void addRandom() {
    controller.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<NumberTriviaBloc>(context)
      .add(GetTriviaForRandomNumber());
  }
}
