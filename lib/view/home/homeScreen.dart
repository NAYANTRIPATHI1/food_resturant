import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturants/utils/colors.dart';
import 'package:ubereatsresturants/utils/textStyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categories = [
    ['assets/images/categories/dessert.png', 'Dessert'],
    ['assets/images/categories/flower.png', 'Flower'],
    ['assets/images/categories/icecream.png', 'IceCream'],
    ['assets/images/categories/fastFood.png', 'Fast Food'],
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Current Location',
            style: AppTextStyles.body16Bold,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    color: greyShade3,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Indian',
                        style: AppTextStyles.small12Bold,
                      ),
                      const Image(
                          image:
                              AssetImage('assets/images/categories/indian.png'))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    color: greyShade3,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Healthy',
                        style: AppTextStyles.small12Bold,
                      ),
                      const Image(
                          image:
                              AssetImage('assets/images/categories/Banana.png'))
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories
                  .map((e) => Column(
                        children: [
                          Container(
                            height: 22.w,
                            width: 22.w,
                            decoration: BoxDecoration(
                              color: greyShade3,
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Image(image: AssetImage(e[0])),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            e[1],
                            style: AppTextStyles.small12Bold,
                          )
                        ],
                      ))
                  .toList()),
          SizedBox(
            height: 2.h,
          ),
          Divider(
            thickness: 1.h,
            color: greyShade3,
          ),
          SizedBox(
            height: 2.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: 18.h,
                  width: 94.w,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      color: greyShade3),
                );
              })
        ],
      )),
    );
  }
}
