import 'package:flutter/material.dart';

EditableTextContextMenuBuilder get appEditableTextContextMenuBuilder => (BuildContext context, EditableTextState editableTextState) {
      // 可能な場合はシステムコンテキストメニューを利用する
      if (SystemContextMenu.isSupported(context)) {
        return SystemContextMenu.editableText(
          editableTextState: editableTextState,
        );
      }

      // flutter-rendered なコンテキストメニューを利用する
      return AdaptiveTextSelectionToolbar.editableText(
        editableTextState: editableTextState,
      );
    };
