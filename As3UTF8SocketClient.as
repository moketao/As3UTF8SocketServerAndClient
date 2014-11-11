package
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	public class As3UTF8SocketClient extends EventDispatcher
	{
		public var PORT:int;
		public var IP:String;
		public function As3UTF8SocketClient(warpSocket:Socket=null)
		{
			super();
			this.msg = "";
			s = warpSocket ? warpSocket  : new Socket();
			
			s.addEventListener(Event.CONNECT,onConn);
			s.addEventListener(Event.CLOSE,remoteClose);
			s.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			s.addEventListener(IOErrorEvent.IO_ERROR,err);
			s.addEventListener(SecurityErrorEvent.SECURITY_ERROR,err);
		}
		public function connect(ip:String,port:int):void
		{
			PORT = port;
			IP = ip;
			try{
				s.connect(ip,port);
			}catch(e:Error){
				alert(e.message);
			}
		}
		protected function alert(str:String):void
		{
			dispatchEvent(new DataEvent(SOCKET_ALERT,false,false,str));
		}
		protected function err(e:IOErrorEvent):void
		{
			alert(e.toString());
		}
		
		protected function remoteClose(e:Event):void
		{
			alert(e.toString());
		}
		
		protected function onConn(e:Event):void
		{
			alert(e.toString());
		}
		protected function socketData(e:ProgressEvent):void
		{
			var tmp:String = s.readUTFBytes(s.bytesAvailable);
			var parts:Array = tmp.split(SPLITER);
			for (var i:int = 0; i < parts.length; i++) 
			{
				if(i < parts.length-1){
					msg += parts[i];
					this.dispatchEvent(new As3UTF8SocketEvent(As3UTF8SocketEvent.MESSAGE_RECEIVED,msg));
					this.msg = ""; 
				}else{
					msg += parts[i];
				}
			}
		}
		public function send(str:String):void{
			if(s && s.connected){
				s.writeUTFBytes(str+SPLITER);
				s.flush();
			}else{
				alert("连接已关闭，不能发送信息");
			}
		}
		public function close():void{
			if(s && s.connected){
				s.close();
				s = null;
				alert("主动关闭连接");
			}
		}
		public static var SPLITER:String = "_$_";
		private var _message:String;
		private var s:Socket;
		public static const SOCKET_ALERT:String = "SOCKET_ALERT";
		private var msg:String;
	}
}