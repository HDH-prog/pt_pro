import 'package:flutter/material.dart';
import 'package:pt_pro/ui/pages/member_list/widgets/member_search_bar.dart';
import 'package:pt_pro/ui/pages/member_list/widgets/member_card.dart';
import 'package:pt_pro/ui/pages/member_list/dummy_data.dart';

class MemberListPage extends StatefulWidget {
  @override
  State<MemberListPage> createState() => _MemeberListPage();
}

class _MemeberListPage extends State<MemberListPage> {
  TextEditingController textEditingController = TextEditingController();

  void search(String text) {
    print("search: $text");
    // TODO: 검색 기능 구현
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: MemberSearchBar(
            controller: textEditingController,
            onSearch: search,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '필터',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),

              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return MemberCard(
                      name: member['name'] ?? '',
                      ptCount: member['ptCount'] ?? '',
                      sessionEndDate: member['sessionEndDate'] ?? '',
                      onTap: () {
                        // TODO: 상세페이지 이동
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 12),
              // 회원 추가 버튼
              // TODO: 공통 위젯(버튼) 생성하면 바꾸기
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 회원 추가 페이지 이동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('회원 추가'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
