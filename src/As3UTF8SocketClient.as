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
		public function As3UTF8SocketClient(onReceiveFunc:Function=null,ip:String="127.0.0.1",port:int=9999,warpSocket:Socket=null)
		{
			super();
			PORT = port;
			IP = ip;
			this.onReceiveFunc = onReceiveFunc;
			this.msg = "";
			s = warpSocket ? warpSocket  : new Socket();
			
			s.addEventListener(Event.CONNECT,onConn);
			s.addEventListener(Event.CLOSE,remoteClose);
			s.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			s.addEventListener(IOErrorEvent.IO_ERROR,err);
			s.addEventListener(SecurityErrorEvent.SECURITY_ERROR,err);
			
			if(!warpSocket){
				connect(ip,port);
			}
		}
		public function connect(ip:String,port:int):void
		{
			PORT = port;
			IP = ip;
			if(s==null) s=new Socket();
			try{
				s.connect(ip,port);
			}catch(e:Error){
				alert(e.message);
			}
		}
		protected function alert(str:String):void
		{
			dispatchEvent(new DataEvent(SOCKET_INFO,false,false,str));
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
					if(onReceiveFunc)onReceiveFunc(msg);
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
		public static const SOCKET_INFO:String = "SOCKET_INFO";
		private var msg:String;

		private var onReceiveFunc:Function;
	}
}