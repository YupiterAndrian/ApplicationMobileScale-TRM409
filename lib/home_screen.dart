import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'add_item_screen.dart';
import 'welcome_page.dart';
import 'CatatanPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> buahItems = [];
  int badgeCountBuah = 0;
  int badgeCountSayur = 0;
  int badgeCountAtk = 0;

  final DatabaseReference _weightRef =
      FirebaseDatabase.instance.ref().child('weight');
  double _weight = 0.0;

  @override
  void initState() {
    super.initState();
    _weightRef.onValue.listen((event) {
      setState(() {
        _weight = double.parse(event.snapshot.value.toString());
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Yakin Ingin Keluar?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Tidak"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ),
                          );
                        },
                        child: const Text("Ya"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        title: const Text("Home"),
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 10,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 5.5,
                        color: Colors.green,
                      ),
                      GaugeRange(
                        startValue: 5.5,
                        endValue: 7.7,
                        color: Colors.yellow,
                      ),
                      GaugeRange(
                        startValue: 7.7,
                        endValue: 10,
                        color: Colors.red,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.95,
                        widget: Text(
                          '$_weight kg',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: _weight),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    List<Map<String, dynamic>> filteredItems =
                        items.where((item) => item['jenis'] == 'Buah').toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatatanPage(
                          jenis: 'Buah',
                          filteredItems: filteredItems,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Buah',
                    style: TextStyle(color: Colors.green),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const BorderSide(
                              color: Colors.green, width: 2);
                        }
                        return const BorderSide(color: Colors.green, width: 1);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    List<Map<String, dynamic>> filteredItems = items
                        .where((item) => item['jenis'] == 'Sayur')
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatatanPage(
                          jenis: 'Sayur',
                          filteredItems: filteredItems,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Sayur',
                    style: TextStyle(color: Colors.green),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const BorderSide(
                              color: Colors.green, width: 2);
                        }
                        return const BorderSide(color: Colors.green, width: 1);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    List<Map<String, dynamic>> filteredItems = items
                        .where((item) => item['jenis'] == 'Daging')
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatatanPage(
                          jenis: 'Daging',
                          filteredItems: filteredItems,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Daging',
                    style: TextStyle(color: Colors.green),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const BorderSide(
                              color: Colors.green, width: 2);
                        }
                        return const BorderSide(color: Colors.green, width: 1);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text("Total $_weight kg"),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['nama']),
                    subtitle: Text("${item['berat']} kg - ${item['jenis']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Yakin Ingin Menghapus Item?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Tidak"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _removeItem(index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
          if (newItem != null) {
            setState(() {
              items.add(newItem);
              String itemType = newItem['jenis'];
              if (itemType == 'Buah') {
                badgeCountBuah++;
                buahItems.add(newItem);
              } else if (itemType == 'Sayur') {
                badgeCountSayur++;
              } else if (itemType == 'Daging') {
                badgeCountAtk++;
              }
            });
          }
        },
      ),
    );
  }
}
