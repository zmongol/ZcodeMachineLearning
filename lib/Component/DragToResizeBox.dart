import 'package:flutter/material.dart';

class DragToResizeBox extends StatelessWidget {
  DragToResizeBox({
    required this.width,
    required this.height,
    required this.child,
    required this.onWidthChange,
    required this.onHeightChange,
    required this.editable,
    required this.deletable,
    this.onTextBoxDeleted
  });
  final double width;
  final double height;

  final Widget child;
  final Function onWidthChange;
  final Function onHeightChange;

  final bool editable;
  final bool deletable;
  final Function? onTextBoxDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
          Positioned(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                  border: editable
                      ? Border.all(width: 1, color: Colors.white)
                      : null),
            ),
          )),
          editable
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onPanUpdate: (d) {
                      onWidthChange(d.delta.dx);
                      onHeightChange(d.delta.dy);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      color: Colors.white,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.open_in_full_outlined,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ))
              : SizedBox(),
          deletable && editable
              ? Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  onTextBoxDeleted!();
                },
                child: Container(
                    width: 32,
                    height: 32,
                    color: Colors.white,
                    child: Icon(
                      Icons.delete, size: 16,
                      color: Colors.red[800],
                    )
                ),
              ))
              : SizedBox()
        ],
      ),
    );
  }
}
