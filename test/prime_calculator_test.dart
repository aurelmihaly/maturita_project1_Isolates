import 'package:flutter_test/flutter_test.dart';
import 'package:maturita_project1/prime_calculator.dart';

void main() {
  test('countPrimes vrací správné hodnoty pro malé limity', () {
    expect(countPrimes(1), 0);
    expect(countPrimes(2), 1);
    expect(countPrimes(10), 4); // 2, 3, 5, 7
    expect(countPrimes(100), 25);
  });

  test('countPrimes(1000) je 168', () {
    expect(countPrimes(1000), 168);
  });

  test('countPrimesInIsolate dává stejný výsledek jako přímé volání', () async {
    final fromIsolate = await countPrimesInIsolate(1000);
    expect(fromIsolate, countPrimes(1000));
  });
}
