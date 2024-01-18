import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';
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
      print(csvData);
      isLoading = false;
    });
  }

  Future<void> exportToExcel() async {
    final Excel excel = Excel.createExcel();
    final Sheet sheet = excel['Sheet1'];

    // Write CSV data to Excel sheet
    for (int i = 0; i < csvData.length; i++) {
      for (int j = 0; j < csvData[i].length; j++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
          ..value = csvData[i][j];
      }
    }

    // Save the Excel file
    // File('your_path/excel.xlsx').writeAsBytes(bytes);  // Uncomment to save the file (change 'your_path')
  }

 // ...

@override
Widget build(BuildContext context) {
  return (isLoading) ?  Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.black,))) :  Scaffold(
    appBar: AppBar(
      title: const Text('CSV Reader'),
      actions: [
        IconButton(
          icon: const Icon(Icons.file_download),
          onPressed: () {
            exportToExcel(); // Call exportToExcel when the button is pressed
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:  SingleChildScrollView(
        child: Table(
          border: TableBorder.all(width: 1.0),
          children: csvData.map((item) {
            return TableRow(
                children: item.map((row) {
              return Container(
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
    ),)
  );
}

}
