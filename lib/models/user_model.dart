class UserModel{
  final String userName;
  final String userEmail;
  final String password;
  final String ?uid;

  UserModel(this.userName, this.userEmail, this.password, this.uid);
  Map<String,dynamic>toMap(){
    return {
      'userName':userName,
      'userEmail':userEmail,
      'password':password,
      'uid':uid,
    };
  }
  // factory UserModel.fromMap(Map<String,dynamic>data){
  //   return UserModel(
  //     userName:data['userName'],
  //     userEmail:data['userEmail'],
  //     password:data['password'],
  //     uid:data['uid'],
  //   );

  // }



}