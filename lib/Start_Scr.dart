import 'package:flutter/material.dart';

class StartScr extends StatelessWidget {
  const StartScr(this.toHomeScr, {super.key});

  final void Function() toHomeScr;
  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/image/MainBackground.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withAlpha(200), BlendMode.dstATop),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ordinary Cafe App',
              style: TextStyle(
                  color: Colors.white,
                  fontSize:24,
                  fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                      child: Image.asset(
                      'assets/image/CafeLogo.png',
                      scale: 0.8,
                      ),
                    ),
              ),
            const SizedBox(height: 80),
            OutlinedButton.icon(
              onPressed: toHomeScr,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.arrow_right_alt_sharp),
              label: const Text(
                'Continue to HomePage',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),    
      ),
    );
  }
}