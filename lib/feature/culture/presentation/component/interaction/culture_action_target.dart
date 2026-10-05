import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CultureActionTarget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool enabled = onActivate != null || onTapUp != null;

    return Semantics(
      button: true,
      enabled: enabled,
      selected: selected,
      label: semanticLabel,
      onTap: onActivate,
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
              onActivate?.call();
              return null;
            },
          ),
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 2),
            borderRadius: borderRadius,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTapUp == null ? onActivate : null,
            onTapUp: onTapUp,
            child: child,
          ),
        ),
      ),
    );
  }
}
