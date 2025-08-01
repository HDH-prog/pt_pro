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
  final List<String> ptGoals = ['다이어트', '벌크업', '체형 교정', '체력증진', '바디프로필', '건강'];
  final TextEditingController notesController = TextEditingController();
  late List<String> selectedGoals;
  late List<String> originalGoals;
  late String originalNote;

  bool isEditing = false;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    selectedGoals = List<String>.from(widget.member.ptGoal);
    originalGoals = List<String>.from(widget.member.ptGoal);
    notesController.text = widget.member.notes ?? '';
    originalNote = notesController.text;

    notesController.addListener(checkChanges);
  }

  void checkChanges() {
    final currentNote = notesController.text;
    final goalChanged = !_listEquals(originalGoals, selectedGoals);
    final noteChanged = currentNote != originalNote;

    setState(() {
      hasChanges = goalChanged || noteChanged;
    });
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    final aSorted = [...a]..sort();
    final bSorted = [...b]..sort();
    for (int i = 0; i < aSorted.length; i++) {
      if (aSorted[i] != bSorted[i]) return false;
    }
    return true;
  }

  void toggleGoal(String goal) {
    if (!isEditing) return;
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else {
        selectedGoals.add(goal);
      }
      checkChanges();
    });
  }

  void onEditPressed() {
    if (!isEditing) {
      setState(() {
        isEditing = true;
      });
    } else {
      if (hasChanges) {
        // 저장 로직
        setState(() {
          isEditing = false;
          originalGoals = List<String>.from(selectedGoals);
          originalNote = notesController.text;
          hasChanges = false;
        });
        // 실제 저장 처리 필요 시 여기에 추가
      } else {
        // 취소 로직
        setState(() {
          isEditing = false;
          selectedGoals = List<String>.from(originalGoals);
          notesController.text = originalNote;
        });
      }
    }
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
  void dispose() {
    notesController.dispose();
    super.dispose();
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
            onPressed: onEditPressed,
            child: Text(
              !isEditing ? '수정하기' : (hasChanges ? '저장하기' : '취소'),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: List<TableRow>.generate((ptGoals.length / 2).ceil(), (
                index,
              ) {
                final left = ptGoals[index * 2];
                final right = (index * 2 + 1 < ptGoals.length)
                    ? ptGoals[index * 2 + 1]
                    : null;

                return TableRow(
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(left),
                      value: selectedGoals.contains(left),
                      onChanged: isEditing ? (_) => toggleGoal(left) : null,
                    ),
                    right != null
                        ? CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(right),
                            value: selectedGoals.contains(right),
                            onChanged: isEditing
                                ? (_) => toggleGoal(right)
                                : null,
                          )
                        : Container(),
                  ],
                );
              }),
            ),
            sectionTitle('특이사항 메모'),
            TextField(
              controller: notesController,
              enabled: isEditing,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: isEditing ? Colors.white : Colors.grey[300],
                border: const OutlineInputBorder(),
              ),
            ),
            sectionTitle('PT 현황'),
            Column(
              children: records.map((record) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[300]),
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
