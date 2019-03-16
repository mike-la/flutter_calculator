import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

/// The widget for plus or minus
///

class plusMinus extends StatelessWidget {
  final String m_categoryName;
  final ColorSwatch m_categoryColor;
  double m_height;
  double m_border=10; //border around plus/minus symbol
  Calculator m_calc;

  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  plusMinus({
    Key key,
    @required this.m_categoryName,
    @required this.m_categoryColor,
    @required this.m_calc,
  })  : assert(m_categoryName != null),
        assert(m_categoryColor != null),
        assert(m_calc != null),
        super(key: key);


  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    m_height=100.0;//context.size.height;

    return Material(

        color: m_categoryColor,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
              height: m_height+m_border,
              child: new InkWell(
                borderRadius: BorderRadius.circular(50.0),
                highlightColor: m_categoryColor,
                onTap: () {
                  print('I was tapped!');
                  tapped();
                },
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                    ),
                    new Center(
                        child: Text(
                          m_categoryName,
                          style: new TextStyle(fontSize:m_height ),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              )),
        ));
  }

  void tapped(){
    m_calc.setResultTextLabel(m_categoryName);
  }

}