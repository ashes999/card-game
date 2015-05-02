package deengames.combocardgame;

import deengames.utils.JsonHelper;
import deengames.combocardgame.Card;

class Combinator
{
  private static var masterComboCardList:Array<Card> = [];
  private static var jsonData;

  public function new()
  {
    loadCardData();
  }

  public function getCombo(c1:String, c2:String) : Card
  {
    for (c in masterComboCardList) {
      var missingCards = [c.recipe[0], c.recipe[1]];
      // Make sure both cards are included. Also covers cases like the recipe
      // requires the same card twice. Remove cards, and check if the list is empty.
      // Both are in the recipe, and both are not the same card
      missingCards.remove(c1);
      missingCards.remove(c2);

      if (missingCards.length == 0) {
        return c;
      }
    }

    return noComboCard();
  }

  private function loadCardData() : Void
  {
    if (jsonData == null) {
      jsonData = haxe.Json.parse(openfl.Assets.getText('assets/data/cards.json'));
      var cards:Array<Dynamic> = jsonData.comboCards;
      for (c in cards) {
        masterComboCardList.push(JsonHelper.copy(c, new Card()));
      }
    }
  }

  private function noComboCard() : Card
  {
    var c = new Card();
    c.name = "no-combo";
    c.attack = 0;
    c.defense = 0;
    return c;
  }
}
