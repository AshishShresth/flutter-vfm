import 'package:flutter/material.dart';
import 'package:vfm/models/post.dart';
import 'package:vfm/screens/single_post.dart';

class PostCard extends StatelessWidget {

  final Post post;
  PostCard(this.post);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePostScreen(post)));
          },
          child: Row(
            children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Image(
                  image: post.getPostImage(),
                  //image: NetworkImage('https://picsum.photos/id/106/2592/1728.jpg'),
                  fit: BoxFit.cover,
                ),
            ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.product_name, 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          post.getUserFormatedName(), 
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(post.created_at, style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}