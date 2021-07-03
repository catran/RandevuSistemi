import 'package:chat_application/data/data.dart';
import 'package:chat_application/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailScreen(
                      dokterid: listDoctor[index].id,
                      model: listDoctor[index],
                    )));
          },
          child: Container(
            height: 115,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: listDoctor[index].warna.withOpacity(.8),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: NetworkImage(
                      "https://i2.cnnturk.com/i/cnnturk/75/800x400/56669c418685760b6c82baff"),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listDoctor[index].name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w800),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: listDoctor[index].specialist,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                            TextSpan(
                                text: " - ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                            TextSpan(
                                text: listDoctor[index].location,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void GetUsersFromDb() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
      });
    });
  }
}
