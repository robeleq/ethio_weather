import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../styles/colors.dart';

class WeeklyPage extends StatefulWidget {
  final String title;

  const WeeklyPage({Key? key, required this.title}) : super(key: key);

  @override
  State<WeeklyPage> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
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
                              "Today",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "22°/8°",
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
                              "4%",
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
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text("Sat 26 | Day ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: const <Widget>[
                            Text("23°",
                                style: TextStyle(
                                  fontSize: 24,
                                )),
                            SizedBox(
                              width: 16.0,
                            ),
                            BoxedIcon(
                              WeatherIcons.day_cloudy,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            )
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.raindrops,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("4%",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.wind_beaufort_0,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("19 Km/h",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text("Sat 26 | Night ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: const <Widget>[
                            Text("8°",
                                style: TextStyle(
                                  fontSize: 24,
                                )),
                            SizedBox(
                              width: 16.0,
                            ),
                            BoxedIcon(
                              WeatherIcons.night_alt_cloudy,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            )
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.raindrops,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("6%",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.wind_beaufort_0,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("16 Km/h",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                                            '76%',
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
                                            '0 of 10',
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
                              "Sun 27",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "24°/8°",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: BoxedIcon(
                              WeatherIcons.day_sunny,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "5%",
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
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text("Sun 27 | Day ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: const <Widget>[
                            Text("24°",
                                style: TextStyle(
                                  fontSize: 24,
                                )),
                            SizedBox(
                              width: 16.0,
                            ),
                            BoxedIcon(
                              WeatherIcons.day_sunny,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            )
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.raindrops,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("5%",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.wind_beaufort_0,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("E 20 Km/h",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                                            '45%',
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
                                            '9 of 10',
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text("Sun 27 | Night ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: const <Widget>[
                            Text("8°",
                                style: TextStyle(
                                  fontSize: 24,
                                )),
                            SizedBox(
                              width: 16.0,
                            ),
                            BoxedIcon(
                              WeatherIcons.night_alt_cloudy,
                              color: lSecondaryLightColor,
                              size: 24.0,
                            )
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.raindrops,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("6%",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.wind_beaufort_0,
                                    color: lSecondaryLightColor,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("16 Km/h",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                                            '76%',
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
                                            '0 of 10',
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
