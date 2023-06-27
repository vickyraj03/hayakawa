class VideoModel {
  String? result;
  VideoData? data;

  VideoModel({this.result, this.data});

  VideoModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ?  VideoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VideoData {
  String? videoUrl;

  VideoData({this.videoUrl});

  VideoData.fromJson(Map<String, dynamic> json) {
    videoUrl = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_url'] = this.videoUrl;
    return data;
  }
}
