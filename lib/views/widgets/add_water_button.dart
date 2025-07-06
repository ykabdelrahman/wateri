import 'package:flutter/material.dart';

class AddWaterButton extends StatefulWidget {
  final VoidCallback onTap;

  const AddWaterButton({super.key, required this.onTap});

  @override
  State<AddWaterButton> createState() => _AddWaterButtonState();
}

class _AddWaterButtonState extends State<AddWaterButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
    _waveController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _waveAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_waveAnimation.value * 0.05),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.lightBlue.shade300,
                        Colors.lightBlue.shade500,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlue.shade200,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 40),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        const Text(
          'Tap to add a glass',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
