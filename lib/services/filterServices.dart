import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/services/noteDataManagement.dart';

class FilterSettings {
  final DateTime? startDate;
  final String? selectedCategory;
  final String? searchQuery;
  FilterSettings({
    this.startDate,
    this.selectedCategory,
    this.searchQuery,
  });

  FilterSettings copyWith({
    DateTime? startDate,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return FilterSettings(
      startDate: startDate ?? this.startDate,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate?.millisecondsSinceEpoch,
      'selectedCategory': selectedCategory,
      'searchQuery': searchQuery,
    };
  }

  factory FilterSettings.fromMap(Map<String, dynamic> map) {
    return FilterSettings(
      startDate: map['startDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['startDate']) : null,
      selectedCategory: map['selectedCategory'],
      searchQuery: map['searchQuery'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterSettings.fromJson(String source) => FilterSettings.fromMap(json.decode(source));

  @override
  String toString() => 'FilterSettings(startDate: $startDate, selectedCategory: $selectedCategory, searchQuery: $searchQuery)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterSettings && other.startDate == startDate && 
    other.selectedCategory == selectedCategory && other.searchQuery == searchQuery;
  }

  @override
  int get hashCode => startDate.hashCode ^ selectedCategory.hashCode ^ searchQuery.hashCode;
}

final filterSettingsProvider = StateNotifierProvider<FilterSettingsNotifier, FilterSettings>((ref) {
  return FilterSettingsNotifier();
});

class FilterSettingsNotifier extends StateNotifier<FilterSettings> {
  FilterSettingsNotifier() : super(FilterSettings());

  void updateStartDate(DateTime? date) {
    state = state.copyWith(startDate: date);
  }

  void updateSelectedCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateSearchQuery(String? query) {
    state = state.copyWith(searchQuery: query);
  }
}

final filteredNotesProvider = FutureProvider<List<NoteDataModel>>((ref) async {
  final allNotes = await ref.watch(getNotesProvider.future);
  final filterSettings = ref.watch(filterSettingsProvider);

  final filteredNotes = allNotes.where((note) {
    final creationDate = note.creationDate;
    final category = note.category;
    final title = note.title ?? '';
    final content = note.content ?? '';

    // filter for data
    if (filterSettings.startDate != null &&
        creationDate != null &&
        creationDate.isBefore(
          filterSettings.startDate!,
        )) {
      return false;
    }

    // filter for categories or tags
    if (filterSettings.selectedCategory != null &&
        filterSettings.selectedCategory != "All" &&
        category != null &&
        category.title != filterSettings.selectedCategory) {
      return false;
    }

    // filter for my search with content and title
    if (filterSettings.searchQuery != null &&
        !(title.toLowerCase().contains(filterSettings.searchQuery!) ||
            content.toLowerCase().contains(
                  filterSettings.searchQuery!,
                ))) {
      return false;
    }

    return true;
  }).toList();

  return filteredNotes;
});
