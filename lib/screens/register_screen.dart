import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../config/constants/enviroment.dart';
import '../widgets/custom_text_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );


  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Future formRegister(String user, String password) async {
    final res = await dio.post("/adddata.php", data: {
      "username": user,
      "password": password
    });
    final String message = jsonDecode(res.data);
    if(message == 'Success'){
      return  message;
    } else {
      print('No es correcta la contraseña o el usuario');
    }
  }

  final  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

 bool isVisible= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                    const ListTile(
                      title: Text("Register New UserName", style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),),
                    ),
              
                  //Username
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      //color: Colors.deepPurple.withOpacity(.2)
                    ),
                    child: TextFormFields(hint: 'mx-ejemplo', labelText: 'UserName', icono: const Icon(Icons.person), validators: (value ) { if(value!.isEmpty){
                      return "UserName is Required";
                    } return null; }, controller: username,)
                  ),
              
                  //Password
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      //color: Colors.deepPurple.withOpacity(.2)
                    ),
                    child: TextFormFields(hint: '**********', labelText: 'Password', icono: const Icon(Icons.lock), validators: (value ) { if(value!.isEmpty){
                      return "Password is Required";
                    } return null; }, oscureText: !isVisible, suffixIcon: IconButton(onPressed: () { setState(() {
                      isVisible = !isVisible;
                    });}, icon: Icon(isVisible
                    ? Icons.visibility
                    : Icons.visibility_off)), controller: password,)
                  ),

                  //Confirm Password
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      //color: Colors.deepPurple.withOpacity(.2)
                    ),
                    child: TextFormFields(hint: '**********', labelText: 'Confirm Password', icono: const Icon(Icons.lock), validators: (value ) { if(value!.isEmpty){
                      return "Confirm Password is Required";
                    }else if(password.text != confirmPassword.text){
                      return "Password's don't match";
                    } 
                    return null; }, oscureText: !isVisible, suffixIcon: IconButton(onPressed: () { setState(() {
                      isVisible = !isVisible;
                    });}, icon: Icon(isVisible
                    ? Icons.visibility
                    : Icons.visibility_off)), controller: confirmPassword,)
                  ),

                  const SizedBox(height: 30),

                  // Button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if(_globalKey.currentState!.validate()) {
                          final resp = await formRegister(username.text, password.text);
                          //print(resp);
                          if(resp == 'Success'){
                            Fluttertoast.showToast(
                              msg: "Usuario Creado Correctamente",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 20.0
                            );
                            username.clear();
                            password.clear();
                            confirmPassword.clear();
                          } else {

                          }
                        }
                      },
                      child: const Text("SING UP", style: TextStyle(color: Colors.white),),
                    ),
                  ),

                  //Sing In
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿Already have an account?',
                            style: TextStyle(color: Color(0xff1A2130)),
                          ),
                          TextButton(
                              onPressed: () => context.push('/'),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Color(0xff8E3E63)),
                              ))
                        ],
                      ),

                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
