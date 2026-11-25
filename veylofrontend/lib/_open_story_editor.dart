import 'dart:io';
import 'package:flutter/material.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/story_editor/story_editor_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TranslationProvider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoryEditorPage(file: File('/tmp/veylo_story_preview.png')),
    ),
  ));
}
