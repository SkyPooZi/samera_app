import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';

class InboxOtpInput extends StatefulWidget {
  final Function(String) onCompleted;
  
  const InboxOtpInput({super.key, required this.onCompleted});

  @override
  State<InboxOtpInput> createState() => _InboxOtpInputState();
}

class _InboxOtpInputState extends State<InboxOtpInput> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) { c.dispose(); }
    for (var f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    
    // Check if all filled
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      widget.onCompleted(code);
    } else {
      widget.onCompleted(""); // pass empty string if not fully completed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          width: 48,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: tsTitleMediumBold(Colors.black87),
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        );
      }),
    );
  }
}
