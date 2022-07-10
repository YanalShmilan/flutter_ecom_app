import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
    Stream<AppUser?> authStateChanges();
    Future<void> signInWithEmailAndPassword(String email, String password);
    Future<void> signOut();
    Future<void> createUserWithEmailAndPassword(String email, String password);
    void dispose();
}

class ApiAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
@override
  void dispose () {
}

}

class FakeAuthRepository implements AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
createUser(email);    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
createUser(email);  }
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

@override
  void dispose () {
  _authState.close();
}

  void createUser(String email) {
    _authState.value = AppUser(uid: email.split('').reversed.join(),email: email);
  }
}


final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    const isFake = String.fromEnvironment('useFakeRepos') == 'true';
    final auth = !isFake ? FakeAuthRepository() : ApiAuthRepository();
    ref.onDispose(() => auth.dispose());
    return auth;
    },
);

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});