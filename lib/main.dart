import 'package:car_dash/dash.dart';
import 'package:car_dash/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CSV Reader'),
        // Add a hamburger icon to open the drawer
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Data'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add logic to navigate to the data screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DataScreen()));
              },
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add logic to navigate to the dashboard screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to CSV Reader!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Explore your data and dashboard with ease.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
