import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:voting_yuk/api/api_service.dart';
import 'package:voting_yuk/pages/dashboard.dart';
import 'package:voting_yuk/pages/detail.dart';
import 'package:voting_yuk/pages/splash_screen.dart';
import 'package:voting_yuk/providers/candidates.dart';
import 'package:voting_yuk/providers/chart.dart';
import 'package:voting_yuk/providers/deail_candidate.dart';
import 'package:voting_yuk/providers/vote.dart';
import 'package:voting_yuk/utils/style.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CandidatesProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => VoteProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ChartProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailCandidateProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor primarySwatchColor = createMaterialColor(accentColor);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          theme: ThemeData(
            fontFamily: 'Inter-Regular',
            primarySwatch: primarySwatchColor,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            Dashboard.routeName: (context) => const Dashboard(),
            DetailPaslon.routeName: (context) => DetailPaslon(
                id: ModalRoute.of(context)?.settings.arguments as int),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  Map<int, Color> swatch = {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color,
  };

  return MaterialColor(color.value, swatch);
}
