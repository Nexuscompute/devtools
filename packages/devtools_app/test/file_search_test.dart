// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_app/src/debugger/file_search.dart';
import 'package:devtools_app/src/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/foundation.dart';

import 'support/mocks.dart';
import 'support/wrappers.dart';

void main() {
  final debuggerController = MockDebuggerController.withDefaults();
  final autoCompleteController = MockAutoCompleteController();

  Widget buildFileSearch() {
    // return FileSearchField(controller: debuggerController);

    return MaterialApp(
      home: Scaffold(
        body: Card(
          child: wrapWithAutoComplete(
            FileSearchField(controller: debuggerController),
            autoCompleteController,
          ),
        ),
      ),
    );

    // return Card(
    //   child: wrapWithAutoComplete(
    //     FileSearchField(controller: debuggerController),
    //     autoCompleteController,
    //   ),
    // );

    // wrapWithAutoComplete(
    //   FileSearchField(controller: debuggerController),
    //   autoCompleteController,
    // );
  }

  group('File search', () {
    setUp(() {
      when(debuggerController.sortedScripts)
          .thenReturn(ValueNotifier(mockScriptRefs));
    });

    testWidgetsWithWindowSize(
        'Autocomplete is visible', const Size(1000.0, 4000.0),
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFileSearch());
      // await tester.pumpWidget(wrap(Builder(builder: (context) {
      //   return buildFileSearch();
      // })));
      // await tester.pumpAndSettle();

      // debugDumpApp();
      print('AUTOCOMPLETE CONTROLLER IS ${autoCompleteController}');
      print('VALUE IS ${autoCompleteController.searchAutoComplete.value}');
      expect(autoCompleteController.searchAutoComplete.value,
          equals(mockScriptRefs));
    });
  });
}

class MockAutoCompleteController extends Fake
    implements AutoCompleteController {
  final _searchNotifier = ValueNotifier<String>('');

  @override
  final searchAutoComplete = ValueNotifier<List<String>>([]);

  @override
  ValueListenable<List<String>> get searchAutoCompleteNotifier =>
      searchAutoComplete;

  @override
  ValueListenable get searchNotifier => _searchNotifier;

  @override
  set search(String value) {
    _searchNotifier.value = value;
  }

  @override
  String get search => _searchNotifier.value;
}

// class MockAutoCompleteController extends Mock
//     implements AutoCompleteController {}
//   MockAutoCompleteController();

//   factory MockAutoCompleteController.withDefaults() {
//     final autoCompleteController = MockAutoCompleteController();
//     when(autoCompleteController.handleAutoCompleteOverlay(context: context, searchFieldKey: searchFieldKey, onTap: onTap)).thenReturn(ValueNotifier(false));
//     when(debuggerController.resuming).thenReturn(ValueNotifier(false));
//     when(debuggerController.breakpoints).thenReturn(ValueNotifier([]));
//     when(debuggerController.isSystemIsolate).thenReturn(false);
//     when(debuggerController.breakpointsWithLocation)
//         .thenReturn(ValueNotifier([]));
//     when(debuggerController.librariesVisible).thenReturn(ValueNotifier(false));
//     when(debuggerController.currentScriptRef).thenReturn(ValueNotifier(null));
//     when(debuggerController.sortedScripts).thenReturn(ValueNotifier([]));
//     when(debuggerController.selectedBreakpoint).thenReturn(ValueNotifier(null));
//     when(debuggerController.stackFramesWithLocation)
//         .thenReturn(ValueNotifier([]));
//     when(debuggerController.selectedStackFrame).thenReturn(ValueNotifier(null));
//     when(debuggerController.hasTruncatedFrames)
//         .thenReturn(ValueNotifier(false));
//     when(debuggerController.scriptLocation).thenReturn(ValueNotifier(null));
//     when(debuggerController.exceptionPauseMode)
//         .thenReturn(ValueNotifier('Unhandled'));
//     when(debuggerController.variables).thenReturn(ValueNotifier([]));
//     when(debuggerController.currentParsedScript)
//         .thenReturn(ValueNotifier<ParsedScript>(null));
//     return autoCompleteController;
//   }
// }
