import 'package:flutter/material.dart';
import 'package:my_news_task/screen/Home.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter demo',
              theme: ThemeData.light(),
              home: HomeScreen(),
            );
          },
        );
      },
    );
  }
}

