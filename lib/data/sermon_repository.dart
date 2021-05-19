import 'dart:math';
import 'package:flutter/material.dart';

import 'model/sermon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SermonRepository {
  //final String fullName;
  //final String company;
  //final int age;

  var firebaseUser = FirebaseAuth.instance.currentUser;


  Future<List<Sermon>> getSermons()  {
    List<Sermon> sermons = new List<Sermon>();
    
    FirebaseFirestore.instance
    
    .collection('users').doc(firebaseUser.uid).collection('sermons')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["title"]);
            sermons.add(new Sermon(
        title: doc["title"],
        location: doc["location"],
        date: doc["date"].toDate()));

        });
    });

    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        return sermons;
      },
    );
      
  }
  
  

  Future<void> addSermons(String title, String location, DateTime sermonDate) {

    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .collection('sermons');

    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'title': title,
          'location': location,
          'date': sermonDate
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

}

class NetworkException implements Exception {}

