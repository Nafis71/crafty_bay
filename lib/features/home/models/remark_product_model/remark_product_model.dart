class RemarkProductModel {
  String? msg;
  List<RemarkProductModel>? data;

  RemarkProductModel({this.msg, this.data});

  RemarkProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <RemarkProductModel>[];
      json['data'].forEach((v) {
        data!.add(RemarkProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}