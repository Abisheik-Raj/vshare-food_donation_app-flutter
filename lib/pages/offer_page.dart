import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:vshare/components/textfield_component.dart";
import "package:vshare/firebase_storage.dart";
import "package:vshare/resources/Colors.dart";

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  TextEditingController foodcontroller = TextEditingController();

  TextEditingController quantitycontroller = TextEditingController();
  // late File imagey;
  var image;
  final imagePicker = ImagePicker();
  int points = 0;

  void changePoints(int number) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((userDoc) {
      int userPoints = userDoc['points'];

      setState(() {
        points = userPoints + number;
      });

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"points": points});
    });
    super.initState();
  }

  @override
  void initState() {
    // TODO: implement initState
    changePoints(0);
  }

  Future getImage() async {
    image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      // imagey = File(image!.path);
    });
  }

  void saveProfile() async {
    String name = foodcontroller.text;
    String bio = quantitycontroller.text;

    String resp = await StoreData().saveData(name: name, bio: bio, file: image);
  }

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
                  child: Image(image: AssetImage("assets/images/tray.png")),
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
                "Donate it!",
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
              child: Column(
                children: [
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
                    height: 170,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseAuth.instance.currentUser!.uid +
                              "-donations")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                document["foodname"],
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsSemiBold",
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
                                              Text(
                                                document["status"] == "Not yet!"
                                                    ? "Not yet Grabbed"
                                                    : "Grabbed",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                document["reciever"] == ""
                                                    ? "-"
                                                    : document["reciever"],
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                    color: Color.fromRGBO(
                                                        164, 198, 148, 1),
                                                    fontSize: 15),
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
                  const Padding(
                    padding: EdgeInsets.all(50),
                    child: Divider(
                      thickness: 5,
                      color: Color.fromRGBO(52, 90, 65, 1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(133, 151, 113, 1),
                        ),
                        width: 170,
                        height: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            const Text("Wohoo",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "PoppinsBold",
                                    color: Color.fromRGBO(90, 89, 75, 1))),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: darkGreenColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "${points}",
                                    style: TextStyle(
                                        color: yellowColor,
                                        fontFamily: "PoppinsBold",
                                        fontSize: 10),
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Keep Donating!",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "PoppinsBold",
                                    color: darkGreenColor)),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(65, 118, 94, 1),
                        ),
                        width: 170,
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Share your surplus. Feed someone's soul",
                                style: TextStyle(
                                    fontFamily: "PoppinsBold",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: [],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: lighterGreenColor,
                                          content: Container(
                                            width: 400,
                                            height: 400,
                                            child: Column(
                                              children: <Widget>[
                                                TextFieldComponent(
                                                  hintText: "Enter food name: ",
                                                  icon: Icon(
                                                    Icons.fastfood,
                                                    color: Colors.white,
                                                  ),
                                                  textEditingController:
                                                      foodcontroller,
                                                ),
                                                SizedBox(height: 20),
                                                TextFieldComponent(
                                                  textEditingController:
                                                      quantitycontroller,
                                                  hintText: "Enter quantity: ",
                                                  icon: const Icon(
                                                    Icons.shopping_bag,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                IconButton(
                                                  onPressed: getImage,
                                                  icon: const Icon(
                                                    Icons.add_a_photo,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid +
                                                            "-donations")
                                                        .doc(
                                                            foodcontroller.text)
                                                        .set({
                                                      "foodname":
                                                          foodcontroller.text,
                                                      "quantity":
                                                          quantitycontroller
                                                              .text,
                                                      "status": "Not yet!",
                                                      "reciever": ""
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection("donations")
                                                        .doc(
                                                            foodcontroller.text)
                                                        .set({
                                                      "foodname":
                                                          foodcontroller.text,
                                                      "quantity":
                                                          quantitycontroller
                                                              .text,
                                                      "status": "Not yet!",
                                                      "reciever": "",
                                                      "donator": FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid
                                                    });

                                                    foodcontroller.clear();
                                                    quantitycontroller.clear();
                                                    Navigator.pop(context);
                                                    changePoints(10);
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             Generator(
                                                    //                 qrData: foodcontroller
                                                    //                     .text)));
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: const Color
                                                            .fromRGBO(
                                                            65, 118, 94, 1),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16,
                                                                vertical: 3),
                                                        child: Text("Donate",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "PoppinsSemiBold",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            164, 198, 148, 1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          'Donate',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "PoppinsSemiBold",
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
