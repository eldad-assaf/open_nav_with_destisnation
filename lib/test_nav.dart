import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String getWazeUrl(String address) => "waze://?q=$address&navigate=yes";

String getAppleMapsUrl(String address) => "https://maps.apple.com/?daddr=$address";

String getGoogleMapsUrl(String address) => "https://www.google.com/maps/dir/?api=1&destination=$address";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedApp = 0; // Initialize with default value (0 for Waze)

  Future<bool> isAppInstalled(String scheme) async {
    if (await canLaunch(scheme)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Choose Navigation App'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      value: 0,
                      groupValue: selectedApp,
                      title: const Text('Waze'),
                      onChanged: (value) => setState(() => selectedApp = value as int),
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: selectedApp,
                      title: const Text('Maps'),
                      onChanged: (value) => setState(() => selectedApp = value as int),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      String url = '';
                      switch (selectedApp) {
                        case 0:
                          url = getWazeUrl('address');
                          break;
                        case 1:
                          if (await isAppInstalled("comgooglemaps://")) {
                            url = getGoogleMapsUrl('address');
                          } else {
                            url = getAppleMapsUrl('address');
                          }
                          break;
                      }
                      launch(url);
                      Navigator.pop(context);
                    },
                    child: const Text('Navigate'),
                  ),
                ],
              ),
            );
          },
          child: const Text('test'),
        ),
      ),
    );
  }
}
