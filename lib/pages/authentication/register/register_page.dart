// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giveandgetapp/helpers/register/register_helper.dart';
import 'package:giveandgetapp/pages/authentication/login/login_page.dart';

import '../../../shared/widgets/my_input_field.dart';
import '../../../shared/widgets/my_text_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage("lib/assets/images/backgroung_GG.jpg"), // Caminho correto da imagem
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 30
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Login())
                          );
                        },
                        child: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 40,)
                    ),
                    Text(
                      "CADASTRE-SE",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(85)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 60,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyInputField(label: 'CPF', placeholder: '', textEditingController: cpfController, isPasswordField: false),
                      SizedBox(height: 20),
                      MyInputField(label: 'Primeiro Nome', placeholder: '', textEditingController: firstNameController, isPasswordField: false),
                      SizedBox(height: 20),
                      MyInputField(label: 'Sobrenome', placeholder: '', textEditingController: lastNameController, isPasswordField: false),
                      SizedBox(height: 20),
                      MyInputField(label: 'Email', placeholder: '', textEditingController: emailController, isPasswordField: false),
                      SizedBox(height: 20),
                      MyInputField(label: 'Senha', placeholder: '', textEditingController: passwordController, isPasswordField: true),
                      SizedBox(height: 20),
                      MyInputField(label: 'Confirmar Senha', placeholder: '', textEditingController: passwordController, isPasswordField: true),
                      SizedBox(height: 20),
                      MyTextButton(label: "Registrar",
                        onTap: (){
                        RegisterHelper.saveDados(cpfController.text, firstNameController.text, lastNameController.text, emailController.text, passwordController.text);
                        },
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Já possui uma conta? ",
                            style: TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login())
                                  , (route) => false);
                            },
                            child: Text(
                              "Efetuar Login ",
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
          )
        ],
      ),
    );
  }
}

