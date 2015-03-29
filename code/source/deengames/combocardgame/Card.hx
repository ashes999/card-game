package deengames.combocardgame;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Card
{
  public var name(default, default):String;
  public var attack(default, default):Int;
  public var defense(default, default):Int;
  public var sprite(default, default):FlxSprite;
  public var sprites(default, default):FlxSpriteGroup;

  public function new() { }

  public function toString() : String
  {
    return this.name + " (" + this.attack + "/" + this.defense + ")";
  }
}
