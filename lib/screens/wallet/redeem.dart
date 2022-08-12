import 'package:faucet_base_app/utils/constants.dart';
import 'package:faucet_base_app/widgets/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Redeem extends StatelessWidget {
  const Redeem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DesignText(
          "Redeem",
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 40,
            color: Constants.blueDark,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/wallet.svg",
                                height: 55,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  DesignText(
                                    "Wallet Money:",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  DesignText(
                                    "0",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
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
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DesignText(
                          "Select Payment Method",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Constants.blueDark,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.network(
                              "https://upload.wikimedia.org/wikipedia/commons/2/24/Paytm_Logo_%28standalone%29.svg",
                              height: 25,
                            ),
                            SvgPicture.network(
                              "https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg",
                              height: 25,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const DesignText(
                          "Enter Details",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        // const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextField(
                                // controller: email,
                                decoration: InputDecoration(
                                  hintText: 'Enter Mobile No.',
                                  filled: true,
                                  fillColor: Constants.blueLiteBg,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueGrey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueLiteBg, width: 0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueLiteBg, width: 0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 3, 6, 3),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                // controller: email,
                                decoration: InputDecoration(
                                  hintText: 'Enter Mobile No.',
                                  filled: true,
                                  fillColor: Constants.blueLiteBg,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueGrey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueLiteBg, width: 0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.blueLiteBg, width: 0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 3, 6, 3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding:
                                  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                  side: BorderSide(
                                      width: 1, color: Constants.blueGrey)),
                              backgroundColor: Colors.white,
                            ),
                            child: const DesignText(
                              'Redeem Money',
                              color: Constants.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
