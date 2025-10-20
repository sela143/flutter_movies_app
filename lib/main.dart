import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/app.dart';
import 'package:movies_app/services/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.instan.init();

  await dotenv.load(fileName: ".env");

  final url = dotenv.env['URL'];
  final anonKey = dotenv.env['ANON_KEY'];

  await Supabase.initialize(
    url: url!,
    anonKey: anonKey!);
 
  runApp(const MyApp());
}