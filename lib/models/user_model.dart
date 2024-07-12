class UserModel {
  final String userName;
  final String userEmail;
  final String? uid;

  UserModel({required this.userName, required this.userEmail,this.uid});
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'uid': uid,
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>data){
    return UserModel(
      userName:data['userName'],
      userEmail:data['userEmail'],
      uid:data['uid'],
    );
  }
}
