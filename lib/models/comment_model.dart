class CommentDataModel {
  String? postUid;
  String? dateTime;
  String? createAt;
  String? commentText;
  String? userProfileImageUrl;
  String? userName;
  String? userUid;

  CommentDataModel(
    this.postUid,
    this.dateTime,
    this.createAt,
    this.commentText,
    this.userProfileImageUrl,
    this.userName,
    this.userUid,
  );

  CommentDataModel.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    dateTime = json['dateTime'];
    createAt = json['createAt'];
    commentText = json['commentText'];
    userProfileImageUrl = json['userProfileImageUrl'];
    userName = json['userName'];
    userUid = json['userUid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postUid': postUid,
      'dateTime': dateTime,
      'createAt': createAt,
      'commentText': commentText,
      'userProfileImageUrl': userProfileImageUrl,
      'userName': userName,
      'userUid': userUid,
    };
  }
}
