import 'package:bloc_test/bloc_test.dart';
import 'package:counter_app_bloc/cubit/counter_cubit.dart';
import 'package:counter_app_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// unit test
  group("CounterCubit", () {
    CounterCubit? counterCubit;
    setUp(() {
      counterCubit = CounterCubit();
    });
    tearDown(() {
      counterCubit?.close();
    });

    test(
        "the initial state for the CounterCubit is CounterState(counterValue: 0)",
        () {
      expect(CounterCubit().state, const CounterState(countValue: 0));
    });
    
    blocTest("the incremented value of CounterCubit should be CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called",
        build: () => counterCubit!,
        act: (cubit) => counterCubit?.increment(),
        expect: () => [const CounterState(countValue: 1, wasIncremented: true)],
    );

    blocTest("The decremented value should become CounterState(countValue: -1, wasIncremented: false) when cubit.decrement() function is called",
        build: () => counterCubit!,
        act: (cubit) => counterCubit?.decrement(),
        expect: () => [const CounterState(countValue: -1, wasIncremented: false)]
    );
    
  });

  /// widget test
  testWidgets("Counter increment and decrement",
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => CounterCubit(),
            child: const MyHomePage(title: 'Flutter Demo Home Page',),
          ),
        )
      );
      /// verify the initial states
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      expect(find.text('-1'), findsNothing);

      /// increment the counter
      await widgetTester.tap(find.byIcon(Icons.add));
      await widgetTester.pump();

      /// verify the incremented states
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);

      /// decrement the counter
      await widgetTester.tap(find.byIcon(Icons.remove));
      await widgetTester.pump();

      /// verify the decremented states
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      expect(find.text('-1'), findsNothing);

      /// decrement the counter
      await widgetTester.tap(find.byIcon(Icons.remove));
      await widgetTester.pump();

      /// verify the decremented states
      expect(find.text('-1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });
}
