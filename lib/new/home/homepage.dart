import 'package:faucet_base_app/ui/text.dart';
import 'package:faucet_base_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        title: const DesignText(
          "Home",
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const Drawer(),
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
                                "assets/svg/money.svg",
                                height: 55,
                              ),
                              const SizedBox(width: 6),
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
                          TextButton(
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
                              'Redeem',
                              color: Constants.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const HomeCard(
                  svgImage: "assets/svg/refer.svg",
                  descrition:
                      "Invite your friends and femily to get  more coins",
                  title: "REFER FRIENDS",
                  backgroundColor: Constants.blueLite,
                ),
                const HomeCard2(
                  svgImage: "assets/svg/network.svg",
                  descrition: "Get all my network",
                  title: "MY NETWORK",
                  backgroundColor: Constants.green,
                ),
                const HomeCard2(
                  svgImage: "assets/svg/box.svg",
                  descrition: "Tap & get more coins",
                  title: "MEGA BOX",
                  backgroundColor: Constants.blueLite,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: ((context, index) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/box.svg",
                              height: 60,
                            ),
                            DesignText(
                              "Name",
                              color: Constants.blueDark,
                            ),
                          ],
                        ));
                      })),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignText(
                          "MORE OFFER",
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Constants.blueDark,
                        ),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
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

class MoreOfferCard extends StatelessWidget {
  const MoreOfferCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/money.svg",
                height: 55,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DesignText(
                      "Daily Scratch  - online job work",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4),
                    DesignText(
                      "Register and use app",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 2),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      side: BorderSide(width: 1, color: Constants.blueGrey)),
                  backgroundColor: Colors.white,
                ),
                child: const DesignText(
                  'Redeem',
                  color: Constants.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Divider(
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.title,
    required this.descrition,
    required this.svgImage,
    required this.backgroundColor,
  }) : super(key: key);
  final String title;
  final String descrition;
  final String svgImage;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(
                      title,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Constants.blueDark,
                    ),
                    const SizedBox(height: 6),
                    DesignText(
                      descrition,
                      color: Constants.blueDark,
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              svgImage,
              width: MediaQuery.of(context).size.width / 3,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard2 extends StatelessWidget {
  const HomeCard2({
    Key? key,
    required this.title,
    required this.descrition,
    required this.svgImage,
    required this.backgroundColor,
  }) : super(key: key);
  final String title;
  final String descrition;
  final String svgImage;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    svgImage,
                    height: 60,
                  ),
                  const SizedBox(width: 6),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText(
                        title,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Constants.blueDark,
                      ),
                      const SizedBox(height: 6),
                      DesignText(
                        descrition,
                        color: Constants.blueDark,
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
