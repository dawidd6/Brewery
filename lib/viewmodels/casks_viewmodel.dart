import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CasksViewModel extends ValueNotifier {
  final TextEditingController _filterController = TextEditingController();
  List<Cask> _fetchedCasks;
  List<Cask> _filteredCasks;
  Exception _exception;

  CasksViewModel() : super(null) {
    fetch();
  }

  TextEditingController get filterController => _filterController;
  List<Cask> get fetchedCasks => _fetchedCasks;
  List<Cask> get filteredCasks => _filteredCasks;
  Exception get error => _exception;

  Future fetch({cache = true}) async {
    this._filterController.clear();
    this._exception = null;
    notifyListeners();
    try {
      this._fetchedCasks = await ApiService.fetchCasks(cache: cache);
      this._filteredCasks = this._fetchedCasks;
    } catch (exception) {
      this._exception = exception;
      rethrow;
    }
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
