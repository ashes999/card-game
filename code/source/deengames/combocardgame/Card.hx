package deengames.combocardgame;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Card
{
  public var name(default, default):String;
  public var attack(default, default):Int;
  public var defense(default, default):Int;
  public var recipe(default, default):Array<String>; // only set on combo cards

  public function new() { }

  public function clone() : Card
  {
    var copy = new Card();
    copy.name = this.name;
    copy.attack = this.attack;
    copy.defense = this.defense;
    return copy;
  }

  public function toString() : String
  {
    return this.name + " (" + this.attack + "/" + this.defense + ")";
  }
}
