import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:learning_bloc/bloc/bloc_actions.dart';
import 'package:learning_bloc/bloc/person.dart';
import 'package:learning_bloc/bloc/persons_bloc.dart';

const mockedPersons1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];

const mockedPersons2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];

Future<Iterable<Person>> mockedGetPersons1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockedGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    //write our tests

    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    //fetch some mock data(personal) and comape it with the result

    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons rom first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add( const LoadPersonAction(
            url: 'dummy_url_1',
            loader: mockedGetPersons1,
           ),
          );
          bloc.add( const LoadPersonAction(
            url: 'dummy_url_1',
            loader: mockedGetPersons1,
           ),
          );
        },
        expect: () => [
          const FetchResult(persons: mockedPersons1, isRetrievedFromCache: false,),
          const FetchResult(persons: mockedPersons1, isRetrievedFromCache: true,),
        ],
    );

        blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons rom second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add( const LoadPersonAction(
            url: 'dummy_url_2',
            loader: mockedGetPersons2,
           ),
          );
          bloc.add( const LoadPersonAction(
            url: 'dummy_url_2',
            loader: mockedGetPersons2,
           ),
          );
        },
        expect: () => [
          const FetchResult(persons: mockedPersons2, isRetrievedFromCache: false,),
          const FetchResult(persons: mockedPersons2, isRetrievedFromCache: true,),
        ],
    );
  },
 );
}
