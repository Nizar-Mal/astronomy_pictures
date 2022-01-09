class AstronomyPicture {
  String? _copyright;
  String? _date;
  String? _explanation;
  String? _hdurl;
  String? _mediaType;
  String? _serviceVersion;
  String? _title;
  String? _url;

  String? get copyright => _copyright;

  String? get date => _date;

  String? get explanation => _explanation;

  String? get hdurl => _hdurl;

  String? get mediaType => _mediaType;

  String? get serviceVersion => _serviceVersion;

  String? get title => _title;

  String? get url => _url;

  AstronomyPicture.fromJson(Map<String, dynamic> json) {
    _copyright = json['copyright'];
    _date = json['date'];
    _explanation = json['explanation'];
    _hdurl = json['hdurl'];
    _mediaType = json['media_type'];
    _serviceVersion = json['service_version'];
    _title = json['title'];
    _url = json['url'];
  }

}