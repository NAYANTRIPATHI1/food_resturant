import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturants/controller/provider/AddFoodProvider/FoodProvider.dart';
import 'package:ubereatsresturants/controller/provider/authProvider/authProvider.dart';
import 'package:ubereatsresturants/controller/provider/resturantRegisterProvider/resturantRegisterProvider.dart';
import 'package:ubereatsresturants/firebase_options.dart';
import 'package:ubereatsresturants/view/signInLogicScreen/signInLogicScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UberEats());
}

class UberEats extends StatelessWidget {
  const UberEats({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MobileAuthProvider>(
            create: (_) => MobileAuthProvider(),
          ),
          ChangeNotifierProvider<ResturantProvider>(
            create: (_) => ResturantProvider(),
          ),
          ChangeNotifierProvider<FoodProvider>(
            create: (_) => FoodProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: const SignInLogicScreen()),
      );
    });
  }
}
