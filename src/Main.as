package 
{
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Yadu Rajiv
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			this._starling = new Starling(Game, this.stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			this._starling.start();
		}
		
		
	}
	
}