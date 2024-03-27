import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/button_component.dart";
import "package:vshare/components/textfield_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";

class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreenColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),
              const SizedBox(
                height: 25,
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
                  "Log In",
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
                      "Don't have an Account? ",
                      style: TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsRegular",
                          fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Register",
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
                height: MediaQuery.of(context).size.height - 300,
                color: darkGreenColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
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
                        textEditingController: passwordController,
                        hintText: " Password",
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: greyColor,
                                fontFamily: "PoppinsRegular",
                                fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  Provider.of<AuthService>(context,
                                          listen: false)
                                      .login(emailController.text,
                                          passwordController.text);
                                },
                                child: const ButtonComponent())),
                      ),
                      const SizedBox(
                        height: 50,
                      )
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
