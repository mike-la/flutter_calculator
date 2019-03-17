// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/
import 'package:flutter/material.dart';

// You can use a relative import, i.e. `import 'category.dart';` or
// a package import, as shown below.
// More details at http://dart-lang.github.io/linter/lints/avoid_relative_lib_imports.html
import 'buttons.dart';

// TODO: Pass this information into your custom [Category] widget

/// The function that is called when main.dart is run.
void main() {
  runApp(Calculator());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class Calculator extends StatelessWidget {
  TextEditingController m_resultTextController = new TextEditingController(
    text: "",
  );

  //List with used operator (not allowed to have more than 1 operator after another)
  final List<String> operatorList = ['+','-','*','/'];
  final int maxCountCharsMathTerm=20; //max count of chars (numbers and operators in the mathematic term
  ColorSwatch colorNumber=Colors.blueGrey;
  ColorSwatch colorOperator=Colors.green;

  double lastResult=0; //last given result (for "ans")


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
          fontSize: 40.0,
          fontWeight: FontWeight.bold
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
        padding: const EdgeInsets.all(1.0),
        crossAxisSpacing: 1.0,
        crossAxisCount: 4,
        children: <Widget>[
        buttons( m_categoryName: "7", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "8", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "9", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "+", m_categoryColor: colorOperator, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "6", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "5", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "4", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "-", m_categoryColor: colorOperator, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "3", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "2", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "1", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "*", m_categoryColor: colorOperator, m_calc: this, ), //plus symbol
        buttons( m_categoryName: ".", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "0", m_categoryColor: colorNumber, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "Ans", m_categoryColor: colorNumber, m_calc: this,  ), //plus symbol
        buttons( m_categoryName: "/", m_categoryColor: colorOperator, m_calc: this, ), //plus symbol
        buttons( m_categoryName: "=", m_categoryColor: colorOperator, m_calc: this, ), //result
        buttons( m_categoryName: "DEL", m_categoryColor: colorOperator, m_calc: this, ), //delete last
        buttons( m_categoryName: "AC", m_categoryColor: colorOperator, m_calc: this, ), //delete all
        ]),
    );
  }

  /*
  set the resultTerm Text
  functionButton: "=", Ans
   */
  void setResultTextLabel(String textString) {
    if(!charIsAllowedInResultTextLabel(textString)) {
      return;
    }

    switch (textString) {
      case 'Ans':
        textString=lastResult.toString();
        break;
      case '=':
        m_resultTextController.text=result().toString();
        return;
      case 'DEL': //delete last
        String t=m_resultTextController.text;
        t=t.substring(0,t.length-1);
        m_resultTextController.text=t;
        return;
      case 'AC': //delete all
        m_resultTextController.clear();
        return;
    }

    if(m_resultTextController.text.length>maxCountCharsMathTerm){
      return;
    }

    textString =m_resultTextController.text + textString; //oold data and adding the new
    print('setOutputLabel' + textString);
    m_resultTextController.text = textString;
  }

  /*
  check, if character of the mathematic term allowed to insert, e.g. is a operator (+,-,*,/)
      yes- no new operator allowed
      no   new operator allowed
   */
  bool charIsAllowedInResultTextLabel(String input) {
    List<String> opList = new List<String>.from(operatorList);
    opList.add('.'); //here is '.' relevant, because '.' is not allowed to stand behind other operator
    //debug output
    //operatorList.forEach((fruit) => print(fruit));
    //print( operatorList[1] ); // 2

    String lastCharInput = input.substring(input.length - 1, input.length);
    //print('lastCharInputsubstring' + lastCharInput);
    //print('operatorList index' + operatorList.indexOf(lastCharInput).toString());
    if (opList.indexOf(lastCharInput) == -1) { //inserted char is no operator
      return true;
    }
    else if (m_resultTextController.text.length == 0) { //first sign cannot be operator
      return false;
    }
    //now we know, inserted char is an operator


    //check, if last char of term is an operator
    String lastCharTerm = m_resultTextController.text.substring(
        m_resultTextController.text.length - 1,
        m_resultTextController.text.length);
    //print('substring' + lastCharTerm);
    //print('operatorList Termindex' + operatorList.indexOf(lastCharTerm).toString());
    if (opList.indexOf(lastCharTerm) > -1) { //last char is no operator
      print('last char is operator' + lastCharTerm);
      return false;
    }
    else if(lastCharInput !='.'){
      return true;
    }


    //between two '.' has to stand an operator
    int iPoint = m_resultTextController.text.lastIndexOf('.'); //position od last '.'
    if (iPoint == -1) { //no point in term
      return true; //inserting of '.' is allowed
    }
    for (final o in opList) {
      if (m_resultTextController.text.indexOf(o, iPoint + 1) > -1) { //another operator between last last '.' and actual position
        print('operator' + o + "iPoint:" + iPoint.toString());
        return true;
      }
    }
    return false;
    }


    /*
    split the term (string) to list with numbers
      delimiter are operators (without '.')
     */
  double result(){
    String termString=m_resultTextController.text;

    //if last char is a operator, delete this
    String lastChar = termString.substring(termString.length - 1, termString.length);
    if (operatorList.indexOf(lastChar) != -1 || lastChar=='.') { //last char is operator
      termString=termString.substring(0,termString.length-1);
    }
    print("termString"+termString);

    //operatorList.forEach((fruit) => print(fruit.toString()));

    //loop to split termString to list
    List<double> termList=new List<double>();
    List<String> operatorTermList=new List<String>();
    int start=0;
    int end;
    while(start<=termString.length){
      start=start+1;
      int firstOperator=1000; //very big
      String actOperator="";
        for (final o in operatorList) {
          end=termString.indexOf(o.toString(), start);
          if(end<firstOperator && end>-1) {
            firstOperator = end;
            actOperator=o;
          }
        }
        if(firstOperator<=termString.length){
          //print("start"+start.toString() +", "+firstOperator.toString());
          String substring=termString.substring(start,firstOperator);
          double res=double.parse(substring);
          termList.add(res);
          //print("substring"+substring +", "+firstOperator.toString());

          operatorTermList.add(actOperator);
        }
        else{
          break; //leave loop
        }

        start=firstOperator;
      }

      //last "part number"
    String substring=termString.substring(start,termString.length);
    double res=double.parse(substring);
    termList.add(res);

    termList.forEach((fruit) => print(fruit.toString()));
    operatorTermList.forEach((fruit) => print(fruit.toString()));


    //now I have to numbers and the operators
    double result=0;


    return result;
  }

}
