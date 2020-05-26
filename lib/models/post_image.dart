
class PostImage{
  String image_id, image_url, post_id;

  PostImage(this.image_id, this.image_url, this.post_id);

  PostImage.fromJson( Map<String,dynamic> jsonObject){
    this.image_id = jsonObject['image_id'].toString();
    this.image_url = jsonObject['image_url'].toString();
    this.post_id = jsonObject['post_id'].toString();
  }
}
