import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class connect_me extends StatefulWidget {
  const connect_me({ Key? key }) : super(key: key);

  @override
  _connect_meState createState() => _connect_meState();
}

class _connect_meState extends State<connect_me> {

  getUser() async {
    var users=[];
    var get_response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(get_response.body);

    for(var i in jsonData){
      UserModel um = UserModel(i['name'], i['username'], i['address']['geo']['lat']);
      users.add(um);
    }

    //i['address']['geo']['lat'] we use this for multilayered data


    return users;


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUser(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(child: Text('No Data in API'),);
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,i){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Name: '+snapshot.data[i].name,style: TextStyle(fontSize: 25),),  
                  Text('Username: '+snapshot.data[i].username,style: TextStyle(fontSize: 20),),  
                  Text('Latitude: '+snapshot.data[i].address,style: TextStyle(fontSize: 15),),  
                  SizedBox(height: 20,)
                  ],
                );
              });


            //For Getting only the desired record we use this.

            // return Column(
            //   children: [
            //     Text(snapshot.data[9].email),
            //   ],
            // );
          }
        }
        
      ),
    );
  }
}

class UserModel{

  var name,username,address;
  UserModel(this.name,this.username,this.address);
}