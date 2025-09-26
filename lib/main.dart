import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/socket_service.dart';
import 'package:flutter_chat/core/theme.dart';
import 'package:flutter_chat/di_container.dart';
import 'package:flutter_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_chat/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_chat/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_chat/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:flutter_chat/features/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:flutter_chat/features/conversation/presentation/pages/conversation_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();

  setupDependencies();

  final storage = FlutterSecureStorage();
  String token = await storage.read(key: 'token') ?? '';

  runApp(MainApp(isLoggedIn: token.isEmpty ? false : true));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(registerUseCase: sl(), loginUseCase: sl()),
        ),
        BlocProvider(
          create: (_) => ConversationBloc(fetchConversationUseCase: sl()),
        ),
        BlocProvider(create: (_) => ChatBloc(fetchMessageUseCase: sl())),
        BlocProvider(
          create: (_) => ContactsBloc(
            fetchContactsUseCase: sl(),
            addContactsUseCase: sl(),
            checkOrCreateConversationUseCase: sl(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? ConversationPage() : LoginPage(),
        routes: {
          '/login': (context) => BlocProvider.value(
            value: BlocProvider.of<AuthBloc>(context),
            child: LoginPage(),
          ),
          '/register': (context) => BlocProvider.value(
            value: BlocProvider.of<AuthBloc>(context),
            child: RegisterPage(),
          ),
          '/conversation': (context) => ConversationPage(),
        },
      ),
    );
  }
}
