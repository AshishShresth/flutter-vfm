import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vfm/api/authorization_api.dart';
import 'package:vfm/screens/home_screen.dart';
import 'package:vfm/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();
  var first_name;
  var last_name;
  var email;
  var password;
  var address;
  var phone_number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        color: Colors.indigoAccent,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:50, bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          text: 'Virtual ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Farmers ',
                              style: TextStyle(
                                color: Colors.white,
                                //color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              )
                            ),
                            TextSpan(
                              text: 'Market',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              )
                            )
                          ]
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),

                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: Colors.indigo,
                      margin: EdgeInsets.only(left:20, right: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[   
                              SizedBox(
                                height: 10,
                              ),                    
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'First Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(1)
                                ),
                                validator: (firstname){
                                  if(firstname.isEmpty){
                                    return 'Please enter your first name';
                                  }
                                  first_name = firstname;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'Last Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8.0)
                                ),
                                validator: (lastname){
                                  if(lastname.isEmpty){
                                    return 'Please enter your last name';
                                  }
                                  last_name = lastname;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'Email Address',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8.0)
                                ),
                                validator: (emailValue) {
                                      if (emailValue.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      email = emailValue;
                                      return null;
                                    },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8.0)
                                ),
                                validator: (password){
                                  if(password.length < 8){
                                    return 'Please enter a password longer than 8';
                                  }
                                  password = password;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'Home Address',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8.0)
                                ),
                                validator: (address){
                                  if (address.isEmpty){
                                    return 'Please enter your home address';
                                  }
                                  address = address;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                cursorColor: Colors.indigo,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.indigo,
                                  ),
                                  hintText:'Phone Number',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15) 
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8.0)
                                ),
                                validator: (phonenumber){
                                  if(phonenumber.length != 10){
                                    return 'Mobile Number must be 10 digit';
                                  }
                                  phone_number = phonenumber;
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    child: Text(
                                      _isloading? 'Processing...' : 'Register',
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
                                    if (_formKey.currentState.validate()){
                                      _register();
                                    }
                                  },
                                )
                              )
                            ],
                          )
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:20, bottom: 20),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => Login())
                          );
                        },
                        child: Text(
                          'Already Have an Account? Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),  
    );
  }
  
  void _register() async{
    setState(() {
      _isloading = true;
    });
    var data = {
      'first_name' : first_name,
      'last_name' : last_name,
      'email' : email,
      'password': password,
      'address' : address,
      'phone_number' : phone_number,
    };
    
    var res = await AuthApi().authData(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Login()
          ),
        );
    }

    setState(() {
      _isloading = false;
    });
  }
}