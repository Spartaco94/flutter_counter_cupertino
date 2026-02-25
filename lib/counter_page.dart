import 'package:flutter/cupertino.dart';
import 'counter_button.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _increment() {
    _animController.forward().then((_) => _animController.reverse());
    setState(() => _counter++);
  }

  void _decrement() {
    _animController.forward().then((_) => _animController.reverse());
    setState(() => _counter--);
  }

  void _reset() {
    _animController.forward().then((_) => _animController.reverse());
    setState(() => _counter = 0);
  }

  Color get _counterColor {
    if (_counter > 0) return CupertinoColors.activeBlue;
    if (_counter < 0) return CupertinoColors.destructiveRed;
    return CupertinoColors.label;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Jarviss Counter'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _reset,
          child: const Icon(CupertinoIcons.refresh, size: 22),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Valore attuale',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.secondaryLabel,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 96,
                    fontWeight: FontWeight.w200,
                    color: _counterColor,
                    letterSpacing: -2,
                  ),
                  child: Text('$_counter'),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterButton(
                    icon: CupertinoIcons.minus,
                    onPressed: _decrement,
                    color: CupertinoColors.destructiveRed,
                    semanticLabel: 'Decrementa',
                  ),
                  const SizedBox(width: 32),
                  CounterButton(
                    icon: CupertinoIcons.add,
                    onPressed: _increment,
                    color: CupertinoColors.activeBlue,
                    semanticLabel: 'Incrementa',
                  ),
                ],
              ),
              const SizedBox(height: 48),
              CupertinoButton(
                onPressed: _reset,
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: CupertinoColors.secondaryLabel,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Generato da Jarviss AI',
                  style: TextStyle(
                    fontSize: 11,
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
