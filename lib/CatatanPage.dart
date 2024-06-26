import 'package:flutter/material.dart';

class CatatanPage extends StatelessWidget {
  final String jenis;
  final List<Map<String, dynamic>> filteredItems;

  CatatanPage({required this.jenis, required this.filteredItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan $jenis'),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(item['nama']),
            subtitle: Text("${item['berat']} kg - $jenis"),
          );
        },
      ),
    );
  }
}
