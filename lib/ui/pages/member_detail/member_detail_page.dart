import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pt_pro/model/member.dart';
import 'package:pt_pro/ui/pages/member_list/dummy_data.dart';

class MemberDetailPage extends StatefulWidget {
  final Member member;

  const MemberDetailPage({super.key, required this.member});

  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  final List<String> ptGoals = ['다이어트', '체형 교정', '벌크업', '체력증진', '바디프로필', '건강'];
  final TextEditingController notesController = TextEditingController();
  late List<String> selectedGoals;

  @override
  void initState() {
    super.initState();
    selectedGoals = List<String>.from(widget.member.ptGoal);
    notesController.text = widget.member.notes ?? '';
  }

  void toggleGoal(String goal) {
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else {
        selectedGoals.add(goal);
      }
    });
  }

  String formatDate(DateTime? date) {
    if (date == null) return '미정';
    return DateFormat('yyyy.MM.dd').format(date);
  }

  String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return '남자';
      case Gender.female:
        return '여자';
      case Gender.other:
        return '기타';
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final records = sessionRecords[member.id] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원정보'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: 수정 저장 로직
            },
            child: const Text('수정하기', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // 키보드 닫기
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              member.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(member.phone),
            sectionTitle('기본정보'),
            Text('성별: ${genderToString(member.gender)}'),
            Text('생년: ${member.birthDate.year}년'),
            Text('등록일: ${formatDate(member.registrationDate)}'),

            sectionTitle('수업 정보'),
            Text('수업 시작일: ${formatDate(member.sessionStartDate)}'),
            Text('수업 종료일: ${formatDate(member.sessionEndDate)}'),
            Text(
              '수업 회차: ${member.currentSessionCount}/${member.sessionCount}회',
            ),

            sectionTitle('PT 목표'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ptGoals.map((goal) {
                final isSelected = selectedGoals.contains(goal);
                return GestureDetector(
                  onTap: () => toggleGoal(goal),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.transparent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      goal,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            sectionTitle('특이사항 메모'),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(),
              ),
            ),

            sectionTitle('PT 현황'),
            Column(
              children: records.map((record) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(record['type'] ?? ''),
                      Text(record['count'] ?? ''),
                      Text(
                        record['date']?.isNotEmpty == true
                            ? record['date']!
                            : '미정',
                      ),
                      Text(record['status'] ?? ''),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
