// Tests for Switcheroo.dart
//
// Run with: redstone test

import 'package:redstone_test/redstone_test.dart';

Future<void> main() async {
  await group('HelloBlock', () async {
    await testMinecraft('can be placed in the world', (game) async {
      final pos = BlockPos(0, 64, 0);

      // Place our custom block
      game.placeBlock(pos, Block('switcheroo_dart:hello_block'));

      // Verify it was placed
      final block = game.getBlock(pos);
      expect(block, isBlock('switcheroo_dart:hello_block'));
    });

    await testMinecraft('can be broken', (game) async {
      final pos = BlockPos(0, 64, 0);

      // Place and then break the block
      game.placeBlock(pos, Block('switcheroo_dart:hello_block'));
      game.setBlock(pos, Block.air);

      // Verify it's now air
      expect(game.getBlock(pos), isAirBlock);
    });
  });

  await group('HelloWand', () async {
    await testMinecraft('can be given to player', (game) async {
      final player = game.player;

      // Give the item to the player
      game.giveItem(player, Item('switcheroo_dart:hello_wand'));

      // Verify player has the item
      expect(player.inventory.contains('switcheroo_dart:hello_wand'), isTrue);
    });
  });

  await group('World basics', () async {
    await testMinecraft('can access world time', (game) async {
      final time = game.world.timeOfDay;
      expect(time, greaterThanOrEqualTo(0));
    });

    await testMinecraft('can wait for ticks', (game) async {
      final startTick = game.currentTick;

      // Wait for 20 ticks (1 second in game time)
      await game.waitTicks(20);

      expect(game.currentTick, greaterThanOrEqualTo(startTick + 20));
    });
  });
}
