import 'package:flutter/material.dart';
import 'package:pt_pro/model/member.dart';
import 'package:intl/intl.dart';

class MemberDetailPage extends StatelessWidget {
  final Member member;

  const MemberDetailPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) => DateFormat('yyyy.MM.dd').format(date);

    return Scaffold(
      appBar: AppBar(title: Text(member.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름: ${member.name}'),
            Text('전화번호: ${member.phone}'),
            Text('성별: ${member.gender.name}'),
            Text('생년월일: ${formatDate(member.birthDate)}'),
            Text('등록일: ${formatDate(member.registrationDate)}'),
            Text('PT 목표: ${member.ptGoal}'),
            Text('총 수업 횟수: ${member.sessionCount}'),
            Text('진행 중인 수업 횟수: ${member.currentSessionCount}'),
            Text(
              '남은 수업 횟수: ${member.sessionCount - member.currentSessionCount}',
            ),
            Text(
              '종료일: ${member.sessionEndDate != null ? formatDate(member.sessionEndDate!) : '미정'}',
            ),
            if (member.notes != null) Text('특이사항: ${member.notes}'),
          ],
        ),
      ),
    );
  }
}
