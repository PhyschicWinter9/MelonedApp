import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../model/weather.dart';
import '../service/openweatherapi.dart';

class WeatherAPI extends StatefulWidget {
  const WeatherAPI({Key? key}) : super(key: key);

  @override
  State<WeatherAPI> createState() => _WeatherAPIState();
}

class _WeatherAPIState extends State<WeatherAPI> {
  String? lat;
  String? lon;
  Weather? data;

  WeatherApiClient client = WeatherApiClient();

  //Get Location from GPS and show Weather Widget
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    lon = position.longitude.toString();
    // print(lat);
    // print(lon);
    data = await client.getCurretWeather(lat, lon);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 212, 176, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: FutureBuilder(
                      future: getLocation(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    // Image.asset(
                                    //   'assets/weather/${data?.icon}.png',
                                    //   width: 80,
                                    //   height: 80,
                                    // ),
                                    Lottie.asset(
                                        'assets/weather/${data?.icon}.json',
                                        width: 100,
                                        height: 100),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data?.decoration}',
                                          style: GoogleFonts.kanit(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  116, 116, 39, 1)),
                                        ),
                                        Text(
                                          '${data?.temp} °C',
                                          style: GoogleFonts.kanit(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  116, 116, 39, 1)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Text(
                                      "${data?.cityname}",
                                      style: GoogleFonts.kanit(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(116, 116, 39, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: LoadingAnimationWidget.prograssiveDots(
                              size: 50,
                              color: Colors.orangeAccent,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
  }
  }