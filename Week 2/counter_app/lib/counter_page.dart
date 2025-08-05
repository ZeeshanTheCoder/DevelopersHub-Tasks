import 'package:counter_app/utility/custom_button.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading

            Text(
              'Counter App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Counter Value

            Text(
              count.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Increment Button
                CustomButton(
                  onPressed: () {
                    increment();
                  },
                  icon: Icons.add,
                ),

                // Decrement Button
                CustomButton(
                  onPressed: () {
                    decrement();
                  },
                  icon: Icons.remove,
                ),

                // Reset Button
                CustomButton(
                  onPressed: () {
                    reset();
                  },
                  icon: Icons.restore,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
