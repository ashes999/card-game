package;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxG;

import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

import deengames.combocardgame.Deck;
import deengames.combocardgame.Card;
import deengames.combocardgame.CardView;
import deengames.combocardgame.Combinator;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	static inline var CARD_SCALE:Float = 2/3.0;

	var firstCardPicked:Card;
	var secondCardPicked:Card;

	var comboCard:Card;
	var comboCardView:CardView;

	var combinator = new Combinator();

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;

		this.addAndShow('assets/images/background.png');
		var yourDeck = new Deck(10);
		var enemyDeck = new Deck(10);

		// Five of yours
		for(n in 0...5) {
			var card = yourDeck.dispenseCard();
			var view = this.makeUiForCard(card, true);
			view.sprites.x = (n * view.sprites.width * CARD_SCALE) + ((n + 1) * 16);
			view.sprites.y = Main.virtualHeight - (view.sprites.height * CARD_SCALE) - 32;
			addClickEvent(view.sprite, function(sprite) {
					showPicked(card);
			});
		}
	}

	// TODO: helperify
	private function addClickEvent(sprite:FlxSprite, callback:FlxSprite->Void) : Void
	{
		MouseEventManager.add(sprite, callback);
	}

	private function showPicked(card:Card) : Void
	{
		var view:CardView = null;

		// No cards picked, or only second card picked
		if (firstCardPicked == null && (secondCardPicked == null || secondCardPicked != card)) {
			firstCardPicked = card;
			view = makeUiForCard(firstCardPicked, false);
			view.sprites.x = 16;
			view.sprites.y = 16;
		// Only first card picked
		} else if (secondCardPicked == null && card != firstCardPicked) {
			secondCardPicked = card;
			view = makeUiForCard(secondCardPicked, false);
			view.sprites.x = 32 + view.sprites.width;
			view.sprites.y = 16;
		}

		if (firstCardPicked != null && secondCardPicked != null) {
			checkForAndShowCombo();
		}

		this.addClickEvent(view.sprite, function(sprite) {
			if (card == firstCardPicked) {
				firstCardPicked = null;
				destroyComboCardView();
			} else if (card == secondCardPicked) {
				secondCardPicked = null;
				destroyComboCardView();
			}
			view.destroy();
		});
	}

	private function destroyComboCardView() : Void
	{
		comboCard = null;
		if (comboCardView != null) {
			comboCardView.destroy();
		}
	}

	private function checkForAndShowCombo() : Void
	{
		var result = combinator.getCombo(firstCardPicked.name, secondCardPicked.name);
		if (result.name != "no-combo") {
			trace("v r " + result);
			result.name = 'combo'; // For testing
			comboCardView = makeUiForCard(result, false);
			comboCardView.sprites.x = Main.virtualWidth - 16 - comboCardView.sprites.width;
			comboCardView.sprites.y = 16;
		}
	}

	private function makeUiForCard(card:Card, scaleDown:Bool) : CardView
	{
		var base = addAndShow('assets/images/cards/card-base.png');
		var inhabitant = addAndShow("assets/images/cards/" + card.name + ".png");
		var border = addAndShow('assets/images/cards/card-border.png');

		// The offset is more for multiple digits compared to single digits.
		var aOffset = card.attack <= 9 ? 10 : 0;
		var dOffset = card.defense <= 9 ? 10: 0;
		var scale = scaleDown == true ? CARD_SCALE : 1;
		var textXOffset = scaleDown == false ? 12 : 6;
		var textYOffset = scaleDown == false ? 50 : 66;

		var textY:Int = Math.round((base.height - textYOffset) * scale);
		var attackText = addText(Std.string(card.attack), (aOffset - 12  + textXOffset) * scale, textY);
		var defenseText = addText(Std.string(card.defense), (base.width - 60 + textXOffset) * scale, textY);

		var group = new flixel.group.FlxSpriteGroup(0, 0);
		group.add(base);
		group.add(inhabitant);
		group.add(border);
		group.add(attackText);
		group.add(defenseText);

		if (scaleDown) {
			group.scale.set(CARD_SCALE, CARD_SCALE);
		}

		group.updateHitbox(); // For click detection

		return new CardView(group, base);
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
