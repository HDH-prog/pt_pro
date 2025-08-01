import 'package:flutter/material.dart';
import 'package:pt_pro/model/member.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 패키지

class MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback? onTap;

  const MemberCard({super.key, required this.member, this.onTap});

  @override
  Widget build(BuildContext context) {
    final int remainingSessionCount =
        member.sessionCount - member.currentSessionCount;

    final String sessionEnd = member.sessionEndDate != null
        ? DateFormat('yy.MM.dd').format(member.sessionEndDate!)
        : '미정';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 회원 정보
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text('PT 남은 회차: $remainingSessionCount회'),
                Text('종료일: $sessionEnd'),
              ],
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
