import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:innersight/screens/video_call.dart';
import 'package:innersight/widgets/all_doctors.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import './screens/get_started_screen.dart';
import './screens/tabs_screen.dart';
import './screens/video_call_screen.dart';
import './screens/select_time_screen.dart';
import './screens/popular_doctor_screen.dart';
import './screens/doctors_details_screen.dart';
import './screens/appointment_calender_screen.dart';
import './screens/auth_screen.dart';
import './screens/medical_records_screen.dart';
import './screens/add_record_screen.dart';
import './screens/all_records_screen.dart';
import './screens/medicine_orders_screen.dart';
import './screens/medicine_orders_search_screen.dart';
import './screens/help_center_screen.dart';
import './screens/diagonstics_tests_screen.dart';
import './screens/patient_details_screen.dart';
import './screens/privacy_policy_screen.dart';
import './screens/settings_screen.dart';
import './screens/profile_screen.dart';
import './screens/splash_screen.dart';

import '../provider/doctors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCoZ4Akinjt2M6sw_-KKlWiP0KYuKFbn10",
          appId: "1:92054237811:android:3b2fddf40626f73c99b006",
          messagingSenderId: "XXX",
          projectId: "innersight-6b3dd"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Doctors(),
        ),
      ],
      child: KhaltiScope(
        publicKey: "test_public_key_868c99738dfa4758916ac618368abc75",
        builder: (context, navigatorkey) {
          return MaterialApp(
            navigatorKey: navigatorkey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Inner Sight',
            theme: ThemeData(
              fontFamily: 'Rubik',
              primaryColor: const Color(0xff45b3cb),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xff1c9ab6),
                secondary: const Color(0xffF7B9A2),
              ),
            ),
            home: const SplashScreen(),
            routes: {
              TabsScreen.routeName: (ctx) => const TabsScreen(),
              VideoCallScreen.routeName: (ctx) => const VideoCallScreen(),
              SelectTimeScreen.routeName: (ctx) => const SelectTimeScreen(),
              PopularDoctorScreen.routeName: (ctx) =>
                  const PopularDoctorScreen(),
              DoctorsDetailsScreen.routeName: (ctx) =>
                  const DoctorsDetailsScreen(),
              AppointmentCalenderScreen.routeName: (ctx) =>
                  AppointmentCalenderScreen(),
              AuthScreen.routeName: (ctx) => const AuthScreen(),
              MedicalRecordsScreen.routeName: (ctx) =>
                  const MedicalRecordsScreen(),
              AddRecordScreen.routeName: (ctx) => AddRecordScreen(),
              AllRecordsScreen.routeName: (ctx) => const AllRecordsScreen(),
              MedicineOrdersScreen.routeName: (ctx) =>
                  const MedicineOrdersScreen(),
              MedicineOrdersSearchScreen.routeName: (ctx) =>
                  const MedicineOrdersSearchScreen(),
              HelpCenterScreen.routeName: (ctx) => const HelpCenterScreen(),
              DiagonsticsTestsScreen.routeName: (ctx) =>
                  const DiagonsticsTestsScreen(),
              PatientDetailsScreen.routeName: (ctx) =>
                  const PatientDetailsScreen(),
              PrivacyPolicyScreen.routeName: (ctx) =>
                  const PrivacyPolicyScreen(),
              SettingsScreen.routeName: (ctx) => const SettingsScreen(),
              ProfileScreen.routeName: (ctx) => const ProfileScreen(),
              GetStartedScreen.routeName: (ctx) => const GetStartedScreen(),
              Meeting.routeName:(ctx)=> const Meeting(),
              AllDoctor.routeName:(ctx)=> const AllDoctor()
              // ChatScreen.routeName: (ctx) => const ChatScreen(),
            },
          );
        },
      ),
    );
  }
}
