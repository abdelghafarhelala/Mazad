// class CategoriesModel{
//   bool ?status;
//   CategoriesDataModel ? message;
//   CategoriesModel.fromjson(Map<dynamic,dynamic>json){
//    status=json['status'];
//    message=CategoriesDataModel.fromjson(json['data']);

//  }
// }

// class CategoriesDataModel{
//   int ? currentPage ;
//   List<CategoryData> data=[];
//   CategoriesDataModel.fromjson(Map<dynamic,dynamic>json){
//    currentPage =json['current_page'];
//    json['data'].forEach((e){
//      data.add(CategoryData.fromjson(e));
//    });

//  }

// }

// class CategoryData{
//   int ? id;
//   String? name;
//   String ?image;

//  CategoryData.fromjson(Map<dynamic,dynamic>json){
//    id=json['id'];
//    name=json['name'];
//    image=json['image'];
//  }

// }

class CategoryModel {
  bool? status;
  List<Message>? message;
  String? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
    data = json['data'];
  }
}

class Message {
  int? id;
  String? kind;
  late String categoryImages;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.kind,
      required this.categoryImages,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kind = json['kind'];
    categoryImages = json['category_images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
