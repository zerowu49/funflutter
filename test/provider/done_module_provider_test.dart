import 'package:flutter_test/flutter_test.dart';
import 'package:funflutter/provider/done_module_provider.dart';

void main() {
  group('Provider Test', () {
    final testModuleName = 'Test Module';
    late DoneModuleProvider doneModuleProvider;

    // arrange
    // setUp untuk inisiasi variabel yang
    // dijalankan sebelum tiap pengujian test
    setUp(() {
      doneModuleProvider = DoneModuleProvider();
    });

    test('should contain new item when module completed', () {
      // act
      doneModuleProvider.complete(testModuleName);
      // assert
      var result = doneModuleProvider.doneModuleList.contains(testModuleName);
      expect(result, true);
    });

    test('should not contain item when module removed', () {
      // act
      doneModuleProvider.remove(testModuleName);
      // assert
      var result = doneModuleProvider.doneModuleList.contains(testModuleName);
      expect(result, false);
    });
  });
}
