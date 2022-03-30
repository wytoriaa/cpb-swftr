// the User class refers to the application's user, 
// this is where we will have information such as its 
//name and which key it belongs to in Firebase
class UserInfo{
  final String name;
  final String? key;

  UserInfo({
    required this.name, this.key
  });

  static UserInfo fromMap(Map<String, dynamic> map){
    return UserInfo(name: map ["name"], key: map["key"]);
  }

  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "key": key
    };
  }
}