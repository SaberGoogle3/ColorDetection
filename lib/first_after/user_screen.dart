import 'package:flutter/material.dart';

class UserModel
{
  final int id;
  final String name;
  final String phone;
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
  });
}
class UserScreen extends StatelessWidget {
  List<UserModel> users=
  [
    UserModel(
        id: 1,
        name:'saber challenge',
        phone: '+20112345823'),
    UserModel(
        id:2,
        name:'saber dream',
        phone: '+1284213022'),
    UserModel(
        id:3,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:4,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:5,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:6,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:7,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:8,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:5,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:6,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:7,
        name:'Mo ',
        phone:'1830923818' ),
    UserModel(
        id:8,
        name:'Mo ',
        phone:'1830923818' ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body:ListView.separated(
          itemBuilder:(context,index)=>buildUserItem(users[index]),
          separatorBuilder:(context,index)=>Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color:Colors.grey[300],
            ),
          ),
          itemCount:users.length,)
    );
  }
  Widget buildUserItem(UserModel user)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius:25,
          child: Text('${user.id}'),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.name}'
              ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
            Text('${user.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),),
          ],
        ),
      ],
    ),
  );
}
