import 'package:flutter/material.dart';

import 'prime_calculator.dart';
import 'spinner_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.limit = 5000000,
    this.uiThreadRunner = countPrimes,
    this.isolateRunner = countPrimesInIsolate,
  });

  /// Do kolika se prvočísla počítají (zadání: 5 milionů).
  final int limit;

  /// Funkce se dají vyměnit, aby šla obrazovka testovat bez skutečného isolate.
  final int Function(int) uiThreadRunner;
  final Future<int> Function(int) isolateRunner;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _busy = false;
  String _status = 'Zatím nic nespuštěno.';

  Future<void> _run(String label, Future<int> Function() job) async {
    setState(() {
      _busy = true;
      _status = 'Počítám ($label)…';
    });

    // Nechá Flutter vykreslit text „Počítám…“ dřív, než se UI zablokuje.
    // Bez tohoto řádku by se stav v režimu UI vlákno vůbec neukázal.
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final stopwatch = Stopwatch()..start();
    final primes = await job();
    stopwatch.stop();

    if (!mounted) return;
    setState(() {
      _busy = false;
      _status =
          '$label – prvočísel: $primes, čas: ${stopwatch.elapsedMilliseconds} ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zamrzne, nebo ne?')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpinnerBox(),
            const SizedBox(height: 32),
            Text(_status, key: const Key('status')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _busy
                  ? null
                  : () => _run(
                      'UI vlákno',
                      // async funkce běží synchronně až do prvního await,
                      // takže countPrimes zablokuje UI vlákno.
                      () async => widget.uiThreadRunner(widget.limit),
                    ),
              child: const Text('UI vlákno'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _busy
                  ? null
                  : () => _run(
                      'Isolate',
                      () => widget.isolateRunner(widget.limit),
                    ),
              child: const Text('Isolate'),
            ),
          ],
        ),
      ),
    );
  }
}
