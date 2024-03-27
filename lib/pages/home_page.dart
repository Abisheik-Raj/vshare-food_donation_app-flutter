import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:vshare/resources/Colors.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreenColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      Image(image: AssetImage("assets/images/restaurant.png")),
                ),
                // Image(image: AssetImage("assets/images/green1.png")),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Grab it!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Previous Donations",
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    Text(
                      "",
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          color: Colors.white,
                          fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  height: 600,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("donations")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      } else if (snapshot.hasError) {
                        return const CircularProgressIndicator(
                          color: Colors.red,
                        );
                      } else {
                        final data = snapshot.data!;
                        print(data.docs);

                        return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              final document = data.docs[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(52, 90, 65, 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 15),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Food",
                                              style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${document["foodname"]} (${document["quantity"]})",
                                              style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  color: Color.fromRGBO(
                                                      164, 198, 148, 1),
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             ScannerPage()));
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userId)
                                                    .get()
                                                    .then((userDoc) {
                                                  String userName =
                                                      userDoc['username'];
                                                  FirebaseFirestore.instance
                                                      .collection('donations')
                                                      .doc(document['foodname'])
                                                      .delete();
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          '$userId-donations')
                                                      .doc(document['foodname'])
                                                      .update({
                                                    'status': 'Grabbed',
                                                    'reciever': userName,
                                                  });
                                                });
                                              },
                                              child: Text(
                                                "Grab it!",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                    color: Color.fromRGBO(
                                                        164, 198, 148, 1),
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
