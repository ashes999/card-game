package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flash.Lib;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		this.addAndShow('assets/images/background.png');

		// Five of yours
		for(n in 0...5) {
			var card = this.addAndShow('assets/images/sample-card.png');
			card.x = (n * card.width) + ((n+1) * 16);
			card.y = Main.gameHeight - card.height -  16;
		}
	}

	private function addAndShow(string:String)
	{
		var s:FlxSprite = new FlxSprite();
		s.loadGraphic(string);
		add(s);
		return s;
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
