class CategoriesModel {
  bool? status;
  Null? message;
  CategoriesDataModel? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data;
  String? firstPageUrl;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
