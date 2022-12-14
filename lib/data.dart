import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadCsvDataScreen extends StatelessWidget {
  final String path;

  // ignore: use_key_in_widget_constructors
  const LoadCsvDataScreen({required this.path});

  @override
  Widget build(BuildContext context) {
    print("pathpathpathpath$path");
    loadingCsvData(path);

    return const Scaffold(
        body: Center(child: Text("Data Imported Successfully")));
  }

  loadingCsvData(String path) async {
    final csvFile = File(path).openRead();
    _generateCsvFile(csvFile
        .transform(utf8.decoder)
        .transform(
          const CsvToListConverter(),
        )
        .toList());
  }

  void _generateCsvFile(Future<List<List<dynamic>>> data) async {
    Map<Permission, PermissionStatus> status =
        await [Permission.storage].request();
    Future<List<List<dynamic>>> csvList = data;

    print("widget.path${csvList}");

    List<List<dynamic>> rows1 = [];
    List<List<dynamic>> rows2 = [];

    String csv1;
    String csv2;

    String dir = "";
    csvList.then((value) async => {
          filterData(value, rows1, rows2),
          rows1.toSet().toList(),
          print(rows1.toSet().toList().toString()),
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android)
            {
              // Some android/ios specific code
              csv1 = const ListToCsvConverter().convert(rows1),
              csv2 = const ListToCsvConverter().convert(rows2),
              fun(dir, csv1, csv2)
            }
          else if (defaultTargetPlatform == TargetPlatform.linux ||
              defaultTargetPlatform == TargetPlatform.macOS ||
              defaultTargetPlatform == TargetPlatform.windows)
            {}
          else
            {}
        });
  }

  void filterData(List<List<dynamic>> value, List<List<dynamic>> rows1,
      List<List<dynamic>> rows2) {
    return value.forEach((element) {
      List<dynamic> row1 = [];
      List<dynamic> row2 = [];

// we need to remove reputation from element 2
// we need to add the calculations for element 3 to

      element.toSet().toList();
      row1.add(element[2]);
      row1.add(element[3]);
      row1.toSet().toList();

      row2.add(element[2]);
      row2.add(element[4]);

      print("toString${element[0].toString()}");

      rows1.add(row1);
      rows2.add(row2);
    });
  }

  fun(String dir, String csv1, String csv2) async {
    if (Platform.isAndroid) {
      dir = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
    } else {
      dir = ExtStorage.DIRECTORY_DOWNLOADS;
    }
    String fileName = dir;
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory(appDocDirectory.path + '/' + '0$fileName.csv')
        .create(recursive: true)
        .then((Directory directory) {
      File f = File(directory.path + "/0_$fileName.csv");
      f.writeAsString(csv1);
      print('Path of New Dir: ' + directory.path);
    });

    Directory(appDocDirectory.path + '/' + '1$fileName.csv')
        .create(recursive: true)
        .then((Directory directory) {
      File f = File(directory.path + "/1_$fileName.csv");
      f.writeAsString(csv2);
      print('Path of New Dir: ' + directory.path);
    });
  }
}
