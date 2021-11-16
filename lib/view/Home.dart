import 'package:facebook_login/services.dart';
import 'package:facebook_login/view/HomeTwo.dart';
import 'package:facebook_login/view/resetpass.dart';
import 'package:facebook_login/view/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                Text("Hello",style: TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                 // fontFamily: 'Truneo',
                ),),
                Positioned(
                    top: 55,
                    child: Text("There",style: TextStyle(
                      color: Colors.black,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Truneo',
                    ),)),
                Positioned(
                    top: 92,
                    left: 157,
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
          Container(
            alignment: Alignment.centerRight,
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>ResetPassword()));
                },
                child: Text('forget password',
            style: TextStyle(
              color: Colors.lightGreen,
              decoration: TextDecoration.underline,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),)),
          ),
          SizedBox(height: 40,),
          ElevatedButton(onPressed: (){
            if(checkField()){
            AuthServices().signIn(email!, password!, context);
          }}, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Login',
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
          GestureDetector(
            onTap: (){
              AuthServices().fbSignin();
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeTwo()));
            },
            child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
               border: Border.all(
                 color: Colors.black,
                 style: BorderStyle.solid,
                 width: 1.0
               ),
               borderRadius: BorderRadius.circular(25)
             ),
              height: MediaQuery.of(context).size.height*0.07,
              width: MediaQuery.of(context).size.width*0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                   height: 20,
                   width: 20,
                   child: FittedBox(
                      child: Image.asset('assets/download.png'),
                      fit: BoxFit.fill,
                    ),
                 ),
                  SizedBox(width: 10,),
                  Center(child: Text('Login with facebook',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New to ShopX? ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                },
                child: Text('Register',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen,
                  decoration: TextDecoration.underline,),),
              )
            ],
          )


        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formkey,
            child: buildLogin(),
          ),

        ),
      ),
    );
  }
}
