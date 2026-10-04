import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../ui/app_colors.dart';

class CultureActionTarget extends StatefulWidget {
  final String semanticLabel;
  final Widget child;
  final void Function()? onActivate;
  final void Function(TapUpDetails details)? onTapUp;
  final BorderRadius borderRadius;
  final bool selected;

  const CultureActionTarget({
    super.key,
    required this.semanticLabel,
    required this.child,
    this.onActivate,
    this.onTapUp,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.selected = false,
  });

  @override
  State<CultureActionTarget> createState() => _CultureActionTargetState();
}

class _CultureActionTargetState extends State<CultureActionTarget> {
  bool _focusHighlighted = false;
  bool _hoverHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onActivate != null || widget.onTapUp != null;
    final bool highlighted = _focusHighlighted || _hoverHighlighted;

    return Semantics(
      button: true,
      enabled: enabled,
      selected: widget.selected,
      label: widget.semanticLabel,
      onTap: widget.onActivate,
      child: FocusableActionDetector(
        enabled: enabled,
        mouseCursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (ActivateIntent intent) {
              widget.onActivate?.call();
              return null;
            },
          ),
        },
        onShowFocusHighlight: (bool value) {
          setState(() {
            _focusHighlighted = value;
          });
        },
        onShowHoverHighlight: (bool value) {
          setState(() {
            _hoverHighlighted = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            border: Border.all(
              color: highlighted ? AppColors.coral : Colors.transparent,
              width: 2,
            ),
            borderRadius: widget.borderRadius,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTapUp == null ? widget.onActivate : null,
            onTapUp: widget.onTapUp,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
