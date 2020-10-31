class Attache {
  int attachId;
  int relatedId;
  String uploadName;
  String fileType;
  String fileName;
  String url;

  Attache(
      {this.attachId,
      this.relatedId,
      this.uploadName,
      this.fileType,
      this.fileName,
      this.url});

  Attache.fromJson(Map<String, dynamic> json) {
    attachId = json['attach_id'];
    relatedId = json['related_id'];
    uploadName = json['uploadName'];
    fileType = json['fileType'];
    fileName = json['fileName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attach_id'] = this.attachId;
    data['related_id'] = this.relatedId;
    data['uploadName'] = this.uploadName;
    data['fileType'] = this.fileType;
    data['fileName'] = this.fileName;
    data['url'] = this.url;
    return data;
  }
}
