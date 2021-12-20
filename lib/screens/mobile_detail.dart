import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MobileDetailPage extends StatefulWidget {
  const MobileDetailPage({Key? key}) : super(key: key);

  @override
  _MobileDetailPageState createState() => _MobileDetailPageState();
}

class _MobileDetailPageState extends State<MobileDetailPage> {
  List mobiledetailList = [];
  int mobile_id = 1;
  String description = "";
  String name = "";
  String brand = "";
  String price = "";
  double rating = 0;

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobile_id = prefs.getInt("mobile_id")!;
      description = prefs.getString("description")!;
      name = prefs.getString("name")!;
      brand = prefs.getString("brand")!;
      price = prefs.getString("price")!;
      rating = prefs.getDouble("rating")!;

      getMobileList();
    });
  }

  Future<String> getMobileList() async {
    final response = await http.get(
      Uri.parse(
          "https://scb-test-mobile.herokuapp.com/api/mobiles/$mobile_id/images/"),
      headers: {"Accept": "application/json"},
    );
    var resbody = json.decode(response.body);

    setState(() {
      mobiledetailList = resbody;
    });
    return getMobileList();
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF216EAD),
        title: Text(
          "Mobile Phone",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    height: 250,
                    enlargeCenterPage: false,
                  ),
                  items: mobiledetailList.map((item) {
                    return Center(
                      child: Image.network(
                        item['url'],
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                child: Container(
                  height: 50,
                  decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0.3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Rating: ${rating}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Price: \$ ${price}"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(brand),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              description,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          )
        ],
      ),
    );
  }
}
