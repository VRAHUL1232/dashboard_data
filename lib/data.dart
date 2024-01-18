import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

class DataScreen extends StatefulWidget {

  const DataScreen({super.key});

  @override
  DataScreenState createState() => DataScreenState();
}

bool isLoading = false;

class DataScreenState extends State<DataScreen> {
  List<List<dynamic>> csvData = [[]];

  @override
  void initState() {
    super.initState();
    readCSV();
  }

  Future<void> readCSV() async {
    isLoading = true;
    final data = await rootBundle.loadString('assets/csv/ILP.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(data);

    setState(() {
      csvData = rowsAsListOfValues;
      isLoading = false;
    });
  }

@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return (isLoading) ?  Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.black,))) :  Scaffold(
    appBar: AppBar(
      title: const Text('CSV Reader'),
      actions: [
        IconButton(
          icon: const Icon(Icons.file_download),
          onPressed: () {
           // Call exportToExcel when the button is pressed
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            columnWidths: {
              0: FixedColumnWidth(screenWidth*0.1),
              1: FixedColumnWidth(screenWidth*0.1),
              2: FixedColumnWidth(screenWidth*0.1),
              3: FixedColumnWidth(screenWidth*0.1),
              4: FixedColumnWidth(screenWidth*0.1),
              5: FixedColumnWidth(screenWidth*0.1),
              6: FixedColumnWidth(screenWidth*0.1),
              7: FixedColumnWidth(screenWidth*0.1),
              8: FixedColumnWidth(screenWidth*0.1),
              9: FixedColumnWidth(screenWidth*0.1),
              10: FixedColumnWidth(screenWidth*0.1),
              11: FixedColumnWidth(screenWidth*0.1),
              12: FixedColumnWidth(screenWidth*0.1),
              13: FixedColumnWidth(screenWidth*0.1),
              14: FixedColumnWidth(screenWidth*0.1),
              15: FixedColumnWidth(screenWidth*0.1),
              16: FixedColumnWidth(screenWidth*0.1),
              17: FixedColumnWidth(screenWidth*0.1),
              18: FixedColumnWidth(screenWidth*0.1)
            },
            border: TableBorder.all(width: 1.0),
            children: csvData.map((item) {
              return TableRow(
                  children: item.map((row) {
                return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      row.toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                );
              }).toList());
            }).toList(),
          ),
        ),
    ));
}

}
