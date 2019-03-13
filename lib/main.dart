// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/
import 'package:flutter/material.dart';

// You can use a relative import, i.e. `import 'category.dart';` or
// a package import, as shown below.
// More details at http://dart-lang.github.io/linter/lints/avoid_relative_lib_imports.html
import 'plusMinus.dart';

// TODO: Pass this information into your custom [Category] widget

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Taschenrechner von Mike"),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.green[100],
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: <Widget>[ //List with different widgets
            plusMinus(m_categoryName: "+",m_categoryColor: Colors.green,), //plus symbol
            const Text('Heed not the rabble'),
            const Text('Sound of screams but the'),
            const Text('Who scream'),
            const Text('Revolution is coming...'),
            const Text('Revolution, they...'),
          ]),
      ),
    );
  }

}