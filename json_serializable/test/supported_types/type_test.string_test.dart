// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';

import 'package:test/test.dart';

import '../test_utils.dart';
import 'input.type_string.dart';

void main() {
  group('non-nullable', () {
    test('round trip', () {
      final object = SimpleClass.fromJson(_defaultInput);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_defaultOutput));

      final object2 = SimpleClass.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip null', () {
      expect(() => loudEncode(SimpleClass.fromJson({})), throwsTypeError);
    });

    test('round trip alternate values', () {
      final object = SimpleClass.fromJson(_nonDefaultJson);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nonDefaultJson));
      expect(encoded, isNot(loudEncode(_defaultOutput)));

      final object2 = SimpleClass.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });
  }); // end non-nullable group

  group('nullable', () {
    test('round trip', () {
      final object = SimpleClassNullable.fromJson(_defaultInput);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_defaultOutput));

      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip null', () {
      final object = SimpleClassNullable.fromJson({});
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nullableDefaultOutput));
      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });

    test('round trip alternate values', () {
      final object = SimpleClassNullable.fromJson(_nonDefaultJson);
      final encoded = loudEncode(object);

      expect(encoded, loudEncode(_nonDefaultJson));
      expect(encoded, isNot(loudEncode(_defaultOutput)));

      final object2 = SimpleClassNullable.fromJson(
        jsonDecode(encoded) as Map<String, Object?>,
      );
      expect(loudEncode(object2), encoded);
    });
  }); // end nullable group
}

const _defaultValue = 'a string';
const _altValue = 'another string';

final _defaultInput = <String, Object?>{'value': _defaultValue};

final _defaultOutput = {'value': _defaultValue, 'withDefault': _defaultValue};

final _nullableDefaultOutput = {'value': null, 'withDefault': _defaultValue};

final _nonDefaultJson = {'value': _altValue, 'withDefault': _altValue};
