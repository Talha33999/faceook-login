import 'package:flutter/material.dart';

import '../errorHandler.dart';
import '../services.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {


  final formkey= GlobalKey<FormState>();

  String? email;

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
                Text("Reset",style: TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Truneo',
                ),),
                Positioned(
                    top: 50,
                    child: Text("Password",style: TextStyle(
                      color: Colors.black,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Truneo',
                    ),)),
                Positioned(
                    top: 88,
                    left: 265,
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

          SizedBox(height: 10,),

          SizedBox(height: 40,),
          ElevatedButton(onPressed: (){
            if(checkField()){
              AuthServices().ResetPassword(email!);
              Navigator.pop(context);
            }}, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Reset',
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
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text('Go Back',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen,
                  decoration: TextDecoration.underline,)),
              )
            ],
          )
        ],
      ),
    );

  }

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
