package deengames.combocardgame;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class CardView
{
  public var card(default, default):Card;
  public var sprite(default, default):FlxSprite;
  public var sprites(default, default):FlxSpriteGroup;

  public function new(group:FlxSpriteGroup, sprite:FlxSprite) {
    this.sprites = group;
    this.sprite = sprite;
  }

  public function toString() : String
  {
    return "View for " + this.card.name;
  }
}
