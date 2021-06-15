// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:sama/BloC/Login/LoginEvent.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/BloC/Pagination/PaginationBloc.dart';
import 'package:sama/BloC/Pagination/PaginationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:sama/BloC/Login/LoginState.dart';
import 'package:sama/Repository/LoginRepository.dart';
import 'package:sama/Repository/MessageRepository.dart';
import 'package:sama/Repository/UserRepository.dart';
import 'package:sama/SamaBase/Network/ApiProvider.dart';
import 'package:sama/SamaBase/SamaExtension/SColor.dart';
import 'package:sama/UI/AboutUs/AboutUs.dart';
import 'package:sama/UI/Login/LoginPage.dart';
import 'package:sama/UI/Message/MessagePage.dart';
import 'package:sama/UI/Profile/ProfilePage.dart';
import 'package:sama/UI/Splash/SplashPage.dart';
import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/Utilities/MPref.dart';
import 'package:sama/Utilities/MSnackBar.dart';
import 'BloC/Pagination/PaginationEvent.dart';
import 'BloC/User/UserBloc.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.scheduleTask(TaskConfig(
      taskId: "task1",
      delay: 50000,
      periodic: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true));

  await MPref.getInstance();
  if (MPref.getString("AccessToken") != "") {
    var m = MeeageRepository(apiProvider: ApiProvider());
    try {
      var numNewItem = await m.getNumberOfNewMessage();
      if (numNewItem != 0) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'پیام جدید',
                body: 'شما $numNewItem پیام جدید دارید.'));
      }
    } catch (_) {}
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await MPref.getInstance();
  // await AndroidAlarmManager.initialize();
  runApp(MApp());
  AwesomeNotifications().initialize('resource://drawable/app_icon', [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.red),
    NotificationChannel(
        channelKey: 'open_file_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.red)
  ]);
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MApp extends StatefulWidget {
  MyApp createState() => MyApp();
}

class MyApp extends State<MApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
                startOnBoot: true,
                minimumFetchInterval: 1,
                forceAlarmManager: true,
                stopOnTerminate: false,
                enableHeadless: true,
                requiresBatteryNotLow: false,
                requiresCharging: false,
                requiresStorageNotLow: false,
                requiresDeviceIdle: false,
                requiredNetworkType: NetworkType.NONE),
            _onBackgroundFetch)
        .then((int status) {
      print('status');
    }).catchError((e) {
      print('ERROR');
    });

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "task1",
        delay: 1,
        periodic: true,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true));
  }

  void _onBackgroundFetch(String taskId) async {
    switch (taskId) {
      case "task1":
        await MPref.getInstance();
        BackgroundFetch.scheduleTask(TaskConfig(
            taskId: "task1",
            delay: 50000,
            periodic: false,
            forceAlarmManager: true,
            stopOnTerminate: false,
            enableHeadless: true));
        if (MPref.getString("AccessToken") != "") {
          var m = MeeageRepository(apiProvider: ApiProvider());
          try {
            var numNewItem = await m.getNumberOfNewMessage();
            if (numNewItem != 0) {
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: 10,
                      channelKey: 'basic_channel',
                      title: 'پیام جدید',
                      body: 'شما $numNewItem پیام جدید دارید.'));
            }
          } catch (_) {}
        }

        break;
    }

    BackgroundFetch.finish(taskId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context1) {
    // await AndroidAlarmManager.initialize();
    return MaterialApp(
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fa'), // farsi
        ],
        title: 'Flutter Demo1',
        theme: ThemeData(
            fontFamily: 'IranSans',
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: SColor.getMaterialColorFromHex(0xFF00ACC1)),
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBLoc>(
              create: (BuildContext context) => LoginBLoc(
                  loginRepository: LoginRepository(apiProvider: ApiProvider())),
            ),
            BlocProvider<PaginationBloc>(
              create: (BuildContext context) => PaginationBloc(),
            ),
            BlocProvider<MessageBloc>(
                create: (BuildContext context) => MessageBloc(
                    messageRepository:
                        MeeageRepository(apiProvider: ApiProvider()))),
            BlocProvider<UserBloc>(
                create: (BuildContext context) => UserBloc(
                    userRepository: UserRepository(apiProvider: ApiProvider())))
          ],
          child: Scaffold(
              body: BlocListener<LoginBLoc, LoginState>(
            listener: (context, state) {
              if (state is LoginStateInit) {
                BlocProvider.of<LoginBLoc>(context).add(LoginEventInit());
              } else if (state is LoginStateFailure) {
                MSnackBar.ErrorWithText(context, state.error);
              }
              // else if (state is LoginStateSuccess) {
              //   MSnackBar.SuccessWithText(context, "خوش آمدید");
              // }
            },
            child:
                BlocBuilder<LoginBLoc, LoginState>(builder: (context, state) {
              if (state is LoginStatePreInit) {
                BlocProvider.of<LoginBLoc>(context).add(LoginEventPreInit());
              }
              if (state is LoginStateSuccess) {
                // return MessagePage();
                return BlocListener<PaginationBloc, PaginationState>(
                  listener: (context, state1) {},
                  child: BlocBuilder<PaginationBloc, PaginationState>(
                      builder: (context, state2) {
                    dd(context, context1);
                    return ShowPage(state2);
                  }),
                );
              } else if (state is LoginStatePreInit) {
                return SplashPage();
              } else if (state is LoginStateFailure) {
                return LoginPage();
              } else {
                return LoginPage();
              }
            }),
          )),
        ));
  }

  void dd(BuildContext c, BuildContext c2) {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      // Navigator.of(c2).pop();
      if (receivedNotification.channelKey == "open_file_channel") {
        OpenFile.open(receivedNotification.payload['uri']);
      } else {
        BlocProvider.of<PaginationBloc>(c).add(PaginationEventMessage());
      }

      // print("mohammad");
    });
  }

  // ignore: non_constant_identifier_names
  Widget ShowPage(PaginationState state) {
    //if (Navigator.of(context) != null) Navigator.of(context).pop();
    if (state is PaginationStateMessage) {
      return MessagePage();
      // return SplashPage();
    } else if (state is PaginationStateProfile) {
      return ProfilePage();
    } else if (state is PaginationStateAboutUs) {
      return AboutUs();
    } else if (state is SplashStateMessage) {
      return SplashPage();
    }
    return MessagePage();
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
