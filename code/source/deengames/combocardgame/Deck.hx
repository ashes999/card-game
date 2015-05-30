package deengames.combocardgame;

import deengames.utils.JsonHelper;
import deengames.combocardgame.Card;

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
      // Create copies. They're distinct cards, mate.
      cards.push(masterCardList[i].clone());
    }
  }

  public function dispenseCard() : Card
  {
    var i:Int = Std.random(cards.length - 1);
    var toRemove = cards[i];
    cards.remove(toRemove);
    return toRemove;
  }

  public function getHand() : Array<Card>
  {
    var toReturn : Array<Card> = [];
    if (cards.length >= 5) {
       toReturn = [cards[0], cards[1], cards[2], cards[3], cards[4]];
    } else {
      var i:Int = 0;
      for (c in cards) {
        toReturn[i] = c;
        i++;
      }
    }

    return toReturn;
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
