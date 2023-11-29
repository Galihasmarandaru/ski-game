import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;
import 'package:ski_master/game/routes/gameplay.dart';
import 'package:ski_master/game/routes/level_selection.dart';
import 'package:ski_master/game/routes/main_menu.dart';
import 'package:ski_master/game/routes/settings.dart';

class SkiMasterGame extends FlameGame {
  final musicValueNotifier = ValueNotifier(true);
  final sfxValueNotifier = ValueNotifier(true);

  late final _routes = <String, Route>{
    MainMenu.id: OverlayRoute((context, game) {
      return MainMenu(
        onPlayPressed: () => _routeById(LevelSelection.id),
        onSettingsPressed: () => _routeById(Settings.id),
      );
    }),
    LevelSelection.id: OverlayRoute((context, game) {
      return LevelSelection(
        onLevelSelected: _startLevel,
        onBackPressed: _popRoute,
      );
    }),
    Settings.id: OverlayRoute((context, game) {
      return Settings(
        musicValueListenable: musicValueNotifier,
        sfxValueListenable: sfxValueNotifier,
        onMusicValueChanged: (value) => musicValueNotifier.value = value,
        onSfxValueChanged: (value) => sfxValueNotifier.value = value,
        onBackPressed: _popRoute,
      );
    }),
  };

  late final _router = RouterComponent(
    initialRoute: MainMenu.id,
    routes: _routes,
  );
  @override
  Future<void> onLoad() async {
    await add(_router);
  }

  // --- Routes Action ---
  void _routeById(String id) {
    _router.pushNamed(id);
  }

  void _popRoute() {
    _router.pop();
  }

  void _startLevel(int levelIndex) {
    _router.pop();
    _router.pushReplacement(
      Route(() => Gameplay(levelIndex)),
      name: Gameplay.id,
    );
  }
}
