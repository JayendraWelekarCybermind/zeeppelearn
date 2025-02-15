import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String textContent;
  final Color textColor;
  final double? buttonWidth;
  final Color buttonColor;
  final Color borderColor;
  final double borderWidth;
  final double letterSpacing;
  final String? innerImage;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.fontWeight,
    required this.letterSpacing,
    required this.textContent,
    this.buttonWidth,
    required this.textColor,
    required this.buttonColor,
    required this.borderColor,
    required this.borderWidth,
    required this.onPressed,
    this.innerImage,
  });

  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton> {
  static const double _shadowHeight = 6;
  static double _position = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        setState(() {
          _position = 6;
        });
        widget.onPressed();
      },
      onTapDown: (_) {
        setState(() {
          _position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _position = 6;
        });
      },
      child: SizedBox(
          height: _shadowHeight + 44,
          width: widget.buttonWidth,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 44,
                  width: widget.buttonWidth,
                  decoration: BoxDecoration(
                      color: widget.borderColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              AnimatedPositioned(
                left: 0,
                right: 0,
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: 44,
                  width: widget.buttonWidth,
                  decoration: BoxDecoration(
                      color: widget.buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Center(
                    child: (widget.innerImage != null)
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: (widget.textContent != ''
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Image.asset(widget.innerImage!,
                                          height: 16,
                                        ),
                                        SizedBox(width: 10),
                                        Text(widget.textContent,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Circular Std",
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 16 * (-0.02),
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.none))
                                      ])
                                : Image.asset(widget.innerImage!)),
                          )
                        : Text(
                            widget.textContent,
                            style: TextStyle(
                                fontFamily: 'Circular Std',
                                letterSpacing:
                                    16 * (widget.letterSpacing / 100),
                                fontWeight: widget.fontWeight,
                                fontSize: 16,
                                color: widget.textColor,
                                decoration: TextDecoration.none),
                          ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
