// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import 'bat.dart';
import 'brick.dart';
import 'play_area.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
         radius: radius,
         anchor: Anchor.center,
         paint: Paint()
           ..color = const Color(0xff00f5d4)
           ..style = PaintingStyle.fill,
         children: [CircleHitbox()],
       );

  final Vector2 velocity;
  final double difficultyModifier;

  final Paint _glowPaint = Paint()
    ..color = const Color(0xff00f5d4).withOpacity(0.35)
    ..style = PaintingStyle.fill;

  final Paint _corePaint = Paint()
    ..color = const Color(0xffffffff)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(radius, radius),
      radius * 1.55,
      _glowPaint,
    );

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );

    canvas.drawCircle(
      Offset(radius * 0.72, radius * 0.72),
      radius * 0.28,
      _corePaint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        game.loseLife(this);
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
      velocity.x =
          velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }

      velocity.setFrom(velocity * difficultyModifier);
    }
  }
}