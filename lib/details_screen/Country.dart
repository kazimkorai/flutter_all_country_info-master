import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Country extends StatelessWidget {
  List countriesA = new List();
  int indexList=0;

  Country(List countries, int index) {
    countriesA = countries;
    indexList = index;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(countriesA[indexList]["name"].toString()),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      height: 300,
      width: 400,
      padding: EdgeInsets.all(10),
      child: new Card(
          elevation: 5,
          child: new Column(
            children: <Widget>[
              new Text(""),
              new Text(
                countriesA[indexList]["name"],
                style: new TextStyle(fontSize: 22, color: Colors.black),
              ),
              new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Area=",
                      style: new TextStyle(fontSize: 22),
                    ),
                    new Text("   " + countriesA[indexList]["area"].toString())
                  ]),
              new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Capital=",
                      style: new TextStyle(fontSize: 22),
                    ),
                    new Text(
                        "   " + countriesA[indexList]["capital"].toString())
                  ]),
              new Container(
                height: 150,
                width: 150,
                child: new SvgPicture.network(countriesA[indexList]["flag"]),
              )
            ],
          )),
    );
  }
}
