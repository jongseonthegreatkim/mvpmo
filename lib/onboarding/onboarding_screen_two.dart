import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets.dart';

class OnboardingScreenTwo extends StatefulWidget {
  
  const OnboardingScreenTwo({super.key, this.onDaySelected, required this.initialDayCount});

  final Function(int)? onDaySelected;
  final int initialDayCount;

  @override
  State<OnboardingScreenTwo> createState() => _OnboardingScreenTwoState();
}

class _OnboardingScreenTwoState extends State<OnboardingScreenTwo> {
  late int _selectedDayCount;
  final List<int> _availableDays = [1, 3, 5, 7, 14, 30];
  late final FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedDayCount = widget.initialDayCount;
    // Find the index of initialDayCount in _availableDays
    final initialIndex = _availableDays.indexOf(widget.initialDayCount);
    // If initialDayCount is not in _availableDays, default to 0
    _scrollController = FixedExtentScrollController(
      initialItem: initialIndex >= 0 ? initialIndex : 0,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onValueChanged(int index) {
    setState(() {
      _selectedDayCount = _availableDays[index];
    });

    widget.onDaySelected?.call(_selectedDayCount);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        children: [
          SizedBox(height: 60),
          // 방석 아이콘 (width < height 이므로, height만 설정)
          Image.asset('assets/images/character_with_cushion.png', height: 175),
          SizedBox(height: 12),
          // 메인 텍스트
          Onboarding.onboardingScreenMainTextContainer(
            '내가 그리는 나의 모습,\n하루잇 일기장에 남겨볼까요?'
          ),
          SizedBox(height: 28),
          // 목표설정 부분
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 80,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, -8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '저는 $_selectedDayCount일 동안',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121212),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                // CupertinoPicker
                SizedBox(
                  width: 80,
                  height: 150,
                  child: CupertinoPicker(
                    // Picker내부 아이템 각각의 높이
                    itemExtent: 50,
                    backgroundColor: Colors.transparent,
                    onSelectedItemChanged: _onValueChanged,
                    scrollController: _scrollController,
                    children: _availableDays.map((day) => Center(
                      child: Text(
                        '$day일',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF121212),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '루틴을 하고 싶어요',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121212),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}