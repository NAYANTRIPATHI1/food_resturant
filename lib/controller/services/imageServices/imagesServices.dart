// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubereatsresturants/constants/constant.dart';
import 'package:ubereatsresturants/controller/services/toastServices/toastMessageService.dart';

class ImageServices {
  static getImagesFromGallery({required BuildContext context}) async {
    List<File> selectedImages = [];
    final PickedFile = await picker.pickMultiImage(imageQuality: 100);
    List<XFile> filePick = PickedFile;
    if (filePick.isNotEmpty) {
      for (var image in filePick) {
        selectedImages.add(File(image.path));
      }
    } else {
      ToastService.sendScaffoldAlert(
        msg: 'No Images Selected',
        toastStatus: 'WARNING',
        context: context,
      );
    }

    log('The Images are \n  ${selectedImages.toList().toString()}');
    return selectedImages;
  }

  static uploadImagesToFirebaseStorageGetURL(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesURL = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child('ResturantBannerImages').child(imageName);
      await ref.putFile(File(image.path));
      String imageURL = await ref.getDownloadURL();
      imagesURL.add(imageURL);
    });
    return imagesURL;
  }

  static pickSingleImage({required BuildContext context}) async {
    File? selectedImages;
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = PickedFile!;
    if (filePick != null) {
      selectedImages = File(filePick.path);
      return selectedImages;
    } else {
      ToastService.sendScaffoldAlert(
        msg: 'No Images Selected',
        toastStatus: 'WARNING',
        context: context,
      );
    }
  }
}
