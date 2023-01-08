// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fuel/res/constants/screen_size.dart';
import 'package:fuel/res/views/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool signIn = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(239, 238, 251, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.4,
                child: Image.asset(
                  'assets/logo1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: signIn
                                ? Colors.black
                                : Colors.grey.withOpacity(0.7)),
                        onPressed: () {
                          setState(() {
                            signIn = true;
                          });
                        },
                        child: Text('Sign In')),
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: signIn == false
                                ? Colors.black
                                : Colors.grey.withOpacity(0.7)),
                        onPressed: () {
                          setState(() {
                            signIn = false;
                          });
                        },
                        child: Text('Sign Up'))
                  ],
                ),
              ),
              signIn
                  ? Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              emailfield(),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              passwordfield()
                            ],
                          )),
                    )
                  : Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              nameField(),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              emailfield(),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              passwordfield()
                            ],
                          )),
                    ),
              SizedBox(
                height: height * 0.005,
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    },
                    child: Text(signIn ? 'Sign In' : 'Sign Up')),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.grey),
                        onPressed: () {},
                        child: const Text('Forget Password !')),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  emailfield() {
    return SizedBox(
      height: height * 0.1,
      width: width * 0.9,
      child: TextFormField(
        validator: ((value) {
          if (value!.isEmpty) return 'Email can\'t be empty';
          return null;
        }),
        decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.green),
          hintStyle: TextStyle(color: Colors.green),
          hintText: 'Example@Example.ex',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          label: Text('Email'),
        ),
      ),
    );
  }

  passwordfield() {
    return SizedBox(
        height: height * 0.1,
        width: width * 0.9,
        child: TextFormField(
          validator: ((value) {
            if (value!.isEmpty) return 'Password can\'t be empty';
            return null;
          }),
          decoration: const InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.green),
            hintStyle: TextStyle(color: Colors.green),
            hintText: '*******',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.yellow,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            label: Text('Password'),
          ),
        ));
  }

  nameField() {
    return SizedBox(
        height: height * 0.1,
        width: width * 0.9,
        child: TextFormField(
          validator: ((value) {
            if (value!.isEmpty) return 'Name can\'t be empty';
            return null;
          }),
          decoration: const InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.green),
            hintStyle: TextStyle(color: Colors.green),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.yellow,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            label: Text('Name'),
          ),
        ));
  }
}
