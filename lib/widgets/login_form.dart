import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario/screens/home_screen.dart';
import '../config/constants/enviroment.dart';
import '../widgets/custom_text_form.dart';

//import '../JsonModels/users.dart';
//import '../constants/enviroment.dart';

class Desing extends StatefulWidget {
  const Desing({super.key});


  @override
  State<Desing> createState() => _DesingState();
}

class _DesingState extends State<Desing> {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    
    super.initState();
  }

  Future login(String user, String password) async {
    //final response = await Dio().post('http://192.168.0.151/API/login.php');
    final res = await dio.post("/login.php", data: {
      "username": user,
      "password": password
    }); 

    //print( res.data);
    final String message = jsonDecode(res.data);
    //print(message);
    if(message == 'Success'){
      //context.push('/home');
      return message;
    } else {
      return message;
    }
  }


  final username = TextEditingController();

  final password = TextEditingController();

  bool isVisible = false;
  bool isLoginTrue = false;
  


  //final check = ;



 final  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.23,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
            width: double.infinity,
            //height: 750,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xff373A40),
                      blurRadius: 3,
                      offset: Offset(5, 15))
                ]),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.0,
                ),
                Text(
                  'Login',
                  style: GoogleFonts.abrilFatface(
                    fontSize: screenSize.width * 0.2,
                    color: const Color(0xffD10363),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.1),
                Form(
                  key: _globalKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
                          child: TextFormFields(
                            controller: username,
                            hint: 'mx-ejemplo',
                            labelText: 'UserName:',
                            icono: const Icon(Icons.person_2_rounded),
                            validators: (value) {
                              if(value!.isEmpty){
                                return "UserName is Required";
                              }
                              return null;
                            },
                          )),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03), // Ajustar márgenes),
                        child: TextFormFields(
                          controller: password,
                          oscureText: !isVisible,
                          hint: '********',
                          suffixIcon: IconButton(onPressed: () {
                            setState((){
                              isVisible = !isVisible;
                            });
                          }, icon:  Icon(isVisible 
                          ? Icons.visibility
                          :Icons.visibility_off), color: const Color(0xffD10363),),
                          labelText: 'Password:',
                          icono: const Icon(Icons.lock_outline_sharp),
                          validators: (value) {

                            if (value!.isEmpty){
                              return "Pasword is Required";
                            }
                
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: const Color(0xffFFE8C8),
                        color: const Color(0xffD10363),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.2, vertical: 15),
                          child: const Text(
                            'LogIn',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          if( _globalKey.currentState!.validate()){
                            final resp = await login(username.text, password.text);
                            if(resp == 'Success'){
                              // ignore: use_build_context_synchronously
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(username.text)));
                            } else {
                              Fluttertoast.showToast(
                                msg: "Usuario o Contraseña Incorrecta",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 20.0
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: screenSize.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿Don't have an account?",
                            style: TextStyle(color: Color(0xff1A2130)),
                          ),
                          TextButton(
                              onPressed: () => context.push('/register'),
                              child: const Text(
                                'Sing Up',
                                style: TextStyle(color: Color(0xff8E3E63)),
                              ))
                        ],
                      ),

                      isLoginTrue? const Text("UserName or Password is incorrect", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                      : const SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
