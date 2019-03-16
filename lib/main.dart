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
  runApp(Calculator());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class Calculator extends StatelessWidget {
  TextEditingController m_resultTextController = new TextEditingController(
    text: "test",
  );

  //List with used operator (not allowed to have more than 1 operator after another)
  final List<String> operatorList = ['+','-','*','/'];
  final int maxCountCharsMathTerm=10; //max count of chars (numbers and operators in the mathematic term



  @override
  Widget build(BuildContext context) {
    Container topSection = this.createTopSection();
    Expanded middleSection = this.createMiddleSection();


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Taschenrechner von Mike"),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.green[100],
        body:  Column(
            children: <Widget>[
              topSection,
              middleSection,
            ]),

      ),
    );
  }

  Container createTopSection(){
    return Container(
      child: new TextField( //TextField for the mathematic term
        style: new TextStyle(
          color: Colors.red,
          fontSize: 25.0,
        ),
        enabled: false,
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        controller: m_resultTextController,
        textAlign: TextAlign.center,
      ),
    );
  }

  Expanded createMiddleSection(){
    return new Expanded(child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(5.0),
        crossAxisSpacing: 1.0,
        crossAxisCount: 2,
        children: <Widget>[
        plusMinus(
          m_categoryName: "+",
          m_categoryColor: Colors.green,
          m_calc: this,
        ), //plus symbol
        const Text('Heed not the rabble'),
        const Text('Sound of screams but the'),
        const Text('Who scream'),
        const Text('Revolution is coming...'),
        const Text('Revolution, they...'),
        ]),
    );
  }

  /*
  set the resultTerm Text
   */
  void setResultTextLabel(String textString) {

    if(charIsAllowedInResultTextLabel(textString)){
      textString =m_resultTextController.text + textString; //oold data and adding the new
      print('setOutputLabel' + textString);
      m_resultTextController.text = textString;
    }
  }

  /*
  check, if character of the mathematic term allowed to insert, e.g. is a operator (+,-,*,/)
      yes- no new operator allowed
      no   new operator allowed
   */
  bool charIsAllowedInResultTextLabel(String input) {
    if(m_resultTextController.text.length==0){ //else excepton, when text field is empty
      return true;
    }

    //debug output
    operatorList.forEach((fruit) => print(fruit));
    print('operator liste'+operatorList.length.toString());
    //print( operatorList[1] ); // 2

    String lastCharInput=input.substring(input.length-1,input.length);
    print('lastCharInputsubstring' + lastCharInput);
    print('operatorList index' + operatorList.indexOf(lastCharInput).toString());
    if(operatorList.indexOf(lastCharInput)==-1){ //inserted char is no operator
      return true;
    }

    //check, if last char of term is an operatpor
    String lastCharTerm=m_resultTextController.text.substring(m_resultTextController.text.length-1,m_resultTextController.text.length);
    print('substring' + lastCharTerm);
    print('operatorList Termindex' + operatorList.indexOf(lastCharTerm).toString());
    if(operatorList.indexOf(lastCharTerm)==-1){ //inserted char is no operator
      return true;
    }

    print('last char is operator' + lastCharTerm);
    return false;
  }
}
