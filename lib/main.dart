import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'verify_page.dart';
import 'write_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Tamil Writer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Write'),
                Tab(text: 'Verify'),
              ],
            ),
            title: Text('Tamil Writer'),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              WritePage(),
              VerifyPage(),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),

    );
  }
}
