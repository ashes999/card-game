package deengames.combocardgame;

class Deck
{
  // TODO: proper data-driven architecture plzkthx, including attack/defense
  // TODO: cards are not just strings!
  private var masterCardList:Array<String> = ['alligator', 'bat', 'bird', 'dragon',
    'elephant', 'fire', 'golem', 'metal', 'snake', 'super-power', 'wood', 'wolf'];

  private var cards:Array<String> = new Array<String>();

  public function new(size:Int)
  {
    // Pick random cards of <size> size. Repeats are okay, mate.
    while (cards.length < size)
    {
      var i:Int = Std.random(masterCardList.length);
      cards.push(masterCardList[i]);
    }
  }

  // TODO: cards are not just strings!
  public function dispenseCard() : String
  {
    var i:Int = Std.random(cards.length);
    var toRemove = cards[i];
    cards.remove(toRemove);
    return toRemove;
  }
}
