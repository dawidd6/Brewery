import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CasksViewModel extends ValueNotifier {
  final TextEditingController _filterController = TextEditingController();
  List<Cask> _fetchedCasks;
  List<Cask> _filteredCasks;

  CasksViewModel() : super(null) {
    fetch();
  }

  TextEditingController get filterController => _filterController;
  List<Cask> get casks => _filteredCasks;

  Future fetch({cache = true}) async {
    this._filterController.clear();
    this._fetchedCasks = await ApiService.fetchCasks(cache: cache);
    this._filteredCasks = this._fetchedCasks;
    notifyListeners();
    return null;
  }

  void filter(String filter) {
    _filteredCasks = _fetchedCasks
        .where((cask) => cask.token.contains(RegExp(filter)))
        .toList();
    notifyListeners();
  }
}
