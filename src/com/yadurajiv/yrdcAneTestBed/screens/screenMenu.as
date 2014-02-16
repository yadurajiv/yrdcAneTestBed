package com.yadurajiv.yrdcAneTestBed.screens
{
	import com.freshplanet.ane.AirFacebook.Facebook;
	import com.yadurajiv.yrdcAneTestBed.Resources;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import flash.text.TextFormatAlign;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Yadu Rajiv
	 */
	public class screenMenu extends Screen
	{
		private var _header:Header;
		
		private var _btnFBLogin:Button;
		
		private var _lblHello:Label;
		
		public function screenMenu() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_header = new Header();
			_header.title = "yrdcAneTestBed";
			addChild(_header);
			
			// if facebook is supported
			if (Facebook.isSupported) {
				// if we don't have a session open already
				if (Facebook.getInstance().isSessionOpen) {
					Facebook.getInstance().requestWithGraphPath("/me", { "fields":"name" }, "GET", fbGraphCallback);
				} else {
					createFBLoginButton();
				}
			}
			
		}
		
		private function createFBLoginButton():void {
			_btnFBLogin = new Button();
			_btnFBLogin.label = "Login with Facebook";
			_btnFBLogin.addEventListener(Event.TRIGGERED, btnFBLogin_triggered);
			addChild(_btnFBLogin);
		}
		
		private function btnFBLogin_triggered(e:Event):void {
			// if you login with facebook, you have access to all public data for the user, like name, about etc
			Facebook.getInstance().openSessionWithReadPermissions([], fbSessionOpen);
		}
		
		// Callback for openSessionWithReadPermissions
		private function fbSessionOpen(success:Boolean, userCancelled:Boolean, error:String = null):void {
			if (success) {
				Facebook.getInstance().requestWithGraphPath("/me", { "fields":"name" }, "GET", fbGraphCallback);
			} else {
				if (userCancelled) {
					Resources.MsgBox("you cancelled - "+ error);
				} else {
					Resources.MsgBox("something went wrong - "+ error);
				}
			}
		}
		
		// we get a parsed data object
		private function fbGraphCallback(data:Object):void {
			_lblHello = new Label();
			_lblHello.text = "Hello " + data.name;
			addChild(_lblHello);
			
			_lblHello.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			_lblHello.width = actualWidth * 0.3;
			_lblHello.x = (actualWidth / 2) - (_lblHello.width / 2);
			_lblHello.y = _header.height + 10;
			
			var btnClearData:Button = new Button();
			btnClearData.label = "Logout";
			btnClearData.addEventListener(Event.TRIGGERED, function(e:Event):void {
				// clear all data
				Facebook.getInstance().closeSessionAndClearTokenInformation();
				Button(e.target).isEnabled = false;
			});
			addChild(btnClearData);
			btnClearData.width = actualWidth * 0.3;
			btnClearData.x = (actualWidth / 2) - (btnClearData.width / 2);
			btnClearData.y = _lblHello.height + 10;
			
			if(_btnFBLogin != null) {
				_btnFBLogin.visible = false;
			}
			
			Resources.MsgBox("Hello " + data.name);
		}
		
		override protected function draw():void {
			super.draw();
			
			_header.width = actualWidth;
			
			if (_lblHello != null) {
				_lblHello.width = actualWidth * 0.3;
				_lblHello.x = (actualWidth / 2) - (_lblHello.width / 2);
				_lblHello.y = _header.height + 10;
			}
			
			if (_btnFBLogin != null) {
				_btnFBLogin.width = actualWidth * 0.3;
				_btnFBLogin.x = (actualWidth / 2) - (_btnFBLogin.width / 2);
				_btnFBLogin.y = _header.height + 10;
			}
		}
		
	}
	
}