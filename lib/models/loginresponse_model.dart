
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>LoginResponseModel.fromJson(json.decode(str));
// .map((x)=>ProfileRes.fromJson(x)));

    // String LoginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
final String id;
final String token;


LoginResponseModel({
required this.id,
required this.token,


});

factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
id: json["_id"],
token: json["token"],



);

Map<String, dynamic> toJson() => {
"_id": id,
"token": token,


};
}

