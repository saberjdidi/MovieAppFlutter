# movieapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Clean Architecture
- Domain Layer : Request & Response Model, Method in abstract repository and UseCase
- Data Layer : Model, Repository Implementation and Datasource
- Presentation Layer : Bloc & UI
- Dependency Injection

## source : https://www.youtube.com/watch?v=K5ykdG4Yc5A&list=PL342JVRNQxEAcQdnNeN0JmMzfcm6VtLxS&index=4

## Responsability of a usecase
- Ideally, one usecase per feature
- Decide which repository to use
- Input parameters => output response
- Only called from BloCs

## Dartz : Left when error  |  Right when success

## Dependent & Dependency
- Code standard
- Moins de productivité
- Plus de consommation de mémoire

## Dependency Provider : use GetIt
+ Lazy Initialization
+ Moins de consommation de mémoire

Movie App Project
1. Create Clean Architecture application
2. Configuration https://www.themoviedb.org/?language=fr account and getting apikey
3. add Wiredash to application => console.wiredash.io : Wiredash est un outil interactif de feedback utilisateur pour les applications Flutter, incluant Promoter Score.

## Local DB Operation => Hive
1. Insert favorite movie in db
2. Retrieve list of favorite movies from db
3. Save User preferred language
4. Retrieve preferred language
add packages and add commande to add movie_table.g.dart in cmd> flutter packages pub run build_runner build

## https://flare.rive.app/ && https://rive.app/: icon & animation

## Authentication : username:saber / pwd:saber

## FLutter launch icon => flutter_launcher_icons
- cmd : flutter pub get
- cmd : flutter pub run flutter_launcher_icons

