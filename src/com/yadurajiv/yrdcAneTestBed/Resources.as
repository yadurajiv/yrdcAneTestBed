package com.yadurajiv.yrdcAneTestBed
{
	import com.freshplanet.ane.AirFacebook.Facebook;
	import com.yadurajiv.yrdcAneTestBed.screens.screenMenu;
	import feathers.controls.Alert;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Yadu Rajiv
	 */
	public class Resources 
	{
		
		/**
		 * Constants
		 */
		public static const APP_TITLE:String = "yrdcAneTestBed";
		
		/**
		 * FACEBOOK ANE
		 */
		//The key from your application page on Facebook developer portal (http://developers.facebook.com)
		public static const FACEBOOK_APPLICATION_KEY:String = "";
		
		/**
		 * SCREEN NAMES
		 */
		public static const SCREEN_MENU:String = "screenMenu";
		
		// Feathers navigator to navigate between screens
		public static var Navigator:ScreenNavigator;
		
		
		// creates all screens and adds them to parent
		public static function init(parent:Sprite):void {	
			
			/**
			 * Facebook
			 */
			// init facebook if it is supported
			if (Facebook.isSupported) {
				Facebook.getInstance().init(FACEBOOK_APPLICATION_KEY);
			}
			
			// init feathers theme
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(parent.stage);
			
			// setup navigator
			Resources.Navigator = new ScreenNavigator();
			parent.addChild(Resources.Navigator);
			
			/**
			 * Screens
			 */
			// main menu screen
			var sMenu:ScreenNavigatorItem = new ScreenNavigatorItem(new screenMenu);
			Resources.Navigator.addScreen(Resources.SCREEN_MENU, sMenu);
			
			// add a sliding transition for screens
			var transition:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(Resources.Navigator);
			transition.duration = 1;
			transition.ease = Transitions.EASE_IN_OUT;
			
			// show the main menu
			Resources.Navigator.showScreen(Resources.SCREEN_MENU);
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onAppDeactivate);
		}
		
		public static function onAppActivate(e:Event):void {
			// start sounds, start starling
			Starling.current.start();
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onAppDeactivate);
		}
		
		public static function onAppDeactivate(e:Event):void {
			// stop sounds, stop starling
			Starling.current.stop(true);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onAppActivate);
		}
		
		// displays an alert box with an ok button
		public static function MsgBox(Text:String, Title:String = APP_TITLE):Alert {
			return Alert.show(Text, Title, new ListCollection([
				{ label: "OK" }
			]));
		}
		
	}
	
}