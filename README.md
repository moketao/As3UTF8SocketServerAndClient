As3UTF8SocketServerAndClient
============================

AS3实现的简易Socket服务器和客户端，已经考虑到粘包的问题。

####特性：
1. 服务器只是一对一的接收客户端信息，不实现一对多。
1. 只传输字符串(UTF-8格式)
1. 适用于某些测试场合，比如：本地AIR程序之间的互联，局域网一对一调试，台式机与手机通过wifi通讯等等。


####服务端使用方法：
<pre>
server = new As3UTF8SocketServer("127.0.0.1",9999,function(msgFromClient:String):void{
		trace(msgFromClient);//收到
		server.send("Welcome");//发送
});
</pre>

####客户端使用方法：
<pre>
c = new As3UTF8SocketClient("127.0.0.1",9999,function(msgFromServer:String):void{
	trace(msgFromServer);//收到
});
setTimeout(function():void{
	c.send("hello server");//发送
},1000);
</pre>

