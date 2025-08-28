class PostLIkeModel {
  bool? like;
  String? postId;
  PostLIkeModel({
    this.postId,
    this.like,
  });
  PostLIkeModel.fromJson(Map<String, dynamic>? json) {
    postId = json?['postId'];
    like = json?['like'] ?? false;
  }
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'like': like,
    };
  }
}
