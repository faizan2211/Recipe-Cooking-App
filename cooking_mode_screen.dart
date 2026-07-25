import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

class CookingModeScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingModeScreen({super.key, required this.recipe});

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  int _currentStepIndex = 0;
  Timer? _timer;
  int _timerSecondsRemaining = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _resetStepTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetStepTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    final step = widget.recipe.steps[_currentStepIndex];
    if (step.durationMinutes != null && step.durationMinutes! > 0) {
      _timerSecondsRemaining = step.durationMinutes! * 60;
    } else {
      _timerSecondsRemaining = 0;
    }
    setState(() {});
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      setState(() {
        _isTimerRunning = false;
      });
    } else {
      if (_timerSecondsRemaining <= 0) return;
      _isTimerRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timerSecondsRemaining > 0) {
          setState(() {
            _timerSecondsRemaining--;
          });
        } else {
          timer.cancel();
          setState(() {
            _isTimerRunning = false;
          });
          _showTimerCompletedDialog();
        }
      });
    }
  }

  void _showTimerCompletedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('⏰ ', style: TextStyle(fontSize: 24)),
            Text('Timer Finished!'),
          ],
        ),
        content: Text(
          'Step ${_currentStepIndex + 1} timer has completed. Ready for the next step!',
          style: GoogleFonts.plusJakartaSans(),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              if (_currentStepIndex < widget.recipe.steps.length - 1) {
                _nextStep();
              }
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStepIndex < widget.recipe.steps.length - 1) {
      setState(() {
        widget.recipe.steps[_currentStepIndex].isCompleted = true;
        _currentStepIndex++;
      });
      _resetStepTimer();
    } else {
      // Completed all steps
      setState(() {
        widget.recipe.steps[_currentStepIndex].isCompleted = true;
      });
      _showCompletionDialog();
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
      _resetStepTimer();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 60)),
              const SizedBox(height: 12),
              Text(
                'Bon Appétit!',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You have completed cooking "${widget.recipe.title}". Enjoy your delicious meal!',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx); // close dialog
                    Navigator.pop(context); // back to recipe detail
                  },
                  child: const Text(
                    'Finish & Back to Recipe',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimer(int totalSeconds) {
    final mins = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.recipe.steps[_currentStepIndex];
    final progress = (_currentStepIndex + 1) / widget.recipe.steps.length;

    return Scaffold(
      backgroundColor: const Color(0xFF18181F), // Dark cinematic background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cooking Mode',
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                ),
                child: Text(
                  'Step ${_currentStepIndex + 1} / ${widget.recipe.steps.length}',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Linear progress bar top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF22222C),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Title Header
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${step.stepNumber}',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              step.title,
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white12),
                      const SizedBox(height: 16),

                      // Step Description
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            step.description,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 17,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),

                      // Timer Widget if applicable
                      if (step.durationMinutes != null && step.durationMinutes! > 0) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF18181F),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _isTimerRunning
                                  ? AppColors.primary
                                  : Colors.white24,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Top row: icon + label + time display
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: _isTimerRunning ? AppColors.primary : Colors.white70,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Step Timer',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    _formatTimer(_timerSecondsRemaining),
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _isTimerRunning ? AppColors.primaryLight : Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Bottom row: Start/Pause + Reset buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isTimerRunning
                                            ? Colors.redAccent
                                            : AppColors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: _toggleTimer,
                                      icon: Icon(
                                        _isTimerRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                        size: 18,
                                      ),
                                      label: Text(
                                        _isTimerRunning ? 'Pause Timer' : 'Start Timer',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white70,
                                      side: const BorderSide(color: Colors.white24),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: _resetStepTimer,
                                    icon: const Icon(Icons.refresh_rounded, size: 16),
                                    label: Text(
                                      'Reset',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],

                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom navigation controls
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Row(
              children: [
                if (_currentStepIndex > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _previousStep,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous'),
                    ),
                  ),
                if (_currentStepIndex > 0) const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _nextStep,
                    label: Text(
                      _currentStepIndex == widget.recipe.steps.length - 1
                          ? 'Finish Cooking'
                          : 'Next Step',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    icon: Icon(
                      _currentStepIndex == widget.recipe.steps.length - 1
                          ? Icons.check_circle
                          : Icons.arrow_forward,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
