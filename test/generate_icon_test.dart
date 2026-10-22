import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Generate Icon', (WidgetTester tester) async {
    const double size = 1024;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // لون الخلفية (نفس لون التطبيق الأزرق)
    final paint = Paint()..color = const Color(0xFF1565C0);
    canvas.drawRect(const Rect.fromLTWH(0, 0, size, size), paint);

    // اختيار أيقونة تقويم من مكتبة فلاتر
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.calendar_month.codePoint),
        style: TextStyle(
          fontSize: 700,
          fontFamily: Icons.calendar_month.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
    );

    // حفظ الصورة
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    final file = File('assets/icon.png');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData!.buffer.asUint8List());
  });
}
