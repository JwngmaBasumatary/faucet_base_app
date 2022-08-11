// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:maker_faucet/models/home_card_model_two.dart';
//
// import '../utils/constants.dart';
// import '../utils/tools.dart';
//
// Widget homeCardWidget(BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.indigo)),
//     width: MediaQuery.of(context).size.width * 0.9,
//     child: Column(
//         children: HomeCardModelTwo.newHomeCards
//             .asMap()
//             .entries
//             .map((e) => getDashboardTile(context, e.value))
//             .toList()),
//   );
// }
//
// Widget getDashboardTile(
//     BuildContext context, HomeCardModelTwo homeCardModelTwo) {
//   return Padding(
//     padding: const EdgeInsets.all(5),
//     child: Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: homeCardModelTwo.left
//               ? Constants.dashboardContainerColor
//               : Constants.dashboardContainerColor.withOpacity(0.5),
//         ),
//         onPressed: () {
//           Navigator.of(context).pushNamed(homeCardModelTwo.routeName);
//         },
//         child: homeCardModelTwo.left
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0),
//                     child: Container(
//                       height: 70,
//                       width: 80,
//                       decoration: BoxDecoration(
//                           color: Tools.multiColors[
//                               Random().nextInt(Tools.multiColors.length - 1)],
//                           borderRadius: BorderRadius.circular(10)),
//                       margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                       child: Lottie.asset(
//                         homeCardModelTwo.icon,
//                         repeat: true,
//                         reverse: true,
//                         animate: true,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 30.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Flexible(
//                           child: Text(
//                             homeCardModelTwo.title,
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Text(
//                           homeCardModelTwo.subTitle,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         Text(
//                           "${(homeCardModelTwo.rewardPoints * Constants.decimal).toStringAsFixed(Constants.decimalLength)} ${Constants.symbol}",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 30.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           homeCardModelTwo.title,
//                           style: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           homeCardModelTwo.subTitle,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         Text(
//                           "${(homeCardModelTwo.rewardPoints * Constants.decimal).toStringAsFixed(Constants.decimalLength)} ${Constants.symbol}",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0),
//                     child: Container(
//                       height: 70,
//                       width: 80,
//                       decoration: BoxDecoration(
//                           color: Tools.multiColors[
//                               Random().nextInt(Tools.multiColors.length - 1)],
//                           borderRadius: BorderRadius.circular(10)),
//                       margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                       child: Lottie.asset(
//                         homeCardModelTwo.icon,
//                         repeat: true,
//                         reverse: true,
//                         animate: true,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     ),
//   );
// }
