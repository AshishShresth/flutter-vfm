import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vfm/api/authorization_api.dart';
import 'package:vfm/api/posts_api.dart';
import 'package:vfm/models/post.dart';
import 'package:vfm/screens/login.dart';
import 'package:vfm/shared_ui/list_posts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  String email;

  @override
  void initState() { 
    _loadUserData();
    super.initState();
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user !=null){
      setState(() {
        name = user['first_name'] +' '+ user['last_name'];
        email = user['email'];
      });
    }
  }

  List<Post> postsWithImages = [];

  PostsApi postsApi = PostsApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Center(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Hi, $name', style: TextStyle(color: Colors.white),), 
                accountEmail: Text('$email', style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: 
                    Theme.of(context).platform == TargetPlatform.android
                      ? Colors.white
                      : Colors.indigoAccent,
                  child: Icon(
                    Icons.face
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).platform == TargetPlatform.android
                    ? Colors.indigoAccent
                    : Colors.white
                ),
              ),
              // DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.teal,
              //   ),
              //   child: Text('Header'),
              // ),
              ListTile(
                leading: Icon(
                  Icons.category
                ),
                title: Text('Categories'), 
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/categories');
                },
              ),
              Center(
                child: RaisedButton(
                      elevation: 10,
                      onPressed: (){
                        logout();
                      },
                      color: Colors.indigoAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('Logout', style: TextStyle(color: Colors.white),),
                    ),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: postsApi.fetchRecentPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return _error('No connection has been made yet!');
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.done:
              if(snapshot.hasError){
                return _error(snapshot.error);
              }
              if(!snapshot.hasData){
                return _error('No data fetched yet!');
              }
              return _drawHomeScreen(snapshot.data);
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _error(String error){
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),)
      ),
    );
  }

  Widget _loading (){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawHomeScreen(List<Post> posts) {
    
    for(Post post in posts){
      if(post.images.length > 0){
        postsWithImages.add(post);
      }
    }
    //print(postsWithImages.length);
    return Column(
      children: <Widget>[
        _slider(postsWithImages),
        _postList(posts),
      ],
    );
  }

  Widget _slider( List<Post> posts){
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position){
          //String postImage = posts[position].images[0].image_url;
          return InkWell(
            onTap: (){
              //TODO: Go to the single screen post
            },
            child: Stack(
              children: <Widget>[
                Center(
                  child: Card(
                    color: Colors.blue[100],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          isThreeLine: true,
                          //leading: Image.network('https://picsum.photos/id/106/2592/1728.jpg'),
                          leading: Image.network(posts[position].images[0].image_url),
                          title: Text('Product Name:' + ' ' +  posts[position].product_name),
                          subtitle:  Text('Price:' + posts[position].price),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _postList(List<Post> posts) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position){
            return PostCard(posts[position]);
          },
        ),
      ),
    );
  }

  void logout() async{
    var res = await AuthApi().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>Login())
      );
    }
  }
}


