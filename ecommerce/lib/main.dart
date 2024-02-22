import 'package:ecommerce/bindings/general_bindings.dart';
import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';



Future<void> main() async{
  //widget binging
  final WidgetsBinding widgetsBinding= WidgetsFlutterBinding.ensureInitialized();
  //getx local storge
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding:GeneralBindings() ,
      ///show loader or circular progress Indicator meanwhile Authentication repository is deciding to show relevant screen
      home: const Scaffold(backgroundColor: TColors.primary,body: CircularProgressIndicator(color: TColors.white,),),
    );
  }
}

