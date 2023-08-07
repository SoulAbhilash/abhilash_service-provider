import 'package:authentication/home/old_code/catalog.dart';
import 'package:authentication/home/old_code/ongoing_request.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedButton = '';
  bool status = false;
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  // Future<void> loadData() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final ongoingRequestJson =
  //       await rootBundle.loadString("lib/assets/files/DATA.js");
  //   final decodedData = jsonDecode(ongoingRequestJson);
  //   var productsData = decodedData["products"];
  //   setState(() {
  //     data = List.from(productsData)
  //         .map((item) => Item.fromMap(item).toMap())
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const paddingSize = 16.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingSize),
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.blueAccent,
                ),
                title: const Text('Delhi',
                    style: TextStyle(color: Colors.blueAccent)),
                subtitle: const Text('Enter Your Location'),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      status ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: status ? Colors.blueAccent : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider(
            //   height: 5,
            // ),
            SizedBox(
              height: screenHeight * 0.25,
              child: Center(
                child: Image.network(
                  'https://i.stack.imgur.com/HILmr.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: paddingSize),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: paddingSize),
              child: const Text(
                'Ongoing Request',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: paddingSize),
            SizedBox(
              height: screenHeight * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: screenHeight / 5,
                    width: screenWidth / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OngoingRequestCard(
                                image: items[index]['image'].toString(),
                                name: items[index]['name']!,
                                subtitle: items[index]['subtitle']!,
                                description: items[index]['description']!,
                                bookingId: items[index]['bookingId']!,
                                status: items[index]['status']!,
                                serProvId: items[index]['serProvId']!,
                                bill: items[index]['bill']!,
                                createdTime: items[index]['createdTime']!,
                                completeTime: items[index]['completeTime']!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: screenWidth / 14,
                                backgroundImage: NetworkImage(
                                    items[index]['image'].toString()),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items[index]['name']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth / 28,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        items[index]['subtitle']!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenWidth / 30,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        items[index]['description']!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth / 34,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: paddingSize),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: paddingSize),
              child: const Text(
                'Other Services',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: paddingSize),
            SizedBox(
              height: screenHeight * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otheritems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = otheritems[index];
                  return SizedBox(
                    height: screenHeight / 5,
                    width: screenWidth / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (item['title'] == 'Towing Service') {
                            // perform action for towing service card
                          } else if (item['title'] == 'SOS') {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>const SosScreen(),
                            //   ),
                            // );
                            // perform action for SOS card
                          } else {
                            // perform action for other cards
                          }
                        },
                        child: Card(
                          elevation: 2.0,
                          color: item['color'] as Color?,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                item['imagePath'].toString(),
                                width: screenWidth *
                                    0.18, // Set the width as 10% of screen width
                                height: screenHeight *
                                    0.08, // Set the height as 8% of screen height
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['title'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final otheritems = [
  {
    'imagePath': 'lib/assets/images/towtruck.png',
    'title': 'Towing Service',
    'color': Colors.white,
  },
  {
    'imagePath': 'lib/assets/images/siren.png',
    'title': 'SOS',
    'color': Colors.red[50],
  },
  {
    'imagePath': 'lib/assets/images/cleaning-staff.png',
    'title': 'Deep Cleaning',
    'color': Colors.white,
  },
];
var items = <Map<String, String>>[
  {
    'image': 'https://source.unsplash.com/50x50/?portrait',
    'name': 'Shivam',
    'subtitle': 'Rolls-Royce Phantom',
    'description': 'Cleaning',
    'bookingId': '15014520',
    'status': 'cancelled',
    'serProvId': '2567890',
    'bill': '1200',
    'createdTime': '10/10/2020',
    'completeTime': '11/10/2020',
  },
  {
    'image': 'https://loremflickr.com/50/50/people',
    'name': 'Rohit',
    'subtitle': 'Mercedes-Mayback',
    'description': 'Engine Problem',
    'bookingId': '15014520',
    'status': 'Completed',
    'serProvId': '2567890',
    'bill': '1200',
    'createdTime': '10/10/2020',
    'completeTime': '11/10/2020',
  },
  {
    'image': 'https://source.unsplash.com/50x50/?portrait,people',
    'name': 'Suman',
    'subtitle': 'BMW 7-Series',
    'description': 'Cleaning',
    'bookingId': '15014520',
    'status': 'cancelled',
    'serProvId': '2567890',
    'bill': '1200',
    'createdTime': '10/10/2020',
    'completeTime': '11/10/2020',
  },
  {
    'image': 'https://picsum.photos/50/50/?random',
    'name': 'Mohit',
    'subtitle': 'Audi A8',
    'description': 'Cleaning',
    'bookingId': '15014520',
    'status': 'cancelled',
    'serProvId': '2567890',
    'bill': '1200',
    'createdTime': '10/10/2020',
    'completeTime': '11/10/2020',
  },
];
