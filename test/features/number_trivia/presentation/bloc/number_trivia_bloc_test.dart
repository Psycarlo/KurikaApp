import 'package:kurika_app/core/error/failures.dart';
import 'package:kurika_app/core/presentation/util/input_converter.dart';
import 'package:kurika_app/core/usecases/usecase.dart';
import 'package:kurika_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:kurika_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:kurika_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:kurika_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockGetConcreteNumberTrivia extends Mock
  implements GetConcreteNumberTrivia {}
  
class MockGetRandomNumberTrivia extends Mock
  implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock
  implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter
    );
  });

  test(
    'initialState should be Empty',
    () async {
      // assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(
      number: 1,
      text: 'Test Text'
    );

    void setUpMockInputConverterSuccess() =>
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    
    test(
      '''should call the InputConverter to validate and convert 
      the string to an unsigned integer''',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
        // assert
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE)
        ];
        expectLater(
          bloc, 
          emitsInOrder(expected)
        );
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(
          const Params(number: tNumberParsed)
        ));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
        // assert
        final expected = [
          Empty(),
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      '''should emit [Loading, Error] with a proper message for 
      the error when getting data fails''',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(
      number: 1,
      text: 'Test Text'
    );

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
        // assert
        final expected = [
          Empty(),
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      '''should emit [Loading, Error] with a proper message for 
      the error when getting data fails''',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}