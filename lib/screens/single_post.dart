import 'package:flutter/material.dart';
import 'package:vfm/models/post.dart';

class SinglePostScreen extends StatefulWidget {

  final Post post;
  SinglePostScreen(this.post);

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: widget.post.getPostImage(),
                    image: NetworkImage('https://picsum.photos/id/106/2592/1728.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, position){
              if(position == 0 ){
                return _drawPostDetails();
              }
              else if (position >= 1 && position < 24 ){
                return _bids();
              }
            },
              childCount: 25,
            ), 
          ),
        ],
      ),
    );
  }

  Widget _drawPostDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.post.product_description,
        style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
      ),
    );
  }

  Widget _bids() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text('asdasdasdasdasdasdasdasdasd')
        ],
      ),
    );
  }
}


