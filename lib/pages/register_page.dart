import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/textfield_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowColor,
        onPressed: () {
          Provider.of<AuthService>(context, listen: false).register(
              usernameController.text,
              emailController.text,
              passwordController.text);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.arrow_forward,
          size: 25,
        ),
      ),
      backgroundColor: lightGreenColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Image(image: AssetImage("assets/images/cell.png")),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Create an\nAccount",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    const Text(
                      "Already a Member?  ",
                      style: TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsRegular",
                          fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                color: darkGreenColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldComponent(
                        textEditingController: usernameController,
                        hintText: " Username",
                        icon: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      TextFieldComponent(
                        textEditingController: emailController,
                        hintText: " Email",
                        icon: const Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      TextFieldComponent(
                        textEditingController: phoneController,
                        hintText: " Phone number",
                        icon: const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      TextFieldComponent(
                        textEditingController: passwordController,
                        hintText: " Password",
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "I have read and agree to Terms &\nConditions of the company",
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: "PoppinsRegular",
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
