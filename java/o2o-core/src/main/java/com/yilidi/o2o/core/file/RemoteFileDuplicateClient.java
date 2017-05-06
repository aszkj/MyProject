package com.yilidi.o2o.core.file;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.DefaultFileRegion;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.FileRegion;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.DelimiterBasedFrameDecoder;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;
import io.netty.handler.timeout.IdleStateEvent;
import io.netty.handler.timeout.IdleStateHandler;

import java.io.File;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

/**
 * 
 * @Description:TODO(远程文件复制客户端)
 * @author: chenlian
 * @date: 2015年11月19日 下午3:19:34
 * 
 */
public class RemoteFileDuplicateClient {

    private Logger logger = Logger.getLogger(RemoteFileDuplicateClient.class.getName());

    private final String host;

    private final int port;

    private final String localFilePath;

    private final String remoteFilePath;

    private static final String SUCCESS_TIPS = "文件远程复制成功";

    private static final String DELIMITER = "$_$_@_@_$_$!@#$%^&*()";

    public RemoteFileDuplicateClient(String host, int port, String localFilePath, String remoteFilePath) {
        this.host = host;
        this.port = port;
        this.localFilePath = localFilePath;
        this.remoteFilePath = remoteFilePath;
    }

    public void run() throws Exception {
        // 创建负责处理网络I/O读写的Reactor线程组
        EventLoopGroup group = new NioEventLoopGroup();
        try {
            Bootstrap b = new Bootstrap();
            b.group(group).channel(NioSocketChannel.class).option(ChannelOption.TCP_NODELAY, true)
                    .option(ChannelOption.SO_SNDBUF, 20 * 1024 * 1024).handler(new LoggingHandler(LogLevel.INFO))
                    .handler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        public void initChannel(SocketChannel ch) throws Exception {
                            ByteBuf buf = Unpooled.copiedBuffer(DELIMITER.getBytes());
                            // 加入分隔符解码器来解决TCP的拆包与粘包问题
                            // 加入“Ping-Pong”心跳机制，检查客户端与服务端的TCP链路是否正常可用
                            ch.pipeline().addLast(new DelimiterBasedFrameDecoder(10 * 1024 * 1024, buf))
                                    .addLast(new IdleStateHandler(20, 10, 0)).addLast(new HeartBeatHandler())
                                    .addLast(new FileDuplicateHandler());
                        }
                    });
            ChannelFuture f = b.connect(host, port).sync();
            logger.info("已经连接远程文件复制服务端");
            f.channel().closeFuture().sync();
        } finally {
            // 优雅关闭，释放线程池资源
            group.shutdownGracefully();
        }
    }

    private class HeartBeatHandler extends ChannelInboundHandlerAdapter {

        @Override
        public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentTime = sdf.format(date);
            if (evt instanceof IdleStateEvent) {
                IdleStateEvent event = (IdleStateEvent) evt;
                if (event.state().equals(IdleStateEvent.WRITER_IDLE_STATE_EVENT.state())) {
                    // 在规定时间内，Channel中没有写事件发生，则客户端发送Ping心跳信息给服务端，因为该场景为短连接，因此一般来说Channel走到心跳这一步之前就已经关闭了。
                    logger.info(currentTime + " ：发送心跳Ping信息到远程文件复制服务端 ");
                    ctx.write(Unpooled.copiedBuffer("Ping".getBytes()));
                    ctx.writeAndFlush(Unpooled.copiedBuffer(DELIMITER.getBytes()));
                }
                if (event.state().equals(IdleStateEvent.READER_IDLE_STATE_EVENT.state())) {
                    // 正常情况下，客户端发送Ping心跳信息给服务端，服务端在收到Ping信息后，会立刻发送Pong应答信息给客户端，因此，在规定时间内，客户端若没有接收到服务端的应答信息，则关闭Channel，释放线程池资源。
                    throw new IllegalStateException("与远程文件复制服务端连接超时.....");
                }
            }
        }

        @Override
        public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
            logger.error("远程文件复制客户端出现系统异常", cause);
            ctx.close();
            throw new IllegalStateException("远程文件复制客户端出现系统异常", cause);
        }

    }

    private class FileDuplicateHandler extends ChannelInboundHandlerAdapter {

        @Override
        public void channelActive(ChannelHandlerContext ctx) throws Exception {
            logger.info("==========================================================> 发送本地文件信息到远程文件复制服务端 .....");
            ctx.write(Unpooled.copiedBuffer(remoteFilePath.getBytes()));
            ctx.write(Unpooled.copiedBuffer("#".getBytes()));
            RandomAccessFile raf = new RandomAccessFile(localFilePath, "r");
            FileRegion region = new DefaultFileRegion(raf.getChannel(), 0, raf.length());
            // 将FileRegion写入Channel，底层会利用FileChannel的transferTo方法来实现快速的文件拷贝
            ctx.write(region);
            ctx.writeAndFlush(Unpooled.copiedBuffer(DELIMITER.getBytes()));
            raf.close();
        }

        @Override
        public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
            ByteBuf buf = (ByteBuf) msg;
            byte[] messageFromServerByteArray = new byte[buf.readableBytes()];
            buf.readBytes(messageFromServerByteArray);
            String messageFromServer = new String(messageFromServerByteArray);
            if ("Pong".equals(messageFromServer)) {
                Date date = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(date);
                logger.info(currentTime + " ：接收到远程文件复制服务端的心跳应答Pong信息 ");
            } else {
                logger.info("==========================================================> " + messageFromServer);
                // 对于这种远程文件复制场景，其实是不需要保持客户端与服务端的长连接的，因其操作不会太频繁，每次需要远程复制时，进行一次短连接，处理完毕后关闭链路即可。
                // 成功远程复制后，需将本地服务器中的文件删除
                if (SUCCESS_TIPS.equals(messageFromServer)) {
                    File file = new File(localFilePath);
                    if (file.exists()) {
                        file.delete();
                    }
                    ctx.close();
                } else {
                    throw new IllegalStateException(messageFromServer);
                }
            }
        }

        @Override
        public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
            logger.error("系统出现异常", cause);
            ctx.close();
            throw new IllegalStateException(cause.getMessage());
        }

    }

}
