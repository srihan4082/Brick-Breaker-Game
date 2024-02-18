import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'score_card.dart';
import 'overlay_screen.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color.fromARGB(255, 217, 37, 37),
          displayColor: const Color.fromARGB(255, 129, 3, 26),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 46, 46, 46),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score, bestScore: game.bestScore),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) => 
                                const OverlayScreen(
                                  title: 'T A P   T O   P L A Y',
                                  subtitle: 'Use arrows to swipe',
                                ),
                              PlayState.gameOver.name: (context, game) =>
                                  const OverlayScreen(
                                      title: 'G A M E   O V E R',
                                      subtitle: 'Tap to Play Again!',
                                    ),
                              PlayState.won.name: (context, game) => 
                                  const OverlayScreen(
                                      title: 'Y O U   W O N ! ! !',
                                      subtitle: 'Tap to Play Again!',
                                    ),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
