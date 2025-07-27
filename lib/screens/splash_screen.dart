import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repondfred/screens/home_screens.dart';
import 'package:repondfred/widgets/custom_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size mq;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FredReondApp()), // Modifié ici
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return CustomScaffold(
      child: Stack(
        children: [
          Positioned(
            bottom: mq.height * .13,
            width: mq.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animation de chargement circulaire
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 16), // Espacement
                  const Text(
                    'Chargement...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: .5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}