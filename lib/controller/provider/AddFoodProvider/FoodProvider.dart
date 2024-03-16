import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ubereatsresturants/controller/services/foodDataCRUDServices/foodDataCRUDServices.dart';
import 'package:ubereatsresturants/controller/services/imageServices/imagesServices.dart';
import 'package:ubereatsresturants/model/addFoodmodel/addFoodModel.dart';

class FoodProvider extends ChangeNotifier {
  File? foodImage;
  String? foodImageURL;
  List<FoodModel> items = [];

  pickFoodImageFromGallery(BuildContext context) async {
    foodImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURl(BuildContext context) async {
    List<String> url = await ImageServices.uploadImagesToFirebaseStorageGetURL(
      images: [foodImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      foodImageURL = url[0];
      log(foodImageURL!);
    }
    notifyListeners();
  }

  getFoodData() async {
    items = await FoodDataCRUDServices.fetchFoodData();
    notifyListeners();
  }
}
