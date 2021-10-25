import 'package:camera/camera.dart';
import 'package:camera_app/home.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../styling/styles.dart';
import '../Widgets/background_image.dart';

class Welcome extends StatefulWidget {
  const Welcome({
    Key? key,
    required this.title,
    this.cams,
  }) : super(key: key);
  final String title;
  final List<CameraDescription>? cams;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String? _userName;
  String? _passWord;
  //final TextEditingController _userNameText = TextEditingController();
  //final TextEditingController _passwordText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(25),
              ),
              const Center(
                child: Text(
                  'Camera App',
                  style: kHeading,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 90, 0, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Enter User name',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'UserName',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  onSaved: (value) {
                    _userName = value;
                    Logger().i(_userName);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  90,
                  90,
                  0,
                  0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  onSaved: (value) {
                    _passWord = value;
                    Logger().i(_passWord);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                title: widget.title, cams: widget.cams!),
                          ));
                    },
                    child: const Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
