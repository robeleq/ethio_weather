import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_icons/weather_icons.dart';

import '../styles/colors.dart';

class HourlyPage extends StatefulWidget {
  final String title;

  const HourlyPage({Key? key, required this.title}) : super(key: key);

  @override
  State<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends State<HourlyPage> {
  final List<bool> _isExpanded = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 3,
        animationDuration: const Duration(milliseconds: 600),
        expansionCallback: (index, isExpanded) {
          setState(() {
            _isExpanded[index] = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "2 PM",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "22°C",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: BoxedIcon(
                              WeatherIcons.day_cloudy,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "8%",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Mostly Cloud", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.thermometer,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Feels Like',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '22°C',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.wind_beaufort_8,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Wind',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '8 Km/h',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Humidity',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '36%',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.sunrise,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'UV Index',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '6 of 10',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isExpanded: _isExpanded[0]),
          ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "3 PM",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "21°C",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: BoxedIcon(
                              WeatherIcons.day_cloudy,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "9%",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Mostly Cloud", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.thermometer,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Feels Like',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '22°C',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.wind_beaufort_8,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Wind',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '8 Km/h',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(height: 1.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Humidity',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '36%',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const BoxedIcon(
                                      WeatherIcons.sunrise,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'UV Index',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '6 of 10',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isExpanded: _isExpanded[1]),
        ],
      ),
    );
  }
}
