import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/screens/game_screen.dart';
import 'package:maplestory/widgets/loading_bar_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _loadingProgress = 0.0;
  double _completedTasks = 0.0;
  double _screenHeight = 0.0;
  double _screenWidth = 0.0;
  final double _gap = 0.03;
  final int _totalTasks =
      AppAssets.allImages.length + AppAssets.allFonts.length;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialiseApp());
    super.initState();
  }

  Future<void> _initialiseApp() async {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    await Future.wait([_preloadImages(), _preloadFonts()]);
  }

  void _updateProgress() {
    if (!mounted) return;

    setState(() {
      ++_completedTasks;
      _loadingProgress = _completedTasks / _totalTasks;
    });
  }

  Future<void> _preloadImages() async {
    final images = AppAssets.allImages;

    for (int i = 0; i < images.length; ++i) {
      await precacheImage(AssetImage(images[i]), context);
      _updateProgress();
    }
  }

  Future<void> _preloadFonts() async {
    final titleFont = FontLoader("Title")
      ..addFont(rootBundle.load(AppAssets.titleFont));
    final regularFont = FontLoader("Regular")
      ..addFont(rootBundle.load(AppAssets.regularFont));

    final allFonts = [titleFont, regularFont];
    for (int i = 0; i < allFonts.length; ++i) {
      await allFonts[i].load();
      _updateProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade800,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, -1.0 + _gap),
            child: Container(
              width: _screenWidth * (1 - _gap),
              height: 10,
              color: Colors.red.shade900,
            ),
          ),
          Align(
            alignment: Alignment(-1.0 + _gap, 0.0),
            child: Container(
              width: 10,
              height: _screenHeight * (1 - _gap),
              color: Colors.red.shade900,
            ),
          ),
          Align(
            alignment: Alignment(0.0, 1 - _gap),
            child: Container(
              width: _screenWidth * (1 - _gap),
              height: 10,
              color: Colors.red.shade900,
            ),
          ),
          Align(
            alignment: Alignment(1 - _gap, 0.0),
            child: Container(
              width: 10,
              height: _screenHeight * (1 - _gap),
              color: Colors.red.shade900,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "M A P E L S T O R Y",
                  style: TextStyle(
                    fontFamily: "Title",
                    fontWeight: FontWeight.w600,
                    fontSize: 50,
                  ),
                ),
                SizedBox(height: 30),
                _loadingProgress < 1.0
                    ? LoadingBarWidget(loadingProgress: _loadingProgress)
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GameScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 8.0,
                        ),
                        child: Text(
                          "Play",
                          style: TextStyle(fontFamily: "Regular", fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
