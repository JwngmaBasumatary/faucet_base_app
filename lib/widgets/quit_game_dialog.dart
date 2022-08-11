import 'package:auto_size_text/auto_size_text.dart';
// import '../global/global.dart';
import 'package:flutter/material.dart';

import '../dashboard/home_page.dart';

class QuitGameDialog extends StatelessWidget {
  const QuitGameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 165,
        child: Stack(
          children: [
            Container(
              width: 250,
              height: 135,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: AutoSizeText(
                      'Are you sure you want to Go Back?',
                      minFontSize: 22,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const HomePage();
                })),
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: HSLColor.fromColor(const Color(0XFFE7EAEB))
                          .withLightness(0.55)
                          .toColor()
                      // color: Global.colors.lightIconColorDarker,
                      ),
                  child: const Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 150,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: HSLColor.fromColor(const Color(0XFFE7EAEB))
                          .withLightness(0.55)
                          .toColor()
                      // color: Global.colors.lightIconColorDarker,
                      ),
                  child: const Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
