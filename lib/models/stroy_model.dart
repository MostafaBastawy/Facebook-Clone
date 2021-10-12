class StoryDataModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? storyImage;
  String? createAt;

  StoryDataModel(
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.storyImage,
    this.createAt,
  );

  StoryDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    storyImage = json['storyImage'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'storyImage': storyImage,
      'createAt': createAt,
    };
  }
}
