import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data_model.dart';

List<CategoriesDataModel> listDataCategories = [
  CategoriesDataModel(
      icon: Icons.favorite, title: "Sağlık", warna: Colors.amber),
  CategoriesDataModel(
      icon: Icons.add_a_photo, title: "Fotoğraf", warna: Colors.lightBlue),
  CategoriesDataModel(
      icon: Icons.adb, title: "Mobil Uygulama", warna: Colors.redAccent),
];

List<DoctorModel> listDoctor = [
  DoctorModel(
      id: 1,
      imgUrl:
          "https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
      location: "Lumnion",
      name: "Data Scientist Cansu Cavuldak",
      specialist: "Data Science",
      warna: Colors.lightBlue[200]),
  DoctorModel(
      id: 2,
      imgUrl:
          "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
      location: "IBM",
      name: "Yazılım Mühendisi Ceren Akyol",
      specialist: "Yazılım Mühendisi",
      warna: Colors.lightGreen[100]),
  DoctorModel(
      id: 3,
      imgUrl:
          "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
      location: "Acıbadem Hastanesi",
      name: "Dr. Ahmet Doğruyol",
      specialist: "Göz Hastalıkları Uzmanı",
      warna: Colors.pink[200]),
  DoctorModel(
      id: 4,
      imgUrl:
          "https://images.unsplash.com/photo-1536064479547-7ee40b74b807?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
      location: "Freelance",
      name: "Umut Atalay",
      specialist: "Fotoğrafçı",
      warna: Colors.pink[100]),
];

List<JadwalDokter> listJadwal = [
  JadwalDokter(
      id: 0,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-14",
      dokterID: 1),
  JadwalDokter(
      id: 1,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-15",
      dokterID: 1),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 1),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 1),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 2),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 2),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 3),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 3),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 3),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 3),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 4),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 4),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 4),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 4),
  JadwalDokter(
      id: 2,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-16",
      dokterID: 4),
  JadwalDokter(
      id: 3,
      darijam: "7 am",
      jenisJadwal: "Concultation",
      sampaijam: "10 am",
      tanggal: "2020-11-17",
      dokterID: 4),
];
void GetUsersfromDb() {
  FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      DoctorModel(
          id: 5,
          imgUrl:
              "https://images.unsplash.com/photo-1536064479547-7ee40b74b807?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
          location: "bakirkoy",
          name: doc["name"],
          specialist: "45",
          warna: Colors.pink[100]);
      print(doc["name"]);
    });
  });
}
