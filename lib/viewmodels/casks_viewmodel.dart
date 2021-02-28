import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CasksViewModel extends ValueNotifier {
  final TextEditingController _filterController = TextEditingController();
  List<Cask> _fetchedCasks;
  List<Cask> _filteredCasks;
  Object _error;

  CasksViewModel() : super(null) {
    fetch();
  }

  TextEditingController get filterController => _filterController;
  List<Cask> get fetchedCasks => _fetchedCasks;
  List<Cask> get filteredCasks => _filteredCasks;
  Object get error => _error;

  Future fetch({cache = true}) async {
    this._filterController.clear();
    this._error = null;
    notifyListeners();
    try {
      this._fetchedCasks = await ApiService.fetchCasks(cache: cache);
      this._filteredCasks = this._fetchedCasks;
      notifyListeners();
    } catch (exception) {
      this._error = exception;
      notifyListeners();
      rethrow;
    }
    return null;
  }

  void filter(String filter) {
    _filteredCasks = _fetchedCasks
        .where((cask) => cask.token.contains(RegExp(filter)))
        .toList();
    notifyListeners();
  }
}
