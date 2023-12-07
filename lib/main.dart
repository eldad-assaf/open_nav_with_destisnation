import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _wazeUrl =
    Uri.parse('https://waze.com/ul?ll=32.180911,34.917870&z=10');

//'https://waze.com/ul?ll=32.180911,34.917870&z=10'
String getWazeUrl(String address) => "waze://?q=$address&navigate=yes";

String getAppleMapsUrl(String address) =>
    "https://maps.apple.com/?daddr=$address";

String getGoogleMapsUrl(String address) =>
    "https://www.google.com/maps/dir/?api=1&destination=$address";

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
  Future<bool> isAppInstalled(String scheme) async {
    if (await canLaunch(scheme)) {
      return true;
    }
    return false;
  }

  Future<void> _launchUrl({required String app}) async {
    Uri selectedAppUrl = Uri();
    switch (app) {
      case 'waze':
        selectedAppUrl =
            Uri.parse('https://waze.com/ul?ll=32.180911,34.917870&z=10');
        break;
      case 'googleMaps':
        selectedAppUrl = Uri.parse(
            'https://www.google.com/maps/dir/?api=1&destination=jerusalem');
        break;
      case 'appleMaps':
        selectedAppUrl = Uri.parse('https://maps.apple.com/?daddr=jerusalem');
        break;
      default:
        'googleMaps';
    }

    if (!await launchUrl(selectedAppUrl)) {
      throw Exception('Could not launch $_wazeUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              await _launchUrl(app: 'waze');
            },
            child: const Text('waze'),
          ),
          TextButton(
            onPressed: () async {
              await _launchUrl(app: 'googleMaps');
            },
            child: const Text('gogole maps'),
          ),
          TextButton(
            onPressed: () async {
              await _launchUrl(app: 'appleMaps');
            },
            child: const Text('apple maps'),
          ),
        ],
      ),
    );
  }
}
