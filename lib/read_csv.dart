import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class ReadCsv extends StatefulWidget {
  const ReadCsv({Key? key}) : super(key: key);

  @override
  _ReadCsvState createState() => _ReadCsvState();
}

class _ReadCsvState extends State<ReadCsv> {
  loadCsvFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    String path = result!.files.first.path!;
    print("pathpath$path");
    // LoadCsvDataScreen(path: path);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return LoadCsvDataScreen(path: path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () {
            loadCsvFromStorage();
          },
          child: const Center(child: Text("CSV FILE"))),
    );
  }
}
