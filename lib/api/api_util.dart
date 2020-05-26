class ApiUtil{

  //it is static because there is no need to create a instance, and it is a const because we don't want to change them
  static const String MAIN_API_URL = 'http://10.0.2.2:8000/api';

  static const String ALL_CATEGORIES = '/categories';

  static const String RECENT_POSTS = '/posts';

  static String categoryPosts(String categoryID){
    return MAIN_API_URL + ALL_CATEGORIES + '/' + categoryID + '/posts';
  }
}