import 'package:facebook_login/errorHandler.dart';
import 'package:flutter/material.dart';

import '../services.dart';
import 'Home.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final formkey= GlobalKey<FormState>();

  String? email;
  String? password;

  checkField(){
    final form=formkey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  validateEmail(String value){
    String pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp= new RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Enter Valid Email';
    }else
      return null;

  }

  //

  buildLogin(){
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Stack(
              children: [
                Text("SignUp",style: TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Truneo',
                ),),
                Positioned(
                    top: 40,
                    left: 195,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.lightGreen
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 25,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen)
              ),
            ),
            onChanged: (value){
              this.email=value;
            },
            validator: (value)=>value!.isEmpty? 'Email is required' : validateEmail(value),
          ),
          //
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen)
              ),
            ),
            obscureText: true,
            onChanged: (value){
              this.password=value;
            },
            validator: (value)=>value!.isEmpty? 'Password is required' : null,
          ),
          SizedBox(height: 10,),

          SizedBox(height: 40,),
          ElevatedButton(onPressed: (){
            if(checkField()){
              AuthServices().Singup(email!, password!).then((userCreds){
                Navigator.of(context).pop();
              }).catchError((e){
                ErrorHandler() .errorDialog(context,e);
              });
            }}, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('SignUp',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
            style: ButtonStyle(

                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.white.withOpacity(0.5);
                    return Colors.lightGreen; // Use the component's default.
                  },
                ),
                //
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),

                    )
                )
              //
            )
            ,),
          SizedBox(height: 40,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Already have an account? ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
             InkWell(
               onTap: (){
                 Navigator.pop(context);
               },
               child: Text('Login',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen,
                 decoration: TextDecoration.underline,)),
             )
           ],
         )
        ],
      ),
    );

  }


  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Form(
    key: formkey,
    child: buildLogin(),
    )));
  }
}
