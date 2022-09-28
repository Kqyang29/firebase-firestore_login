import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/screens/home_page.dart';
import 'package:firebase_login/screens/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //formkey = helpful in validating the email and password
  final _formKey=GlobalKey<FormState>();

  //editing controller 
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return( "Please Enter your Email");
        }
        // reg experssion 
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Please Enter a Vaild email");
        }
        return null;
      },
      onSaved: (value){
        emailController.text=value!;
      },
      // the action when user click the input bar
      textInputAction:TextInputAction.next ,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');

        if(value!.isEmpty){
          return ("Password is required for login");
        }

        if(!regex.hasMatch(value)){
          return ("Please Enter Valid Password (Min 6 chars)");
        }

      },
      onSaved: (value){
        passwordController.text=value!;
      },
      // the action when user click the input bar
      textInputAction:TextInputAction.done ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: Icon(Icons.vpn_key),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: (){
          SignIn(emailController.text, passwordController.text);
        },
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset("images/logo.png",fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 45,),
                    emailField,
                     SizedBox(height: 25,),
                    passwordField,
                     SizedBox(height: 35,),
                    loginButton,
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return SignupPage();
                            }));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }

  // login function
  void SignIn(String email,password) async {
    if(_formKey.currentState!.validate()){
      await _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()))
      }).catchError((e){
        Fluttertoast.showToast(msg: e.toString());
       
      });
    }
  }
}
