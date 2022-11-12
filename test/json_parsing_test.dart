import 'dart:convert';

import 'package:dicoding_mfde_submission/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dummy_data.dart';

void main() {

  test('Parsing List Result JSON', () async {
    var result = listRestaurants(jsonEncode(dummyListResult));

    expect(result[0].id, "rqdv5juczeskfw1e867");
    expect(result[1].id, "s1knt6za9kkfw1e867");
    expect(result.length, 2);
  });
  
  test('Parsing Search Result JSON', () {
    var result = listRestaurants(json.encode(dummySearchResult));

    expect(result[0].id, "fnfn8mytkpmkfw1e867");
    expect(result.length, 1);
  });

  test('Parsing Detail Result JSON', () async {
    var result = Restaurant.fromJson(dummyDetailResult);

    expect(result.id, "rqdv5juczeskfw1e867");
    expect(result.name, "Melting Pot");
  });
}