package deengames.combocardgame;

import deengames.utils.JsonHelper;

class Deck
{
  private static var masterCardList:Array<Card> = [];
  private static var jsonData;

  private var cards:Array<Card> = new Array<Card>();

  public function new(size:Int)
  {
    loadCardData();

    // Pick random cards of <size> size. Repeats are okay, mate.
    while (cards.length < size)
    {
      var i:Int = Std.random(masterCardList.length);
      cards.push(masterCardList[i]);
    }
  }

  // TODO: cards are not just strings!
  public function dispenseCard() : Card
  {
    var i:Int = Std.random(cards.length - 1);
    var toRemove = cards[i];
    cards.remove(toRemove);
    return toRemove;
  }

  private function loadCardData() : Void
  {
    if (jsonData == null) {
      jsonData = haxe.Json.parse(openfl.Assets.getText('assets/data/cards.json'));
      var cards:Array<Dynamic> = jsonData.cards;
      for (c in cards) {
        masterCardList.push(JsonHelper.copy(c, new Card()));		
      }
    }
  }
}

class Card
{
  public var name(default, default):String;
  public var attack(default, default):Int;
  public var defense(default, default):Int;

  public function new() { }

  public function toString() : String
  {
    return this.name + " (" + this.attack + "/" + this.defense + ")";
  }
}
