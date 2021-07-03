import 'package:chat_application/components/categories.dart';
import 'package:chat_application/components/custom_appbar.dart';
import 'package:chat_application/components/header_title.dart';
import 'package:chat_application/components/search_widget_home.dart';
import 'package:chat_application/components/subtitle_text.dart';
import 'package:chat_application/components/top_doctors.dart';
import 'package:chat_application/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

String _profilad = "";
String _isim = "umut 17074";
String name = "";
String uzmanlikAlani = "";
final List<String> nameList = <String>["item 1 "];
final List<String> uzmanList = <String>["item 1 "];
final List<String> hakkimdaList = <String>["item 1 "];
int uzmansayac = 0;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    getUsers();
    //getDanisman();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(),
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            HeaderTitle(),
            SearchWidgetHome(),
            SubtitleText(title: "Kategoriler"),
            Categories(),
            SubtitleText(title: "Popülerler"),
            TopDoctor(),
            Text(loginUserName),
            ListView.builder(
              shrinkWrap: true,
              itemCount: nameList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return PersonView(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        name = doc["name"].toString();
        nameList.add(name);
        uzmanlikAlani = doc["UzmanlikAlani"].toString();
        uzmanList.add(uzmanlikAlani);
        String hakkimda = doc["Hakkımda"].toString();
        hakkimdaList.add(hakkimda);
        hakkimdaList.forEach((element) {
          hakkimda1 = element.toString();
        });
      });
      print("OK!");
      nameList.forEach((element) {
        print(element + "element");
      });
      // bu kısım return olmuyot galiba
    });

    // uzmnalık için liste
  }
/*
  Widget getDanisman() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        uzmanlikAlani = doc["UzmanlikAlani"].toString();
        uzmanList.add(uzmanlikAlani);
      });
      print("OK!");
      nameList.forEach((element) {
        print(element + "element");
      });
    });
  }
 */

  SetUserName(String name) {
    loginUserName = name;
  }

  SetHakkimda(String hakkimda) {
    hakkimda1 = hakkimda;
  }

  Widget PersonView(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: 330,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.directions_bus,
                          size: 16,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.red.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen()));
                        },
                        child: Text(
                          nameList[index].toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.drive_file_rename_outline,
                          size: 16,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.red.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: SetUserName(uzmanList[index].toString()),
                        child: Text(
                          uzmanList[index].toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
