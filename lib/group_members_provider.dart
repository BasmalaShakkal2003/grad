import 'package:flutter/material.dart';

class GroupMembersProvider with ChangeNotifier {
  final List<Map<String, String>> _members = [];

  List<Map<String, String>> get members => List.unmodifiable(_members);

  void addMember(Map<String, String> member) {
    _members.add(member);
    notifyListeners();
  }

  void removeMember(int index) {
    if (index >= 0 && index < _members.length) {
      _members.removeAt(index);
      notifyListeners();
    }
  }
}