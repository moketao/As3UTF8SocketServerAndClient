package
{
	import flash.events.Event;
	
	public class As3UTF8SocketEvent extends Event
	{
		public static const MESSAGE_RECEIVED:String = "messageReceived";

		public var msg:String;
		public function As3UTF8SocketEvent(type:String,msg:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.msg = msg;
		}
		override public function clone():Event
		{
			return new As3UTF8SocketEvent(type, msg , bubbles, cancelable);
		}
	}
}