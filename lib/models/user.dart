class User{
  String user_id, first_name, last_name, email, phone_number, address, avatar;

  User(this.user_id, this.first_name, this.last_name, this.email, this.phone_number, this.address, this.avatar);

  User.fromJson( Map<String,dynamic> jsonObject ){
    this.user_id = jsonObject['user_id'].toString();
    this.first_name = jsonObject['first_name'].toString();
    this.last_name = jsonObject['last_name'].toString();
    this.email = jsonObject['email'].toString();
    this.address = jsonObject['address'].toString();
    this.avatar = jsonObject['avatar'].toString();
  }

  String getUserFormattedName(){
    return '${this.first_name} ${this.last_name}';
  }
}
