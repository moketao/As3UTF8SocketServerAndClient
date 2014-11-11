package
{
	import flash.events.DataEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	
	public class As3UTF8SocketServer extends ServerSocket
	{
		public var PORT:int;
		public var IP:String;
		public function As3UTF8SocketServer(onReceiveFunc:Function=null,PORT:int=9999, IP:String="127.0.0.1")
		{
			this.onReceiveFunc = onReceiveFunc;
			this.IP = IP;
			this.PORT = PORT;
			bind(PORT,IP);
			addEventListener(ServerSocketConnectEvent.CONNECT,onConnectME);
			listen();
		}
		
		public static const SPLITER:String = "_$_";

		public var onReceiveFunc:Function;
		protected function onConnectME(e:ServerSocketConnectEvent):void
		{
			if(c){
				alert("发现新连接，关闭旧连接");
				c.close();
			}
			alert("新的客户端信息："+e.socket.remoteAddress+":"+e.socket.remotePort);
			c = new As3UTF8SocketClient(null,IP,PORT,e.socket);
			c.addEventListener(As3UTF8SocketEvent.MESSAGE_RECEIVED,receive);
		}
		protected function receive(e:As3UTF8SocketEvent):void
		{
			if(onReceiveFunc) onReceiveFunc(e.msg);
		}
		protected function alert(str:String):void
		{
			dispatchEvent(new DataEvent(SOCKET_INFO,false,false,str));
		}
		public function send(str:String):void{
			if(c){
				c.send(str);
			}else{
				alert("无法发送信息，等待客户端连接...");
			}
		}
		public static const SOCKET_INFO:String = "SOCKET_INFO";

		private var c:As3UTF8SocketClient;
	}
}