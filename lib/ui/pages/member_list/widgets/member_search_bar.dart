import 'package:flutter/material.dart';

class MemberSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const MemberSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        maxLines: 1,
        controller: controller,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          hintText: '회원 이름을 입력해 주세요.',
          border: MaterialStateOutlineInputBorder.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              );
            }
            return OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            );
          }),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            onSearch(controller.text);
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
