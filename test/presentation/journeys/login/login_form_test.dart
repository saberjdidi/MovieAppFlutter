
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
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

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class MockRoute<T> extends Mock implements Route<T> {}

main(){
  late Widget app;
  LanguageCubitMock _languageCubitMock = LanguageCubitMock();
  LoginCubitMock _loginCubitMock = LoginCubitMock();
  LoadingCubitMock _loadingCubitMock = LoadingCubitMock();
  NavigatorObserverMock _observer = NavigatorObserverMock();
  final mockRoute = MockRoute(); // Mock Route instance

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
          home: Scaffold(
            body: LoginForm(),
          ),
          navigatorObservers: [_observer],
        )
    );
  });

  tearDown(() {
    _languageCubitMock.close();
    _loginCubitMock.close();
    _loadingCubitMock.close();
  });

  testWidgets('should show error message when sign in API call with username, password is made',
          (WidgetTester tester) async {
      when(_loginCubitMock.state).thenAnswer((_) => LoginError(TranslationConstants.sessionDenied));

        await tester.pumpWidget(app);
        await tester.pump();

        final Finder usernameField = find.byKey(const ValueKey('username_text_field_key'));
        final Finder passwordField = find.byKey(const ValueKey('password_text_field_key'));
        final Finder signInButton = find.byType(TextButton);

        expect(usernameField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(signInButton, findsOneWidget);

        await tester.enterText(usernameField, 'username');
        await tester.enterText(passwordField, 'password');
        await tester.pump();

        await tester.tap(signInButton);
        await tester.pump();
        
        expect(find.text('Session denied'), findsOneWidget);

        verify(_loginCubitMock.initiateLogin('username', 'password')).called(1);
      });

  testWidgets('should show success message when sign in API call with username, password is made',
          (WidgetTester tester) async {
      when(_loginCubitMock.state).thenAnswer((_) => LoginSuccess());

        await tester.pumpWidget(app);
        await tester.pump();

        final Finder usernameField = find.byKey(const ValueKey('username_text_field_key'));
        final Finder passwordField = find.byKey(const ValueKey('password_text_field_key'));
        final Finder signInButton = find.byType(TextButton);

        expect(usernameField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(signInButton, findsOneWidget);

        await tester.enterText(usernameField, 'username');
        await tester.enterText(passwordField, 'password');
        await tester.pump();

        await tester.tap(signInButton);
        await tester.pump();

        expect(find.text('Session denied'), findsNothing);

        verify(_observer.didPush(mockRoute, any));

        verify(_loginCubitMock.initiateLogin('username', 'password')).called(1);
      });
}