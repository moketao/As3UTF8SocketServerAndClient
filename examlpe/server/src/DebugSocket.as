package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class DebugSocket extends Sprite
	{

		private var server:As3UTF8SocketServer;
		public function DebugSocket()
		{
			var txt:TextField = new TextField();
			txt.width = 999;
			txt.height = 999;
			addChild(txt);
			server = new As3UTF8SocketServer(9999,"127.0.0.1",function(msg:String):void{
				txt.text = ("收到客户端信息："+msg);
			});
		}
	}
}