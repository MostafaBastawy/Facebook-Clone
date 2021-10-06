class PostDataModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostDataModel(
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  );

  PostDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
