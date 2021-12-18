import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Text(
              "Dein Set wurde zur Verfügung gestellt von",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: GestureDetector(
                onTap: () => launch("https://www.technik-tirol.at/"),
                child: Image.network(
                  "https://api.htlled.at/api/images/foerderverein.png",
                  width: deviceWidth / 1.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "Ein Projekt von",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: GestureDetector(
                onTap: () => launch("https://www.htlled.at/"),
                child: Image.network(
                  "https://api.htlled.at/api/images/banner.png",
                  width: deviceWidth / 1.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "Mit Liebe programmiert von",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      child: GestureDetector(
                        onTap: () =>
                            launch("https://www.instagram.com/maarsls_/"),
                        child: Column(children: [
                          Image.network(
                            "https://api.htlled.at/api/images/marcelmaffey.jpg",
                            width: deviceWidth / 4,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text("Marcel Maffey"),
                          )
                        ]),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    ),
                    GestureDetector(
                      onTap: () => launch("https://www.instagram.com/j.paati/"),
                      child: Column(children: [
                        Image.network(
                          "https://api.htlled.at/api/images/patrickjenewein.jpg",
                          width: deviceWidth / 4,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text("Patrick Jenewein"),
                        )
                      ]),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
