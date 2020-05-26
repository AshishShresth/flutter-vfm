import 'package:flutter/material.dart';
import 'package:vfm/models/category.dart';
import 'package:vfm/api/categories_api.dart';

import 'category_posts.dart';

class CategoriesList extends StatefulWidget {

  
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoriesApi categoriesApi = CategoriesApi();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Categories'),
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
        return Card(
          color: Colors.blueAccent[100],
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute( builder: (context) => CategoryPosts(categories[position].id) ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categories[position].title, 
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black

                ),
              ),
            ),
          ),
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

