import 'package:flutter_chat/features/auth/data/datascurce/auth_remote_data_source.dart';
import 'package:flutter_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_chat/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_chat/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_chat/features/chat/data/datascure/message_remote_data_source.dart';
import 'package:flutter_chat/features/chat/data/repositories/message_repository_impl.dart';
import 'package:flutter_chat/features/chat/domian/repositories/message_repository.dart';
import 'package:flutter_chat/features/chat/domian/usecases/fetch_message_use_case.dart';
import 'package:flutter_chat/features/contacts/data/datascure/contacts_remote_data_source.dart';
import 'package:flutter_chat/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:flutter_chat/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:flutter_chat/features/contacts/domain/usecases/add_contacts_use_case.dart';
import 'package:flutter_chat/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:flutter_chat/features/conversation/data/datascure/conversation_remote_data_source.dart';
import 'package:flutter_chat/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:flutter_chat/features/conversation/domain/repositories/conversation_repository.dart';
import 'package:flutter_chat/features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';
import 'package:flutter_chat/features/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  const String baseUrl = "http://localhost:3000";

  // 数据源
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(baseUrl: baseUrl),
  );
  sl.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSource(baseUrl: baseUrl),
  );
  sl.registerLazySingleton<MessageRemoteDataSource>(
    () => MessageRemoteDataSource(baseUrl: baseUrl),
  );
  sl.registerLazySingleton<ContactsRemoteDataSource>(
    () => ContactsRemoteDataSource(baseUrl: baseUrl),
  );

  // 存储库
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ConversationRepository>(
    () => ConversationRepositoryImpl(conversationRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(messageRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryImpl(contactsRemoteDataSource: sl()),
  );

  // 用例
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchConversationUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchMessageUseCase(messageRepository: sl()));
  sl.registerLazySingleton(
    () => FetchContactsUseCase(contactsRepository: sl()),
  );
  sl.registerLazySingleton(() => AddContactsUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(
    () => CheckOrCreateConversationUseCase(conversationRepository: sl()),
  );
}
