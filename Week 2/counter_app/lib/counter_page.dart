import 'package:counter_app/utility/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCount();
  }

  void loadCount() async {
    final sp = await SharedPreferences.getInstance();
    final savedCount = sp.getInt('count') ?? 0;
    setState(() {
      count = savedCount;
    });
  }

  void saveCount() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('count', count);
  }

  void increment() {
    setState(() {
      count++;
    });
    saveCount();
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
      saveCount();
    }
  }

  void reset() {
    setState(() {
      count = 0;
      saveCount();
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
