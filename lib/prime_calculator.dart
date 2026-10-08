import 'dart:isolate';

/// Spočítá prvočísla v intervalu 2..limit (včetně).
/// Záměrně používá pomalý postup, aby to bylo pomale.
/// Musí to být top-level funkce bez závislosti na UI.
int countPrimes(int limit) {
  if (limit < 2) return 0;
  var count = 1; // číslo 2
  for (var n = 3; n <= limit; n += 2) {
    if (_isPrime(n)) count++;
  }
  return count;
}

bool _isPrime(int n) {
  for (var d = 3; d * d <= n; d += 2) {
    if (n % d == 0) return false;
  }
  return true;
}

/// Stejný výpočet, ale v samostatném isolate.
Future<int> countPrimesInIsolate(int limit) {
  return Isolate.run(() => countPrimes(limit));
}
