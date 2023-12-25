import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
    ],
  );
  runApp(const Pokemon());
}

class Pokemon extends StatelessWidget {
  const Pokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
