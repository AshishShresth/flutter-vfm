import 'package:flutter/material.dart';
import 'package:vfm/models/category.dart';
import 'package:vfm/models/post_bid.dart';
import 'package:vfm/models/post_image.dart';
import 'package:vfm/models/user.dart';

class Post{
  String post_id, product_name, product_quantity, price, location, district, product_description;
  String created_at, updated_at, date_of_product_harvest;
  List<PostImage> images;
  Category category;
  User user;
  List<PostBid> bids;

  Post(this.post_id, this.product_name, this.product_quantity, this.price,
      this.location, this.district, this.product_description, this.created_at,
      this.updated_at, this.date_of_product_harvest, this.images, this.category,
      this.user, this.bids);

  Post.fromjson( Map<String,dynamic> jsonObject ){
    this.post_id = jsonObject['post_id'].toString();
    this.product_name = jsonObject['product_name'];
    this.product_quantity = jsonObject['product_quantity'].toString();
    this.price = jsonObject['price'].toString();
    this.location = jsonObject['location'].toString();
    this.district = jsonObject['district'].toString();
    this.product_description = jsonObject['product_description'].toString();
    this.created_at = jsonObject['created_at'].toString();
    this.updated_at = jsonObject['updated_at'].toString();
    this.date_of_product_harvest = jsonObject['date_of_product_harvest'].toString();

    this.images = [];
    for (var item in jsonObject['images']){
      images.add(PostImage.fromJson(item));
    }

    this.category = Category.fromJson(jsonObject['category']);
    this.user = User.fromJson(jsonObject['user']);

    this.bids = [];
    for (var item in jsonObject['bids']){
      bids.add(PostBid.fromJson(item));
    }

  }

  String getFeaturedImage(){
    if(this.images.length >0 ){
      return this.images[0].image_url;
    }
    return null;
  }

  String getUserFormatedName(){
    return this.user.getUserFormattedName();
  }

  ImageProvider getPostImage(){
    if(this.getFeaturedImage() == null){
      return ExactAssetImage('assets/images/placeholder.png');
    }
    return NetworkImage(this.getFeaturedImage());
  }
}
