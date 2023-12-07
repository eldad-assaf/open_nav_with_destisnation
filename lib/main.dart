// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        selectedAppUrl =
            Uri.parse('https://maps.apple.com/?ll=32.180911,34.917870');
        break;
      default:
        'googleMaps';
    }

    if (!await launchUrl(selectedAppUrl)) {
      throw Exception('Could not launch $selectedAppUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              try {
                //NOT WORKING WITH WAZE!
                //  final canLaunch = await canLaunchUrl(Uri.parse('waze://'));
                //  print('canLaunch waze : $canLaunch ');

                await _launchUrl(app: 'waze');
              } catch (e) {
                print('error : $e');
              }
            },
            child: const Text('waze'),
          ),
          TextButton(
            child: const Text('gogole maps'),
            onPressed: () async {
              try {
                final canLaunch = await canLaunchUrl(
                    Uri.parse('comgooglemaps://')); //maps:// for apple
                print('canLaunch googleMaps : $canLaunch ');
                // print('canLaunch googleMaps : $canLaunch2 ');
                await _launchUrl(app: 'googleMaps');
              } catch (e) {
                print('error : $e');
              }
            },
          ),
          TextButton(
            child: const Text('apple maps'),
            onPressed: () async {
              try {
                final canLaunch = await canLaunchUrl(Uri.parse('maps://'));
                print('canLaunch appleMaps : $canLaunch ');
                // print('canLaunch googleMaps : $canLaunch2 ');
                await _launchUrl(app: 'appleMaps');
              } catch (e) {
                print('error : $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
