import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../styles/colors.dart';

class TodayPage extends StatefulWidget {
  final String title;

  const TodayPage({Key? key, required this.title}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    const dynamic tempMin = 10;
    const dynamic tempMax = 21;

    double screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height * 0.25;

    return Stack(children: <Widget>[
      Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/photo_addis_ababa.jpg"),
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: screenHeight - 48.0, bottom: 16.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Addis Ababa",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "Sunday, March 14 10:34",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.day_cloudy,
                                      color: primaryTextColor,
                                      size: 32.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "$tempMax °C",
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      "Partly Cloudy",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "$tempMax° / $tempMin°",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "Feels like $tempMax°",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.transparent),
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                BoxedIcon(
                                  WeatherIcons.humidity,
                                  color: primaryTextColor,
                                  size: 32.0,
                                ),
                                Text(
                                  "Humidity",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "21%",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.transparent),
                        child: Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                BoxedIcon(
                                  WeatherIcons.sunrise,
                                  color: primaryTextColor,
                                  size: 32.0,
                                ),
                                Text(
                                  "UV",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "6 of 10",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.transparent),
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                WindIcon(
                                  degree: 45,
                                  color: primaryTextColor,
                                  size: 32.0,
                                ),
                                Text(
                                  "Wind",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "14 Km/h",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                "11:00",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: primaryTextColor,
                                size: 24.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                "22°C",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.humidity,
                                    color: Colors.blueAccent,
                                    size: 10.0,
                                  ),
                                  Text(
                                    "22%",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                "12:00",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: primaryTextColor,
                                size: 24.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                "22°C",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.humidity,
                                    color: Colors.blueAccent,
                                    size: 10.0,
                                  ),
                                  Text(
                                    "22%",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                "13:00",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: primaryTextColor,
                                size: 24.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                "22°C",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.humidity,
                                    color: Colors.blueAccent,
                                    size: 10.0,
                                  ),
                                  Text(
                                    "22%",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                "14:00",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: primaryTextColor,
                                size: 24.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                "22°C",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.humidity,
                                    color: Colors.blueAccent,
                                    size: 10.0,
                                  ),
                                  Text(
                                    "22%",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                "15:00",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: primaryTextColor,
                                size: 24.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                "22°C",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  BoxedIcon(
                                    WeatherIcons.humidity,
                                    color: Colors.blueAccent,
                                    size: 10.0,
                                  ),
                                  Text(
                                    "22%",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
