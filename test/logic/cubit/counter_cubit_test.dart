import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/counter_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}


void main() {
  group('CounterCubit', () {

    CounterCubit? counterCubit;
    late Storage? storage;

    setUp(() {

      ///This stuff is for mocking Storage...
      storage = MockStorage();
      when(() => storage!.write(any(), any())).thenAnswer((_) async {});
      when<dynamic>(() => storage!.read(any())).thenReturn(<String, dynamic>{});
      when(() => storage!.delete(any())).thenAnswer((_) async {});
      when(() => storage!.clear()).thenAnswer((_) async {});
      HydratedBloc.storage = storage;

      ///Initialize CounterCubit() with CounterState(counterValue: 0)...
      counterCubit = CounterCubit();
    });

    tearDown(() {
      HydratedBloc.storage.clear();
      counterCubit!.close();
    });

    test('initial state of CounterCubit is CounterState(counterValue:0)', () {
      expect(counterCubit!.state, CounterState(counterValue: 0, wasIncremented: true));
    });

    blocTest<CounterCubit, CounterState>(
        'the CounterCubit should emit a CounterState(counterValue:1, wasIncremented:true) when the increment function is called',
        build: () => counterCubit!,
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest<CounterCubit, CounterState>(
        'the CounterCubit should emit a CounterState(counterValue:-1, wasIncremented:false) when the decrement function is called',
        build: () => counterCubit!,
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
