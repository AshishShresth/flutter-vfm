import 'dart:convert';

//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vfm/api/authorization_api.dart';
import 'package:vfm/screens/register.dart';

import 'home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>(); //This uniquely identifies the Form, and allows validaton of the form in the later step.
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg){
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'close', 
        onPressed: (){

        }
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    //Build a Form widget using _formKey created above
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        color: Colors.indigoAccent,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 150, 20, 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Virtual ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Farmers ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  )
                                ),
                                TextSpan(
                                  text: 'Market',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      Card(
                        elevation: 4.0,
                        color: Colors.indigo,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.emailAddress,
                                   decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  validator: (emailValue) {
                                      if (emailValue.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      email = emailValue;
                                      return null;
                                    },
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  validator: (passwordValue) {
                                      if (passwordValue.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      password = passwordValue;
                                      return null;
                                    },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: RaisedButton(
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      child: Text(
                                        _isLoading? 'Processing...' : 'Login',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 15.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    color: Colors.white,
                                    disabledColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    onPressed: (){
                                      if(_formKey.currentState.validate()){
                                        _login();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:20,),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => Register()
                              )
                            );
                          },
                          child: Text(
                            'Create New Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };

    var res = await AuthApi().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', jsonEncode(body['token']));
      localStorage.setString('user', jsonEncode(body['user']));
      Navigator.push(context,
       MaterialPageRoute(
         builder: (context) => HomeScreen(),
       ),
      );
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}