import 'package:flutter/material.dart';
import '../utils/constants.dart';

import '../dashboard/home_page.dart';

enum Difficulty { easy, intermediate, hard }

class EndGameDialog extends StatelessWidget {
  final Function onPressedYes;
  final int randomReward;
  const EndGameDialog(
      {Key? key, required this.onPressedYes, required this.randomReward})
      : super(key: key);

  // const EndGameDialog({Key? key, required this.stat}) : super(key: key);

  // final GameStat stat;

  @override
  Widget build(BuildContext context) {
    // final coinConvert =
    //     Provider.of<CoinConvertProvider>(context, listen: false);

    // var totalCoin = (coinConvert.coinConvert?.coin / 100) -
    //     ((coinConvert.coinConvert?.coin / 100) * (randomReward / 100));

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return const HomePage();
        }));
        return false;
      },
      child: Center(
        child: SizedBox(
          width: 250,
          height: 275,
          child: Stack(
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.grey,
                  // color: Color(0XFFE7EAEB),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          size: 50,
                          color: Color(0XFFF6D100),
                        ),
                        // Icon(
                        //   stat.win
                        //       ? Icons.emoji_events
                        //       : Icons.sentiment_dissatisfied,
                        //   size: 50,
                        //   color: stat.win ? const Color(0XFFF6D100) : null,
                        // ),
                        const Text(
                          'You Won',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${(randomReward * Constants.decimal).toStringAsFixed(Constants.decimalLength)} ${Constants.symbol}',
                          // '${(totalCoin).toStringAsFixed(Constants.decimalLength)} ${Constants.symbol}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Do you want to add it to your main balance?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        // Row(
                        //   children: const [
                        //     Text(
                        //       'Points Earned',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontSize: 28,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     Text(
                        //       "45",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontSize: 28,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Text(
                        //   stat.win ? 'You Win' : 'You Lose',
                        //   textAlign: TextAlign.center,
                        //   style: const TextStyle(
                        //     fontSize: 28,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Time Used',
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     Text(
                        //       stat.gameDuration.toMinutesSeconds(),
                        //       style: const TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Flips',
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     Text(
                        //       stat.flips.toString(),
                        //       style: const TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Matches',
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     Text(
                        //       stat.correct.toString(),
                        //       style: const TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Difficulty',
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     Row(
                        //       children: [
                        //         const Icon(Icons.star),
                        //         Icon(stat.difficulty != Difficulty.easy
                        //             ? Icons.star
                        //             : Icons.star_outline),
                        //         Icon(
                        //           stat.difficulty == Difficulty.hard
                        //               ? Icons.star
                        //               : Icons.star_outline,
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 25,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const HomePage();
                    }));
                  },
                  child: const Text('No'),
                ),
                // child: GestureDetector(
                //   onTap: () =>
                //       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //     return const HomePage();
                //   })),
                //   child: Container(
                //     width: 75,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(10),
                //       ),
                //       // color: Colors.red,
                //       color: HSLColor.fromColor(const Color(0XFFE7EAEB))
                //           .withLightness(0.55)
                //           .toColor(),
                //     ),
                //     child: const Text("No Thank You"),
                //   ),
                // ),
              ),
              Positioned(
                bottom: 0,
                left: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    onPressedYes();
                  },
                  child: const Text('Yes'),
                ),
                // child: GestureDetector(
                //   onTap: () => Navigator.pushNamedAndRemoveUntil(
                //       context,
                //       '/game',
                //       ModalRoute.withName(
                //           '/newGame') // Replace this with your root screen's route name (usually '/')
                //       ),
                //   child: Container(
                //     width: 75,
                //     height: 50,
                //     decoration: BoxDecoration(
                //         borderRadius: const BorderRadius.all(
                //           Radius.circular(10),
                //         ),
                //         color: Colors.yellow.shade800),
                //     child: const Text(
                //       "Save",
                //       style: TextStyle(fontSize: 12.0),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
