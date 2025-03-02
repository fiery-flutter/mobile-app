@Timeout(Duration(seconds: 10))
import 'package:flutter_test/flutter_test.dart';
import 'package:tortiki/bloc/error_handling/index.dart';
import 'package:tortiki/bloc/main/index.dart';
import 'package:tortiki/data/preferences/account.dart';
import 'package:tortiki/data/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class _MockErrorHandlingBloc extends Mock implements ErrorHandlingBloc {}

class _MockJwtRepository extends Mock implements JwtRepository {}

class _MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  MainBloc sut;
  _MockErrorHandlingBloc errorHandlingBloc;
  _MockJwtRepository jwtRepository;
  _MockAccountRepository accountRepository;

  final initialState = MainState.initial();

  setUp(() {
    jwtRepository = _MockJwtRepository();
    accountRepository = _MockAccountRepository();
    errorHandlingBloc = _MockErrorHandlingBloc();

    sut = MainBloc(
      jwtRepository: jwtRepository,
      accountRepository: accountRepository,
      errorHandlingBloc: errorHandlingBloc,
    );
  });

  tearDown(() {
    sut?.close();
  });

  test('initial state is correct', () {
    expect(sut.state, initialState);
  });

  test('close does not emit new states', () {
    sut.close();
    expectLater(
      sut,
      emitsDone,
    );
  });

  test(
      'BlocInit emits state with showCreatePostButton flag to true '
      'for authenticated confectioned', () {
    // given
    // when
    when(jwtRepository.getJwt())
        .thenAnswer((realInvocation) => Future.value('123'));
    when(accountRepository.getMyAccount()).thenAnswer((realInvocation) =>
        Future.value(Account(type: AccountType.confectioner)));
    sut.add(BlocInit());
    // then
    expectLater(
      sut,
      emits(initialState.copy(showCreatePostButton: true)),
    );
  });

  test(
      'BlocInit emits state with showCreatePostButton flag to false '
      'for authenticated client', () {
    // given
    // when
    when(jwtRepository.getJwt())
        .thenAnswer((realInvocation) => Future.value('123'));
    when(accountRepository.getMyAccount()).thenAnswer(
        (realInvocation) => Future.value(Account(type: AccountType.client)));
    sut.add(BlocInit());
    // then
    expectLater(
      sut,
      emits(initialState.copy(showCreatePostButton: false)),
    );
  });

  test(
      'BlocInit emits state with showCreatePostButton flag to false '
      'for not authenticated user', () {
    // given
    // when
    when(jwtRepository.getJwt())
        .thenAnswer((realInvocation) => Future.value(null));
    sut.add(BlocInit());
    // then
    expectLater(
      sut,
      emits(initialState.copy(showCreatePostButton: false)),
    );
  });
}
