import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ubereatsresturants/controller/services/imageServices/imagesServices.dart';
import 'package:ubereatsresturants/controller/services/resturantCRUDServices/resturantCrudServices.dart';
import 'package:ubereatsresturants/model/restaurantModel.dart';

class ResturantProvider extends ChangeNotifier {
  List<File> resturantBannerImages = [];
  List<String> resturantBannerImagesURL = [];
  RestaurantModel? resturantData;

  getResturatantBannerImages(BuildContext context) async {
    resturantBannerImages = await ImageServices.getImagesFromGallery(
      context: context,
    );
    notifyListeners();
  }

  updateResturantBannerImagesURL(BuildContext context) async {
    resturantBannerImagesURL =
        await ImageServices.uploadImagesToFirebaseStorageGetURL(
      images: resturantBannerImages,
      context: context,
    );
    notifyListeners();
  }

  getResturantData() async {
    resturantData = await ResturantCRUDServices.fetchResturantData();
    notifyListeners();
  }
}
