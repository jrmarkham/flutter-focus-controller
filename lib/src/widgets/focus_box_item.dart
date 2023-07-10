import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:flutter/material.dart';

class FocusBoxItem extends StatelessWidget {
  final String name;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool skipTraversal;
  final VoidCallback? focusCallback;

  const FocusBoxItem(
      {required this.name,
      required this.focusNode,
      this.autoFocus = false,
      this.skipTraversal = false,
      this.focusCallback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return EnsureVisibleWhenFocused(
        focusNode: focusNode,
        child: Focus(
            focusNode: focusNode,
            autofocus: autoFocus,
            skipTraversal: skipTraversal,
            canRequestFocus: true,
            onFocusChange: (bool focus) => focus && focusCallback != null ? focusCallback!() : null,
            child: Builder(builder: (BuildContext context) {
              final bool hasFocus = Focus.of(context).hasPrimaryFocus;
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: 95.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: hasFocus ? Colors.red : Colors.grey, width: hasFocus ? 4 : 2),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: hasFocus ? Colors.red : Colors.grey,
                        fontSize: hasFocus ? 14 : 12,
                        fontWeight: hasFocus ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            })));
  }
}
