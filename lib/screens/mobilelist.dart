import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_guide/Model/mobile.dart';
import 'package:mobile_guide/database/dbprovider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'mobile_detail.dart';

class MobileList extends StatefulWidget {
  const MobileList({Key? key}) : super(key: key);

  @override
  _MobileListState createState() => _MobileListState();
}

class _MobileListState extends State<MobileList> {
  List mobileList = [];
  List mobileListsort = [];

  Future<String> getMobileList() async {
    final response = await http.get(
      Uri.parse("https://scb-test-mobile.herokuapp.com/api/mobiles/"),
      headers: {"Accept": "application/json"},
    );
    var resbody = json.decode(response.body);

    setState(() {
      mobileList = resbody;
      mobileListsort = mobileList;
      // getdata1();
    });
    return getMobileList();
  }

  void initState() {
    getMobileList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          child: ListView.builder(
            itemCount: mobileList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt("mobile_id", mobileList[index]['id']);
                  prefs.setString(
                      "description", mobileList[index]['description']);
                  prefs.setString("name", mobileList[index]['name']);
                  prefs.setString("brand", mobileList[index]['brand']);
                  prefs.setString("price", "${mobileList[index]['price']}");
                  prefs.setDouble("rating", mobileList[index]['rating']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobileDetailPage()));
                },
                child: Container(
                  // margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.network(
                            mobileList[index]['thumbImageURL'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Text(
                                      mobileList[index]['name'],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        Mobile _newMobile = Mobile(
                                          name: mobileList[index]['name'],
                                          catid: mobileList[index]['id'],
                                          price:
                                              "${mobileList[index]['price']}",
                                          thumbImageURL: mobileList[index]
                                              ['thumbImageURL'],
                                          rating: mobileList[index]['rating'],
                                          brand: mobileList[index]['brand'],
                                          description: mobileList[index]
                                              ['description'],
                                        );
                                        // getdata1();
                                        MobileListDBProvider.db.getmobileId(
                                            mobileList[index]['id'],
                                            _newMobile);
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Text(
                                  mobileList[index]['description'],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Price: \$ ${mobileList[index]['price']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Rating: ${mobileList[index]['rating']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
