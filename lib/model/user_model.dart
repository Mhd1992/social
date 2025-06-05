class UserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  bool? isEmailVerified;

  UserModel(this.name, this.phone, this.email, this.uId, this.image,
      this.isEmailVerified);

  //UserModel.fromJson(this.name, this.phone, this.email, this.uId);
  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    phone = json?['phone'];
    email = json?['email'];
    uId = json?['uId'];
    image = json?['image'];
    isEmailVerified = json?['isEmailVerifiedId'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'isEmailVerifiedId': isEmailVerified,
    };
  }
}
