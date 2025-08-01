import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name; // 모델클래스 불러올 것
  final String ptCount; // 모델클래스 불러올 것
  final String sessionEndDate; // 모델클래스 불러올 것
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.name,
    required this.ptCount,
    required this.sessionEndDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // TODO: 상세페이지 이동
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
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text('PT 남은 회차: $ptCount회'),
                Text('종료일: $sessionEndDate'),
              ],
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
