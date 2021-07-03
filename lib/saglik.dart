import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final List<String> nameList = <String>["item 1 ", "item 2 "];
final List<String> uzmanList = <String>["item 1 ", "item 2 "];
int uzmansayac = 0;
String name = "";
String uzmanlikAlani = "";

class Saglik extends StatefulWidget {
  const Saglik({Key key}) : super(key: key);

  @override
  _SaglikState createState() => _SaglikState();
}

class _SaglikState extends State<Saglik> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            for (var i in nameList)
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(38.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.pinkAccent,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                i.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(uzmanList[uzmansayac++]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 21.0,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

Widget getUsers() {
  FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc["UzmanlikAlani"].toString() == "saglik") {
        name = doc["name"].toString();
        nameList.add(name);
        uzmanlikAlani = doc["UzmanlikAlani"].toString();
        uzmanList.add(uzmanlikAlani);
      }
    });
    print("OK!");
    uzmanList.forEach((element) {
      print(element + "element");
    });
    // bu kısım return olmuyot galiba
  });

  // uzmnalık için liste
}
