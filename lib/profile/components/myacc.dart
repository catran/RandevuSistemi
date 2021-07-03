import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class myacc extends StatelessWidget {
  const myacc({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 21.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
