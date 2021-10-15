class PostDataModel {
  String? name;
  String? useruId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? createAt;


  PostDataModel(
    this.name,
    this.useruId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.createAt,

  );

  PostDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    useruId = json['useruId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    createAt = json['createAt'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'useruId': useruId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'createAt': createAt,

    };
  }
}
