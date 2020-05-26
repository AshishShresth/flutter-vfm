import 'package:vfm/models/user.dart';

class PostBid{

 String bids_id, bidding_quantity, bidding_price, message, post_id;
 String created_at, updated_at;
 User bidder;

 PostBid(this.bids_id, this.bidding_quantity, this.bidding_price, this.message, this.bidder, this.post_id, this.created_at, this.updated_at);

 PostBid.fromJson( Map<String,dynamic> jsonObject){
  this.bids_id = jsonObject['bids_id'].toString();
  this.bidding_quantity= jsonObject['bidding_quantity'].toString();
  this.message = jsonObject['message'].toString();
  this.post_id = jsonObject['post_id'].toString();
  this.created_at = jsonObject['created_at'].toString();
  this.updated_at =  jsonObject['updated_at'].toString();
  this.bidder = User.fromJson(jsonObject['bidder']);
 }

}
