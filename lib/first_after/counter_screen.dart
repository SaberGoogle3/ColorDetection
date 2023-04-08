import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter=0;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed:()
                {
                setState(() {
                  counter--;
                  print(counter);
                });
                },
                child:Text('Minus')),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('$counter',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),),
            ),
            TextButton(
                onPressed:()
                {
                   setState(() {
                    counter++;
                     print(counter);
                   });
                },
                child:Text('Plus'))
          ],
        ),
      ),
    );
  }
}
