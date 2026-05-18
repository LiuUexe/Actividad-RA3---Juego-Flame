// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
    required this.lives,
  });

  final ValueNotifier<int> score;
  final ValueNotifier<int> lives;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (context, score, child) {
        return ValueListenableBuilder<int>(
          valueListenable: lives,
          builder: (context, lives, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
              child: Text(
                'Score: $score   Lives: $lives'.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            );
          },
        );
      },
    );
  }
}