import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormulaeViewModel extends ValueNotifier {
  final TextEditingController _filterController = TextEditingController();
  List<Formula> _fetchedFormulae;
  List<Formula> _filteredFormulae;
  Exception _exception;

  FormulaeViewModel() : super(null) {
    fetch();
  }

  TextEditingController get filterController => _filterController;
  List<Formula> get fetchedFormulae => _fetchedFormulae;
  List<Formula> get filteredFormulae => _filteredFormulae;
  Exception get error => _exception;

  Future fetch({cache = true}) async {
    this._filterController.clear();
    this._exception = null;
    notifyListeners();
    try {
      this._fetchedFormulae = await ApiService.fetchFormulae(cache: cache);
      this._filteredFormulae = this._fetchedFormulae;
    } catch (exception) {
      this._exception = exception;
      rethrow;
    }
    notifyListeners();
    return null;
  }

  void filter(String filter) {
    _filteredFormulae = _fetchedFormulae
        .where((formula) => formula.name.contains(RegExp(filter)))
        .toList();
    notifyListeners();
  }
}
