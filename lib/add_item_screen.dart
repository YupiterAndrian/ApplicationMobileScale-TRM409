import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nama = '';
  int _berat = 0;
  String? _jenis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nama'),
              onSaved: (value) {
                _nama = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Berat (kilogram)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onSaved: (value) {
                _berat = int.parse(value!);
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Jenis'),
              value: _jenis,
              items: ['Buah', 'Sayur', 'Daging']
                  .map((jenis) => DropdownMenuItem(
                        value: jenis,
                        child: Text(jenis),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jenis = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Pilih jenis item';
                }
                return null;
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context, {
                        'nama': _nama,
                        'berat': _berat,
                        'jenis': _jenis,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item berhasil ditambahkan'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
