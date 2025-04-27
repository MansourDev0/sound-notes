// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sound_notes/core/extentions/size-config-extentions.dart';

class RecordingWavWidget extends StatefulWidget {
  const RecordingWavWidget({super.key});

  @override
  State<RecordingWavWidget> createState() => _RecordingWavWidgetState();
}

class _RecordingWavWidgetState extends State<RecordingWavWidget> {
  final List<double> _heights = [0.05, 0.07, 0.1, 0.07, 0.05];
  Timer? _timer;

  @override
  void initState() {
    _startAnimating();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(microseconds: 150), (timer) {
      setState(() {
        // this is asimple way to rotate the list, creating a wave effect
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            _heights.map((height) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 20.w,
                height: MediaQuery.sizeOf(context).height * height,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class RecordingButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onPressed;

  const RecordingButton({
    super.key,
    required this.isRecording,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 100,
      height: 100,
      padding: EdgeInsets.all(isRecording ? 25 : 15),
      decoration: BoxDecoration(
        color: Colors.white,

        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: isRecording ? 8 : 3),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: const CircleBorder(),
          child: SizedBox.shrink(),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------------------
// Recoeding Screen
