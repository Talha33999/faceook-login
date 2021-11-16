import 'package:facebook_login/model/product.dart';
import 'package:facebook_login/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'Cart.dart';

class HomeTwo extends StatefulWidget {
  HomeTwo({Key? key}) : super(key: key);

  @override
  _HomeTwoState createState() => _HomeTwoState();
}

class _HomeTwoState extends State<HomeTwo> {
  getuser()async{
    print("pressed");
    // var response=await http.get(Uri.https('newsapi.org', 'v2/everything?domains=wsj.com&apiKey=5f852143440a4c4d9a7971f303a056b5'));

    http.Response response;
    response=await http.get(Uri.parse('https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    // print(await http.read('https://example.com/foobar.txt'));
    var new1=null;
    try{
      if(response.statusCode==200){
        var jsonstring=response.body;
        print(jsonstring);
        return welcomeFromJson(jsonstring);
        //    var jsonMap=jsonDecode(jsonstring);
        //   new1=Welcome.fromJson(jsonMap);

      }else{
        print("no data");
      }
    }catch(e){
      //return new1;
    }
    //return new1;
// return welcomeFromJson(jsonstring);

  }

  var scaff= GlobalKey<ScaffoldState>();

  //bool a =true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaff,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                icon: Icon(Icons.search_rounded,color: Colors.black,size: 40,),onPressed: (){},
              ),
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.menu,color: Colors.black,size: 40,),
            onPressed: (){
              scaff.currentState!.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
           children: [
             SizedBox(height: 30,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Welcome To ShopX",style: TextStyle(
                   color: Colors.grey.shade700,
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                   decoration: TextDecoration.underline,),),
               ],
             ),
             SizedBox(height: 30,),
             Container(
               alignment: Alignment.center,
               height: 40,
               color: Colors.transparent,
               child: GestureDetector(
                 onTap: (){
                   AuthServices().signOut();
                 },
                 child: Text("Log Out",style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),),
               ),
             )
           ],

          ),
        ),

        backgroundColor: Colors.white,
        body: FutureBuilder<dynamic>(
          future: getuser(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("ShopX",style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                                  },
                                  child: Icon(Icons.shopping_cart,color: Colors.black,size: 40,)),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: StaggeredGridView.countBuilder(
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            crossAxisCount: 2,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              //var art=snapshot.data!.Welcome[index];
                              return GestureDetector(
                                onTap: (){
                                  print("hello");
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 180,
                                              width: double.infinity,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Image.network(
                                                snapshot.data[index].imageLink,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child:CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: IconButton(
                                                  icon:Icon(Icons.favorite_rounded,color: Colors.grey,),
                                                  onPressed: () {
                                                    //product.isFavorite.toggle();
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          snapshot.data[index].name,
                                          maxLines: 2,
                                          style:
                                          TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        if (snapshot.data[index].rating != null)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  snapshot.data[index].rating.toString(),
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(height: 8),
                                        Text('\$${snapshot.data[index].price}',
                                            style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index)=>StaggeredTile.fit(1))
                    )
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },


        ),
      ),
    );
  }
}