class CategorySearchModel {
  bool? status;
  String? message;
  List<CategorySearch>? data;

  CategorySearchModel({this.status, this.message, this.data});

  CategorySearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategorySearch>[];
      json['data'].forEach((v) {
        data!.add(new CategorySearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategorySearch {
  String? kind;
  String? categoryImages;

  CategorySearch({this.kind, this.categoryImages});

  CategorySearch.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    categoryImages = json['category_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['category_images'] = this.categoryImages;
    return data;
  }
}
