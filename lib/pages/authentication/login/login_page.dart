// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giveandgetapp/pages/home/home_page.dart';

import '../../../shared/widgets/my_input_field.dart';
import '../../../shared/widgets/my_text_button.dart';
import '../register/register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage("background"), fit: BoxFit.cover),
            ),
            child: Center(
              child: Image(
                image: AssetImage("logo"),
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(64))),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 48),
                          ),
                          SizedBox(height: 60,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MyInputField(label: 'Email', placeholder: 'abc@gmail.com', textEditingController: emailController, isPasswordField: false),
                              SizedBox(height: 40),
                              MyInputField(label: 'Senha', placeholder: '*********', textEditingController: passwordController, isPasswordField: true),
                              SizedBox(height: 40),
                              MyTextButton(label: "LOGIN",
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>Home())
                                );
                              },
                              )
                            ],
                          ),
                          SizedBox(height: 60,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Não possui conta? ",
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>Register())
                                  );
                                },
                                child: Text(
                                  "Cadastre-se ",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

