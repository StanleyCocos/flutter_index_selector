import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexSelector extends StatefulWidget {
  final List<String> keys;
  final Function(String)? onChanged;

  const IndexSelector({
    super.key,
    required this.keys,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _NavListState();
}

class _NavListState extends State<IndexSelector> {
  int currentIndex = 0;
  OverlayEntry? _overlayEntry;
  final double _itemHeight = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onVerticalDragDown: (detail) {
            int index = (detail.localPosition.dy ~/ _itemHeight).round();
            _showFloatingWindow(widget.keys[index]);
            setState(() {
              currentIndex = index;
            });
            widget.onChanged?.call(widget.keys[index]);
          },
          onVerticalDragUpdate: (detail) {
            int index = (detail.localPosition.dy / _itemHeight).round();
            if (currentIndex != index) {
              HapticFeedback.mediumImpact();
              setState(() {
                currentIndex = index;
              });
              _showFloatingWindow(widget.keys[index]);
              widget.onChanged?.call(widget.keys[index]);
            }
          },
          onVerticalDragEnd: (_) => _removeFloatingWindow(),
          onVerticalDragCancel: _removeFloatingWindow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.keys
                .asMap()
                .map((k, v) {
                  bool selected = k == currentIndex;
                  return MapEntry(
                    k,
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                selected ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            v,
                            style: TextStyle(
                              fontSize: 12,
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
        )
      ],
    );
  }

  void _showFloatingWindow(String key) {
    _removeFloatingWindow();
    _overlayEntry = _createOverlayEntry(key);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeFloatingWindow() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(String key) {
    return OverlayEntry(
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: NavDialog(message: key),
          ),
        );
      },
    );
  }
}

class NavDialog extends StatelessWidget {
  final String message;

  const NavDialog({super.key, this.message = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black87,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
