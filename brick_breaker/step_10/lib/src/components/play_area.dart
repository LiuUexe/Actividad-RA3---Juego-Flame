// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  PlayArea()
    : super(
        paint: Paint()..color = const Color(0xff03045e),
        children: [RectangleHitbox()],
      );

  final List<Vector2> _stars = [];
  final Paint _starPaint = Paint()
    ..color = const Color(0xffffffff)
    ..style = PaintingStyle.fill;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    size = Vector2(game.width, game.height);

    final random = math.Random(7);

    for (var i = 0; i < 90; i++) {
      _stars.add(
        Vector2(
          random.nextDouble() * game.width,
          random.nextDouble() * game.height,
        ),
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    for (final star in _stars) {
      canvas.drawCircle(
        Offset(star.x, star.y),
        2,
        _starPaint,
      );
    }
  }
}