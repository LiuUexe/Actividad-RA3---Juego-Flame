// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<BrickBreaker> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  final Radius cornerRadius;

  final Paint _bodyPaint = Paint()
    ..color = const Color(0xff3a0ca3)
    ..style = PaintingStyle.fill;

  final Paint _topPaint = Paint()
    ..color = const Color(0xff4cc9f0)
    ..style = PaintingStyle.fill;

  final Paint _enginePaint = Paint()
    ..color = const Color(0xffffbe0b)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final body = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      cornerRadius,
    );

    canvas.drawRRect(body, _bodyPaint);

    final topLine = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.x * 0.08,
        size.y * 0.15,
        size.x * 0.84,
        size.y * 0.25,
      ),
      const Radius.circular(8),
    );

    canvas.drawRRect(topLine, _topPaint);

    canvas.drawCircle(
      Offset(size.x * 0.2, size.y * 0.72),
      size.y * 0.18,
      _enginePaint,
    );

    canvas.drawCircle(
      Offset(size.x * 0.8, size.y * 0.72),
      size.y * 0.18,
      _enginePaint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }

  void moveBy(double dx) {
    add(
      MoveToEffect(
        Vector2((position.x + dx).clamp(0, game.width), position.y),
        EffectController(duration: 0.1),
      ),
    );
  }
}