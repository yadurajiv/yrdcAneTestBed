package 
{
	import com.yadurajiv.yrdcAneTestBed.Resources;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Yadu Rajiv
	 */
	public class Game extends Sprite 
	{
		public function Game():void  {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void {
			Resources.init(this);
		}
	}
	
}