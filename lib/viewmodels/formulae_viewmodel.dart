import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormulaeViewModel {
  final ValueNotifier<List<Formula>> fetchedFormulae = ValueNotifier([]);
  final ValueNotifier<List<Formula>> filteredFormulae = ValueNotifier([]);
  final TextEditingController filterController = TextEditingController();

  FormulaeViewModel() {
    fetch();
  }

  Future fetch({cache = true}) async {
    this.filterController.clear();
    this.fetchedFormulae.value = await ApiService.fetchFormulae(cache: cache);
    this.filteredFormulae.value = this.fetchedFormulae.value;
    return null;
  }

  void filter(String filter) {
    filteredFormulae.value = fetchedFormulae.value
        .where((formula) => formula.name.contains(RegExp(filter)))
        .toList();
  }
}
