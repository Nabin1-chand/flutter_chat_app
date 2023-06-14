import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      // upperBound: 100,
    );
    // animation = CurvedAnimation(parent: controller
    // , curve: decelerateEasing);
    // controller.reverse(from: 1.0);

    controller.forward();
    // if we use controller.forward() then use animation.addListener((status) {
    //   if(status == AnimationStatus.completed){
    //     controller.reverse(from:1.0),
    //   }
    //   else  if(status ==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });
    animation =
        ColorTween(begin: Colors.red, end: Colors.white).animate(controller);
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      // if we use animtion we use animation.value
      // for height of image we use height: animation.value * 100
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller.value),
      // backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  // '${controller.value.toInt()}%',
                  'Chat App',
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600),
                ),
              ),
              CustomRoundedButtom(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              CustomRoundedButtom(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                title: 'Register',
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRoundedButtom extends StatelessWidget {
  const CustomRoundedButtom(
      {super.key, this.title, this.color, required this.onPressed});
  final Color? color;
  final String? title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title!,
          ),
          minWidth: 200.0,
          height: 42.0,
        ),
      ),
    );
  }
}
