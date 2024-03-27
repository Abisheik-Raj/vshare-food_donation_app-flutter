import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/timeline_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int points = 0;
  String username = "";
  int numberOfTimelines = 0;
  int temp = 0;

  void changePoints(int number) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((userDoc) {
      int userPoints = userDoc['points'];

      setState(() {
        points = userPoints;
        username = userDoc["username"];
      });
    });
    super.initState();
  }

  @override
  void initState() {
    // TODO: implement initState
    changePoints(0);
    if (points > 50) {
      temp = points - 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkGreenColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  children: [
                    const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/madhu.jpg")),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$username",
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(133, 151, 113, 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 10),
                            child: Text(
                              "$points ⭐️",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PoppinsSemiBold",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AuthService>(context, listen: false)
                                .logout();
                          },
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "100",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 100 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "200",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 200 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "500",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 500 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "1K",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 1000 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "2K",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 2000 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "5K",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 5000 ? Icons.done : Icons.api_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TimeLineComponent(
                  text: "10K",
                  isFirst: true,
                  isLast: true,
                  isPast: true,
                  color: Color.fromRGBO(133, 151, 113, 1),
                  icon: points >= 10000 ? Icons.done : Icons.api_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
