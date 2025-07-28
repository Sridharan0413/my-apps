import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryPickerPage extends StatefulWidget {
  const CountryPickerPage({super.key});

  @override
  State<CountryPickerPage> createState() => _CountryPickerPageState();
}

class _CountryPickerPageState extends State<CountryPickerPage> {
  List<dynamic> countries = [];
  String selectedDialCode = '+91';

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    final String response = await rootBundle.loadString('assets/country_codes.json');
    final data = json.decode(response);
    setState(() {
      countries = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country Code'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Choose your country code:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (countries.isNotEmpty)
              DropdownButton<String>(
                value: selectedDialCode,
                isExpanded: true,
                items: countries.map<DropdownMenuItem<String>>((country) {
                  return DropdownMenuItem<String>(
                    value: country['dial_code'],
                    child: Text("${country['name']} (${country['dial_code']})"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDialCode = value!;
                  });
                },
              )
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
