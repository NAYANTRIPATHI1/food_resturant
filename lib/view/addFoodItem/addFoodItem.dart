import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturants/constants/constant.dart';
import 'package:ubereatsresturants/controller/provider/AddFoodProvider/FoodProvider.dart';
import 'package:ubereatsresturants/controller/services/foodDataCRUDServices/foodDataCRUDServices.dart';
import 'package:ubereatsresturants/model/addFoodmodel/addFoodModel.dart';
import 'package:ubereatsresturants/utils/colors.dart';
import 'package:ubereatsresturants/utils/textStyles.dart';
import 'package:ubereatsresturants/widgets/commonElevatedButton.dart';
import 'package:ubereatsresturants/widgets/textfieldWidget.dart';

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  bool foodIsPureVegetarian = true;
  bool pressedAddFoodItemButton = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: black,
              ))),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Consumer<FoodProvider>(builder: (context, FoodProvider, child) {
            return InkWell(
              onTap: () async {
                await FoodProvider.pickFoodImageFromGallery(context);
              },
              child: Container(
                  height: 20.h,
                  width: 9.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: greyShade3,
                  ),
                  child: Builder(builder: (context) {
                    if (FoodProvider.foodImage != null) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Image(
                          image: FileImage(FoodProvider.foodImage!),
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 5.h,
                            width: 5.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: black,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              size: 3.h,
                              color: black,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Add',
                            style: AppTextStyles.body14,
                          )
                        ],
                      );
                    }
                  })),
            );
          }),
          SizedBox(
            height: 4.h,
          ),
          CommonTextfield(
            controller: foodNameController,
            title: 'Name',
            hintText: 'Food Name',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
              controller: foodDescriptionController,
              title: 'Description',
              hintText: 'Food Description',
              keyboardType: TextInputType.name),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
              controller: foodPriceController,
              title: 'Price',
              hintText: 'Food Price',
              keyboardType: TextInputType.number),
          SizedBox(
            height: 2.h,
          ),
          Text('Food is Vegeterian', style: AppTextStyles.body16Bold),
          SizedBox(
            height: 0.8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    foodIsPureVegetarian = true;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 3.h,
                      alignment: Alignment.center,
                      width: 3.h,
                      decoration: BoxDecoration(
                        color: foodIsPureVegetarian
                            ? const Color.fromARGB(255, 89, 232, 93)
                            : transparent,
                        borderRadius: BorderRadius.circular(
                          5.sp,
                        ),
                        border: Border.all(
                          color: foodIsPureVegetarian ? black : grey,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        size: 2.h,
                        color: foodIsPureVegetarian ? black : transparent,
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      'Vegeterian',
                      style: AppTextStyles.body14,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    foodIsPureVegetarian = false;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 3.h,
                      alignment: Alignment.center,
                      width: 3.h,
                      decoration: BoxDecoration(
                        color: !foodIsPureVegetarian
                            ? Color.fromARGB(255, 232, 74, 74)
                            : transparent,
                        borderRadius: BorderRadius.circular(
                          5.sp,
                        ),
                        border: Border.all(
                          color: !foodIsPureVegetarian ? black : grey,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        size: 2.h,
                        color: !foodIsPureVegetarian ? black : transparent,
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      'Non-Vegeterian',
                      style: AppTextStyles.body14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          CommonElevatedButton(
            onPressed: () async {
              setState(() {
                pressedAddFoodItemButton = true;
              });
              await context
                  .read<FoodProvider>()
                  .uploadImageAndGetImageURl(context);
              String foodID = uuid.v1().toString();
              FoodModel data = FoodModel(
                name: foodNameController.text.trim(),
                foodID: foodID,
                uploadTime: DateTime.now(),
                resturantUID: auth.currentUser!.uid,
                description: foodDescriptionController.text.trim(),
                foodImageURL: context.read<FoodProvider>().foodImageURL!,
                isVegetrain: foodIsPureVegetarian,
                price: foodPriceController.text.trim(),
              );
              await FoodDataCRUDServices.uploadFoodData(context, data);
              await context.read<FoodProvider>().getFoodData();
            },
            child: pressedAddFoodItemButton
                ? CircularProgressIndicator(
                    color: white,
                  )
                : Text(
                    'Add Food',
                    style: AppTextStyles.body16Bold.copyWith(color: white),
                  ),
          )
        ],
      ),
    ));
  }
}
