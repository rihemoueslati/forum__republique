import 'package:flutter/material.dart';
import 'package:forum_republique/classes/user.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'detail.dart';
import 'login_page.dart';
class MyList extends StatefulWidget {
  MyList({Key? key}): super(key:key);


  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  Future getAll() async {
    var data = await http.get(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"));
    var jsonData = json.decode(data.body);
    List<User> users =[];
    for(var u in jsonData){

          User user =User(u['id'],u['name'],u['email'],u['password']);
          users.add(user);
    }
    if(data.statusCode==201 ||data.statusCode==200){
      print('ok');
    }else {
      print('error !');
    }
    print(users.length);
    return users;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAll();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: FutureBuilder(
         future: getAll(),
         builder: (BuildContext context,AsyncSnapshot snapshot){
           if(snapshot.data == null){
             return CircularProgressIndicator();
           }else{
           return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context,int index){
                  return  ListTile(
                           title: Text(snapshot.data[index].name),
                             subtitle: Text(snapshot.data[index].email),
               );
              }
             );}
         }
         ),

    );

  }
}
