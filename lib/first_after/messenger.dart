import 'package:flutter/material.dart';

class MessengerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title:Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0),
              child: CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage('https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
              ),
            ),
            SizedBox(width:7,),
            Text('Chats',
            style: TextStyle(
              color: Colors.black,
            ),),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon:CircleAvatar(
                radius: 17,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16,
                  color: Colors.white,
                ),
              ),),
          IconButton(
              onPressed: (){},
              icon:CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  )) ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(5.0),
                  color:Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 15),
                    Text('search'),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection:Axis.horizontal ,
                    itemBuilder:(context,index)=>buildStoryItem(),
                    separatorBuilder: (context,index)=> SizedBox(
                      width: 15,
                    ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 12,
              ),
              ListView.separated(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                  itemBuilder:(context,index)=> buildChatItem(),
                  separatorBuilder:(context,index)=>SizedBox(
                    height: 10,
                  ),
                  itemCount: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() =>  Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
            ),
            SizedBox(height: 7,),
            CircleAvatar(
              radius: 8,
              backgroundColor:  Colors.white,
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        SizedBox(height: 7,),
        Text(
          'Saber is Strong man ,he will ',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
  Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          ),
          SizedBox(height: 7,),
          CircleAvatar(
            radius: 8,
            backgroundColor:  Colors.white,
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saber is Strong man',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 4,),
              Row(
                children: [
                  Expanded(
                    child: Text('شوف اللي حصل يا واد',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 7,
                      width: 5,
                      decoration: BoxDecoration(
                        color:Colors.black,
                        shape:BoxShape.circle,
                      ),
                    ),
                  ),
                  Text('03:00 pm',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );

}
