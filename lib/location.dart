import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:background_geolocation_firebase/background_geolocation_firebase.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:backgroundgeolocationfirebaseexample/services/auth.dart' as auth;

class Location extends StatefulWidget {
  @override
  _LocationState createState() => new _LocationState();
}
class _LocationState extends State<Location> {
  bool _enabled;
  bool _persistEnabled;
  String _locationJSON;
  JsonEncoder _encoder = new JsonEncoder.withIndent('  ');
  
  @override
  void initState() {
    _enabled = false;
    _persistEnabled = true;
    _locationJSON = "Toggle the switch to start tracking.";

    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {


    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] $location');
      setState(() {
        _locationJSON = _encoder.convert(location.toMap());
      });
    });

    BackgroundGeolocationFirebase.configure(BackgroundGeolocationFirebaseConfig(
      locationsCollection: "locations",
      geofencesCollection: "geofences",
      updateSingleDocument: false
    ));

    bg.BackgroundGeolocation.ready(bg.Config(
      debug: true,
      distanceFilter: 1609,
      logLevel: bg.Config.LOG_LEVEL_VERBOSE,
      stopTimeout: 1,
      stopOnTerminate: false,
      startOnBoot: true
    )).then((bg.State state) {
      setState(() {
        _enabled = state.enabled;
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });

    if (enabled) {
      bg.BackgroundGeolocation.start();
    } else {
      bg.BackgroundGeolocation.stop();
    }
  }

  void _onClickEnablePersist() {
    setState(() {
      _persistEnabled = !_persistEnabled;
    });

    if (_persistEnabled) {
      bg.BackgroundGeolocation.setConfig(bg.Config(
        persistMode: bg.Config.PERSIST_MODE_ALL
      ));
    } else {
      bg.BackgroundGeolocation.setConfig(bg.Config(
        persistMode: bg.Config.PERSIST_MODE_NONE
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Ride Yr Bike Tracker', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.amberAccent,
          brightness: Brightness.light,
          actions: <Widget>[
            Switch(value: _enabled, onChanged: _onClickEnable),
          ]
        ),
        body: Text(_locationJSON),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.only(left: 5.0, right:5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                      //minWidth: 50.0,
                      child: Icon(Icons.play_arrow, color: Colors.white),
                      color: Colors.red,
                      onPressed: _onClickEnablePersist
                  )
                ]
            )
          )
        ),
      ),
    );
  }
}
