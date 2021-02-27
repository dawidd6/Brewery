import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CasksViewModel {
  final ValueNotifier<List<Cask>> fetchedCasks = ValueNotifier([]);
  final ValueNotifier<List<Cask>> filteredCasks = ValueNotifier([]);
  final TextEditingController filterController = TextEditingController();

  CasksViewModel() {
    fetch();
  }

  Future fetch() async {
    this.filterController.clear();
    this.fetchedCasks.value = await ApiService.fetchCasks();
    this.filteredCasks.value = this.fetchedCasks.value;
    return null;
  }

  void filter(String filter) {
    filteredCasks.value = fetchedCasks.value
        .where((cask) => cask.token.contains(RegExp(filter)))
        .toList();
  }
}
