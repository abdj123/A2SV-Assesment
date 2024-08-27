import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:groceries_app/features/presentation/bloc/product_bloc.dart';
import 'package:groceries_app/features/presentation/pages/detail_page.dart';
import 'package:groceries_app/features/presentation/pages/home_page.dart';
import 'package:groceries_app/features/presentation/pages/splash_screen.dart';
import 'package:groceries_app/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ProductBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _generateRoute,
        initialRoute: "/",
        title: 'Groceries App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }

  Route? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/home_page":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/detail_page":
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (_) => DetailPage(product: product),
        );
      default:
        return null;
    }
  }
}
