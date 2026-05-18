// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const brickColors = [
  Color(0xffff006e),
  Color(0xfffb5607),
  Color(0xffffbe0b),
  Color(0xff8338ec),
  Color(0xff3a86ff),
  Color(0xff06d6a0),
  Color(0xff4cc9f0),
  Color(0xfff72585),
  Color(0xff7209b7),
  Color(0xff4361ee),
];

const gameWidth = 820.0;
const gameHeight = 1600.0;

const ballRadius = gameWidth * 0.02;

const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;

const brickGutter = gameWidth * 0.015;

final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;

const brickHeight = gameHeight * 0.03;

const difficultyModifier = 1.03;

const startingLives = 3;