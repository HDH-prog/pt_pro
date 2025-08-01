import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemberRegisterPage extends StatefulWidget {
  const MemberRegisterPage({super.key});

  @override
  State<MemberRegisterPage> createState() => _MemberRegisterPageState();
}

class _MemberRegisterPageState extends State<MemberRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthYearController = TextEditingController();
  final TextEditingController sessionCountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String gender = '남자';
  DateTime? registrationDate;
  DateTime? sessionStartDate;
  DateTime? sessionEndDate;

  final List<String> ptGoals = ['다이어트', '벌크업', '체형 교정', '체력증진', '바디프로필', '건강'];
  List<String> selectedGoals = [];

  Future<void> pickDate(
    BuildContext context,
    Function(DateTime) onSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2030),
    );
    if (picked != null) onSelected(picked);
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy.MM.dd').format(date) : '날짜 선택';
  }

  Widget buildToggleButton(String goal) {
    final bool isSelected = selectedGoals.contains(goal);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedGoals.remove(goal) : selectedGoals.add(goal);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          goal,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final int? birthYear = int.tryParse(birthYearController.text);
    final int age = (birthYear != null) ? currentYear - birthYear : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('회원 추가 화면', style: TextStyle(fontSize: 16)),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // 사진
            Row(children: [Text('사진 : '), Icon(Icons.camera_alt_outlined)]),
            SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: '전화번호'),
            ),

            // 성별
            DropdownButtonFormField<String>(
              value: gender,
              items: [
                '남자',
                '여자',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => gender = value!),
              decoration: InputDecoration(labelText: '성별'),
            ),

            TextField(
              controller: birthYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '생년 (예: 1990)'),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 8),
            Text('만 나이 : ${age > 0 ? '만 $age세' : '-'}'),

            // 등록일
            SizedBox(height: 16),
            Row(
              children: [
                Text('등록일 : '),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => pickDate(context, (date) {
                    setState(() => registrationDate = date);
                  }),
                ),
                Text(formatDate(registrationDate)),
              ],
            ),

            // 수업일
            Row(
              children: [
                Text('수업 시작/종료일 : '),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => pickDate(context, (date) {
                    setState(() => sessionStartDate = date);
                  }),
                ),
                Text(formatDate(sessionStartDate)),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => pickDate(context, (date) {
                    setState(() => sessionEndDate = date);
                  }),
                ),
                Text(formatDate(sessionEndDate)),
              ],
            ),

            SizedBox(height: 16),
            Text('PT 목표 :'), // 회원 상세 페이지랑 공통된 구조. 위젯화하기.
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
                      onChanged: (checked) {
                        setState(() {
                          if (checked == true) {
                            selectedGoals.add(left);
                          } else {
                            selectedGoals.remove(left);
                          }
                        });
                      },
                    ),
                    right != null
                        ? CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(right),
                            value: selectedGoals.contains(right),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  selectedGoals.add(right);
                                } else {
                                  selectedGoals.remove(right);
                                }
                              });
                            },
                          )
                        : Container(),
                  ],
                );
              }),
            ),

            TextField(
              controller: sessionCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '수업 등록 횟수'),
            ),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: '특이사항 메모'),
              maxLines: 3,
            ),

            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // 저장 로직 처리 예정
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('저장하기', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
