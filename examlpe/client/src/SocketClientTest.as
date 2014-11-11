package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SocketClientTest extends Sprite
	{

		private var s:As3UTF8SocketClient;
		public function SocketClientTest()
		{
			s = new As3UTF8SocketClient();
			s.connect("127.0.0.1",9999);
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			s.send("hello"+Math.random().toFixed(2));
		}
	}
}