import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:share_plus/share_plus.dart';

part 'library_viewmodel.g.dart';

/// Provides a list of bookmarked hadiths
@riverpod
class BookmarksNotifier extends _$BookmarksNotifier {
  @override
  List<HadithSimpleModel> build() {
    final rawList = HiveStorageService.getAllBookmarks();
    return rawList.map((e) => HadithSimpleModel.fromJson(e)).toList();
  }

  void refresh() {
    final rawList = HiveStorageService.getAllBookmarks();
    state = rawList.map((e) => HadithSimpleModel.fromJson(e)).toList();
  }

  Future<void> removeBookmark(String id) async {
    await HiveStorageService.removeBookmark(id);
    refresh();
  }
}

/// Provides a map of notes where key=hadithId and value=note text
@riverpod
class NotesNotifier extends _$NotesNotifier {
  @override
  Map<String, String> build() {
    return HiveStorageService.getAllNotes();
  }

  void refresh() {
    state = HiveStorageService.getAllNotes();
  }

  Future<void> removeNote(String id) async {
    await HiveStorageService.deleteNote(id);
    refresh();
  }

  Future<void> exportNotes() async {
    final data = HiveStorageService.getAllNotes();
    if (data.isEmpty) return;
    
    final jsonStr = jsonEncode(data);
    await Share.share(jsonStr, subject: 'My Taqyid Notes');
  }
}
