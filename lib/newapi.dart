import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
class apiclass extends StatefulWidget {
  const apiclass({super.key});

  @override
  State<apiclass> createState() => _apiclassState();
}

class _apiclassState extends State<apiclass> {

  List users =[];
  bool isloading = false;

  Future <void> fetchUsers() async{
    setState(() {
      isloading = true;
    });

    final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    setState(() {
      isloading =false;
    });

    print(response.statusCode);

    if(response.statusCode == 200){
      users = jsonDecode(response.body);
    }else{
      throw Exception('Failed to load exception.');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
      ),
      body: isloading ? ShimmerListTile(): ListView.builder(
        itemCount:users.length,
          itemBuilder: (context, index){
            final user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(user["name"][0]),
              ),
              title: Text(user["name"],
              style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4,),
                  Text('Username: ${user['username']}', style: TextStyle(color: Colors.grey),),
                  Text('Email: ${user['email']}', style: TextStyle(color: Colors.grey),),
                  Text('Phone: ${user['phone']}', style: TextStyle(color: Colors.grey),),
                  Text('Website: ${user['website']}', style: TextStyle(color: Colors.grey),),
                  Text('Address: ${user['address']['street']},${user['address']['city']},'
                      ',${user['address']['geo']['lat']}', style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
          );
          }
      )
    );
  }
}


class ShimmerListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 25,
            ),
            title: Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[300],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Container(
                  width: 200,
                  height: 12,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 4),
                Container(
                  width: 150,
                  height: 12,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 4),
                Container(
                  width: 120,
                  height: 12,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
