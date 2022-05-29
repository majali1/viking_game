import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';

class VKCounter extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final Function onChanged;

  const VKCounter(
      {Key? key,
      required this.initialValue,
      required this.minValue,
      required this.maxValue,
      required this.step,
      required this.onChanged})
      : super(key: key);

  @override
  _VKCounterState createState() => _VKCounterState();
}

class _VKCounterState extends State<VKCounter> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
  }

  void increment() {
    setState(() {
      if (counter < widget.maxValue) counter++;
    });
    widget.onChanged(counter);
  }

  void decrement() {
    setState(() {
      if (counter > widget.minValue) counter--;
    });
    widget.onChanged(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => decrement(),
              icon: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              )),
          Text('${counter.toInt()}',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.BaiJamjureeMedium,
                  fontSize: 20)),
          IconButton(
            onPressed: () => increment(),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
