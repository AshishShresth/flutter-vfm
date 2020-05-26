class Category{
  String id;
  String title;

  Category(this.id, this.title);

  //named constructor
  Category.fromJson(Map<String , dynamic> jsonObject ){
    this.id = jsonObject['category_id'].toString();
    this.title = jsonObject['category_title'].toString();
  }


}