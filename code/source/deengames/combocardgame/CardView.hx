package deengames.combocardgame;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class CardView
{
  public var card(default, default):Card;
  public var sprite(default, default):FlxSprite;
  public var sprites(default, default):FlxSpriteGroup;
  public var index(default, default):Int;

  public function new(group:FlxSpriteGroup, sprite:FlxSprite, card:Card) {
    this.sprites = group;
    this.sprite = sprite;
    this.card = card;
  }

  public function toString() : String
  {
    return "View for " + this.card.name;
  }

  public function destroy() {
    this.sprite.destroy();
    this.sprites.destroy();
  }
}
