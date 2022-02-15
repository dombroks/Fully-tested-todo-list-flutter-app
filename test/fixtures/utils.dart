

import 'dart:io';

String fixture(String fileName) {
  return File('test/fixtures/$fileName').readAsStringSync();
}