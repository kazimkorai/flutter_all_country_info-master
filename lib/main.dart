import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'details_screen/Country.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    var responce = await Dio().get('https://restcountries.eu/rest/v2/all');
    return responce.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountries().then(((data) {
      setState(() {
        countries = filteredCountries = data;
        print(countries.length);
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: !isSearching
              ? Text('All Countries')
              : TextField(
            onChanged: (value) {
              _filterCountries(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Search Country Here",
                hintStyle: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            isSearching ? IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  this.isSearching = false;
                  filteredCountries = countries;
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = true;
                });
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(2),
          child: filteredCountries.length>0 ?
          ListView.builder(
              itemCount: countries.length,
              itemBuilder: (BuildContext contex, int index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Country(countries, index)));
                  },
                  child: new Card(
                    elevation: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text(" " + countries[index]["name"],
                                    style: new TextStyle(
                                        fontSize: 17,
                                        color: Colors.deepPurple)),
                                new Text(countries[index]["capital"],
                                    style: new TextStyle(
                                        fontSize: 15, color: Colors.blue)),
                              ],
                            )),
                        new Flexible(
                            flex: 1,
                            child: new Container(
                              color: Colors.white,
                              height: 60,
                              width: 60,
                              child: new SvgPicture.network(
                                countries[index]["flag"],
                                height: 60,
                                width: 60,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }):Center(child: CircularProgressIndicator(),),
        ));
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
          country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
