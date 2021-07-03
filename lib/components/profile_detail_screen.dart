import 'package:chat_application/chat_screen.dart';
import 'package:chat_application/data/data_model.dart';
import 'package:chat_application/screens/home.dart';
import 'package:chat_application/screens/month.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatelessWidget {
  final DoctorModel model;
  ProfileDetailScreen({this.model});
  String oid_ = "THYWS2HrptVqR78xMMJ8RVi9SnI2";
  String oname = "Ceren Akyol";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /*   CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white,
          // backgroundImage: NetworkImage(model.imgUrl),
        ),*/

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: uzmanlikAlani,
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    TextSpan(
                        text: " - ",
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    TextSpan(
                        text: "uzmanlık alanı",
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.calendar_today_sharp),
                          color: Colors.blue[900],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MonthScreen()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.message),
                          color: Colors.pink[800],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          opponentId: oid_,
                                          opponentName: oname,
                                        )));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Icon(
                          Icons.phone,
                          size: 17,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
