import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../widgets.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {

  // 랜덤 이름을 위한 랜덤 형용사
  final List<String> adjectives = [
    '활발한', '조용한', '유쾌한', '용감한', '신중한',
    '긍정적인', '창의적인', '재치있는', '명랑한', '차분한',
  ];

  // 랜덤 이름을 위한 랜덤 동물
  final List<String> animals = [
    '토끼', '거북이', '고양이', '강아지', '펭귄',
    '호랑이', '여우', '수달', '다람쥐', '고래',
  ];

  @override
  void initState() {
    super.initState();
    final box = Hive.box('userBox');
    final uuid = const Uuid().v4();
    print('uuid 생성: $uuid');
    box.put('userId', uuid);
    print('uuid 저장: ${box.get('userId')}');
  }

  @override
  Widget build(BuildContext context) {
    // 랜덤 형용사와 랜덤 동물로 랜덤 이름 생성
    final String randomName = '${(adjectives..shuffle()).first} ${(animals..shuffle()).first}';

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
            // 100개 중에 선택될 랜덤 이름
            '똑똑, 하루잇 방에\n찾아온 $randomName님,\n만나서 반가워요!'
          ),
          SizedBox(height: 28),
          // 닉네임 부분
          Stack(
            children: [
              Image.asset('assets/images/profile_background_temp.png', height: 280),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 방석 아이콘 (width < height 이므로, height만 설정)
                    Image.asset('assets/images/profile_image_temp.png', height: 100),
                    SizedBox(height: 20),
                    Text(
                      randomName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8C7154),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}