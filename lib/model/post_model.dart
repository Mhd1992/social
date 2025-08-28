import 'package:social_application/model/post_like_model.dart';

class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  String? postId;
  bool? liked = false;

  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.dateTime,
      this.postImage,
      this.text,
      this.postId,
      this.liked});

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    uId = json?['uId'];
    image = json?['image'];
    dateTime = json?['dateTime'];
    postImage = json?['postImage'];
    text = json?['text'];
    postId = json?['postId'];
    liked = json?['liked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
      'postId': postId,
      'liked': liked
    };
  }

  PostModel copyWith({
    String? name,
    String? uId,
    String? image,
    String? dateTime,
    String? postImage,
    String? text,
    String? postId,
    bool? liked,
  }) {
    return PostModel(
      name: name ?? this.name,
      uId: uId ?? this.uId,
      image: image ?? this.image,
      dateTime: dateTime ?? this.dateTime,
      postImage: postImage ?? this.postImage,
      text: text ?? this.text,
      postId: postId ?? this.postId,
      liked: liked ?? this.liked,
    );
  }
}
