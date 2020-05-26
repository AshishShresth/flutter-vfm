import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vfm/screens/login.dart';
import 'api/categories_api.dart';
import 'models/category.dart';
import 'screens/category_posts.dart';
import 'screens/home_screen.dart';
import 'screens/categories_list.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  CheckAuth(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,

      ),
      routes: {
        //'/' : (BuildContext context) => HomeScreen(),
        '/categories' : (BuildContext context) => CategoriesList(),
      },
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() { 
    _checkIfLoggedIn();
    super.initState();
    
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth){
      child = HomeScreen();
    }else{
      child = Login();
    }
    return Scaffold(
      body: child,
    );
  }

  
}

/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CategoriesApi categoriesApi = CategoriesApi(); //creating an instance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VFM'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: FutureBuilder(
          future: categoriesApi.fetchAllCategories(),
          builder: (BuildContext context , AsyncSnapshot<List<Category>> snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.none:
                return _error('No connection has been made');
                break;
              case ConnectionState.waiting:
                return _loading();
                break;
              case ConnectionState.active:
                return _loading();
                break;
              case ConnectionState.done:
                if(snapshot.hasError){
                  return _error(snapshot.error.toString());
                }
                if(snapshot.hasData){
                  return _drawCategoriesList(snapshot.data);
                }
                break;
            }
            return Container(
              child: Center(
                child: Text('No categories available', style: TextStyle(color: Colors.red),),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _drawCategoriesList(List<Category> categories){
    return ListView.builder(
      itemCount: categories.length, //we need a itemcount because the builder need to known ahead how many time it need to draw an item
      itemBuilder: (BuildContext context , int position){ //we have the position because we are iterating through  a list
        return InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categories[position].title),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute( builder: (context) => CategoryPosts(categories[position].id) ));
          },
        );
      },
    );
  }

  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _error(String error){
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
*/



