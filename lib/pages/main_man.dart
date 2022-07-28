
import 'package:flutter/material.dart';

class MainMan extends StatelessWidget {
  const MainMan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Man")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
              child: const Text('Vendors'),
              onPressed: () {
                Navigator.pushNamed(context, '/vendors');
              },
            )
          ],
        ),
      ),
    );
  }
}