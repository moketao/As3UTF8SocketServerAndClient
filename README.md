As3UTF8SocketServerAndClient
============================

AS3实现的简易Socket服务器和客户端，已经考虑到粘包的问题。

特性：
------------
目前只实现一对一的情况。
适用于某些测试场合，比如：本地调试，局域网一对一调试，台式机与手机通过wifi通讯等等。


服务端使用方法：
------------
<code><pre>
server = new As3UTF8SocketServer(9999,"127.0.0.1",function(msg:String):void{
		trace(msg);//收到
		server.send("Welcome");//发送
});</pre></code>


客户端使用方法：
------------
<code><pre>
s = new As3UTF8SocketClient();
s.connect("127.0.0.1",9999);
s.send("hello");//发送
</pre></code>
