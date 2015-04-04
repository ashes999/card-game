package;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

import deengames.combocardgame.Deck;
import deengames.combocardgame.Card;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	static inline var CARD_SCALE:Float = 2/3.0;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		this.addAndShow('assets/images/background.png');
		var yourDeck = new Deck(10);
		var enemyDeck = new Deck(10);

		// Five of yours
		for(n in 0...5) {
			var card = yourDeck.dispenseCard();
			this.makeCard(card);
			card.sprites.x = (n * card.sprites.width * CARD_SCALE) + ((n + 1) * 16);
			card.sprites.y = Main.virtualHeight - (card.sprites.height * CARD_SCALE) -  64;
			MouseEventManager.add(card.sprite, function(sprite) {
					trace(card);
			});
		}
	}

	private function clickCard(sprite:FlxSprite) : Void {
		trace("Clicked on " + sprite + "!");
	}

	private function makeCard(card:Card) : Void
	{
		var base = addAndShow('assets/images/cards/card-base.png');
		var inhabitant = addAndShow("assets/images/cards/" + card.name + ".png");
		var border = addAndShow('assets/images/cards/card-border.png');

		// The offset is more for multiple digits compared to single digits.
		var aOffset = card.attack <= 9 ? 10 : 0;
		var dOffset = card.defense <= 9 ? 10: 0;
		var attackText = addText(Std.string(card.attack), 28 + aOffset, base.height - 90);
		var defenseText = addText(Std.string(card.defense), base.width - 75 + dOffset, base.height - 90);

		var group = new FlxSpriteGroup(0, 0);
		group.add(base);
		group.add(inhabitant);
		group.add(border);
		group.add(attackText);
		group.add(defenseText);
		group.scale.set(CARD_SCALE, CARD_SCALE);

		card.sprites = group;
		card.sprite = base;
	}

	private function addAndShow(string:String) : FlxSprite
	{
		var s:FlxSprite = new FlxSprite();
		s.loadGraphic(string);
		add(s);
		return s;
	}

	private function addText(string:String, x:Float, y:Float) : FlxText
	{
		var text = new FlxText(x, y, 0, string);
		text.setFormat("assets/fonts/OpenSans-Bold.ttf", 36, FlxColor.WHITE, "center");
		text.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 1);
		add(text);
		return(text);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}
