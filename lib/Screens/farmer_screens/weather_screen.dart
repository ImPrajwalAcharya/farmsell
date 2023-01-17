import 'package:farmersapp/methods/authmethods.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

WeatherFactory wf = new WeatherFactory("9e4cf60e5ba77d4d3bb154803e97a00f");
String location = '';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  getlocation() async {
    final user = await AuthMethods().getUserDetails();
    setState(() {
      location = user.location;
    });
  }

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: wf.currentWeatherByCityName(location),
      builder: (context, snapshot) {
        print(location);
        if (location == '') {
          return Center(child: Text('Set location to see weather'));
          // return showSnackBar('First set Location', context);
        } else {
          try {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.teal),
              padding: EdgeInsets.all(20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text(
                            DateFormat.yMMMd()
                                .format(DateTime.now())
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                         
                          Text(
                            DateFormat.Hm().format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${snapshot.data!.areaName}',
                            style: TextStyle(
                              fontSize:20,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.wb_cloudy ,size: 120,color: Colors.white,),
                    // const SizedBox(height: 10),
                    // Image.network(
                    //   "https://img.freepik.com/free-vector/hand-drawn-clouds-collection_52683-68002.jpg?w=2000",
                    //   width: 100,
                    //   height: 100,
                    // ),
                    // Container(
                    //   child:Icon(IconData(0xf04b6, fontFamily: 'MaterialIcons')) ,
                    // ),
                    // SizedBox(height: 10),
                     
                    Text(
                      '${snapshot.data!.tempFeelsLike.toString().substring(0,4)}°',
                      style: TextStyle(
                        fontSize: 65,
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                      
                    ),
                    Text(
                            DateFormat.EEEE().format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                    // SizedBox(height: 10),
                    Text(
                      snapshot.data!.weatherDescription.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.white
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            return Center(child: Text(e.toString()));
          }
        }
      },
    );
  }
}
