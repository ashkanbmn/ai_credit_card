import 'package:credit_card_ml/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        title: "AI Credit Card Scanner",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          home: const SplashScreen())));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CardInfo? cardInfo;
  final ScannerWidgetController _controller = ScannerWidgetController();

  @override
  void initState() {
    _controller
      ..setCardListener((value) {
        setState(() {
          cardInfo = value;
        });
      })
      ..setErrorListener((exception) {
        if (kDebugMode) {
          print('خطا: ${exception.message}');
        }
      });
    super.initState();
  }

  void copyCardInfoToClipboard() {
    if (cardInfo != null) {
      final textToCopy = cardInfo?.number.toString();
      Clipboard.setData(ClipboardData(text: textToCopy!));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black87,
        content: Text('کپی انجام شد',textAlign: TextAlign.right),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('اسکن کارت اعتباری با هوش مصنوعی'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ScannerWidget(
            oneShotScanning: true,
            cameraResolution: CameraResolution.high,
            controller: _controller,
            overlayOrientation: CardOrientation.landscape,
            overlayText: const Center(
                child: Text(
              "کارت بانکی را اسکن کنید",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardInfo?.number.toString() == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/loading_animation.json',
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: const Text(
                                      "...در حال پردازش",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "شماره کارت \n ${cardInfo?.number.toString()}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          copyCardInfoToClipboard();
                                        },
                                        icon: const Icon(Icons.copy),label:                                     const Text(
                                      "کپی",
                                    )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
