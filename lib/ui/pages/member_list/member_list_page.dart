import 'package:flutter/material.dart';
import 'package:pt_pro/ui/pages/member_list/widgets/member_search_bar.dart';
import 'package:pt_pro/ui/pages/member_list/widgets/member_card.dart';
import 'package:pt_pro/ui/pages/member_list/dummy_data.dart';
import 'package:pt_pro/model/member.dart';
import 'package:pt_pro/ui/pages/member_detail/member_detail_page.dart';

class MemberListPage extends StatefulWidget {
  @override
  State<MemberListPage> createState() => _MemberListPage();
}

class _MemberListPage extends State<MemberListPage> {
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

  void goToDetail(Member member) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemberDetailPage(member: member)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                      member: member,
                      onTap: () => goToDetail(member), // 상세페이지로 이동
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
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
