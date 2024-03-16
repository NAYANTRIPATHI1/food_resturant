import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturants/controller/provider/AddFoodProvider/FoodProvider.dart';
import 'package:ubereatsresturants/model/addFoodmodel/addFoodModel.dart';
import 'package:ubereatsresturants/utils/colors.dart';
import 'package:ubereatsresturants/utils/textStyles.dart';
import 'package:ubereatsresturants/view/addFoodItem/addFoodItem.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodProvider>().getFoodData();
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 164, 48, 185),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const AddFoodItemScreen(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: white,
            ),
          ),
          body: Consumer<FoodProvider>(builder: (context, FoodProvider, child) {
            if (FoodProvider.items.isEmpty) {
              return Center(
                child: Text(
                  'Add Food Items',
                  style: AppTextStyles.body14Bold.copyWith(color: grey),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: FoodProvider.items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    FoodModel foodData = FoodProvider.items[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.sp,
                        ),
                        border: Border.all(
                          color: black87,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.sp),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    foodData.foodImageURL,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            foodData.name,
                            style: AppTextStyles.body14Bold,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            foodData.description,
                            style: AppTextStyles.small12.copyWith(
                              color: grey,
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '₹${foodData.price}',
                                style: AppTextStyles.body16Bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          })),
    );
  }
}
