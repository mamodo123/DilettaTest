import 'dart:async';

import 'package:flutter/material.dart';

class DelayedSubmitTextField extends StatefulWidget {
  final void Function(String?) onSubmit;

  const DelayedSubmitTextField({
    super.key,
    required this.onSubmit,
  });

  @override
  State<DelayedSubmitTextField> createState() => _DelayedSubmitTextFieldState();
}

class _DelayedSubmitTextFieldState extends State<DelayedSubmitTextField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;
  String? currentText;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      String? text = _controller.text.trim();
      if (text.isEmpty) {
        text = null;
      }
      if (currentText != text) {
        {
          widget.onSubmit(text);
          setState(() {
            currentText = text;
          });
        }
      }
    });
  }

  void _clearText() {
    _controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.clear,
                  color: Colors.green,
                ),
                onPressed: _clearText,
              )
            : const IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                onPressed: null,
              ),
      ),
    );
  }
}
