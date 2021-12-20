import 'package:flutter/material.dart';
import 'package:mobile_guide/screens/favourite.dart';
import 'package:mobile_guide/screens/mobilelist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.filter_alt,
              ),
              onPressed: () {
                _alertDialogBuilder();
              },
            ),
          ],
          backgroundColor: const Color(0XFF216EAD),
          centerTitle: false,
          title: const Text(
            "Mobile Phone",
            style: TextStyle(fontSize: 16),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Mobile List",
              ),
              Tab(
                text: "Favourite",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MobileList(),
            FavouriteList(),
          ],
        ),
      ),
    );
  }

  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Container(
                constraints: const BoxConstraints(
                  minHeight: 150,
                  maxHeight: 150,
                  minWidth: double.infinity,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: const [
                    Text("Price High to Low",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("Price Low to High",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("Rating 5 to 1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                )),
          );
        });
  }
}
