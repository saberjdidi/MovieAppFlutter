
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/presentation/app_localizations.dart';
import 'package:movieapp/presentation/blocs/language/language_cubit.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';
import 'package:movieapp/presentation/blocs/login/login_cubit.dart';
import 'package:movieapp/presentation/journeys/login/login_form.dart';
import 'package:movieapp/presentation/journeys/login/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

class LanguageCubitMock extends Mock implements LanguageCubit {}

class LoginCubitMock extends Mock implements LoginCubit {}

class LoadingCubitMock extends Mock implements LoadingCubit {}

main(){
 late Widget app;
  LanguageCubitMock _languageCubitMock = LanguageCubitMock();
  LoginCubitMock _loginCubitMock = LoginCubitMock();
  LoadingCubitMock _loadingCubitMock = LoadingCubitMock();

  setUp((){
   // _languageCubitMock = LanguageCubitMock();
   // _loginCubitMock = LoginCubitMock();
   // _loadingCubitMock = LoadingCubitMock();

    app = MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>.value(value: _languageCubitMock),
          BlocProvider<LoginCubit>.value(value: _loginCubitMock),
          BlocProvider<LoadingCubit>.value(value: _loadingCubitMock),
        ],
        child: MaterialApp(
          supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
          locale: Locale(Languages.languages[0].code),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: LoginScreen(),
        )
    );
  });

  tearDown(() {
    _languageCubitMock.close();
    _loginCubitMock.close();
    _loadingCubitMock.close();
  });

  testWidgets('should show basic login screen UI login form and logo',
          (WidgetTester tester) async {
           await tester.pumpWidget(app);
           await tester.pumpAndSettle();

           expect(find.byType(Logo), findsOneWidget);
           expect(find.byType(LoginForm), findsOneWidget);
          });
}