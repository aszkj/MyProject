package com.yilidi.o2o.file;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.codec.DelimiterBasedFrameDecoder;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;

import java.io.File;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

/**
 * 
 * @Description:TODO(远程文件复制服务端)
 * @author: chenlian
 * @date: 2015年11月19日 下午3:19:14
 * 
 */
public class RemoteFileDuplicateServer {

    private Logger logger = Logger.getLogger(RemoteFileDuplicateServer.class.getName());

    private static final String DELIMITER = "$_$_@_@_$_$!@#$%^&*()";

    private final int port;

    public RemoteFileDuplicateServer(int port) {
        this.port = port;
    }

    public void run() throws Exception {
        // 创建负责客户端接入的Reactor线程组
        EventLoopGroup bossGroup = new NioEventLoopGroup(1);
        // 创建负责处理网络I/O读写的Reactor线程组
        EventLoopGroup workerGroup = new NioEventLoopGroup();
        try {
            ServerBootstrap b = new ServerBootstrap();
            b.group(bossGroup, workerGroup).channel(NioServerSocketChannel.class).option(ChannelOption.SO_BACKLOG, 1000)
                    .option(ChannelOption.SO_RCVBUF, 20 * 1024 * 1024).handler(new LoggingHandler(LogLevel.INFO))
                    .childHandler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        public void initChannel(SocketChannel ch) throws Exception {
                            ByteBuf buf = Unpooled.copiedBuffer(DELIMITER.getBytes());
                            // 加入分隔符解码器来解决TCP的拆包与粘包问题
                            ch.pipeline().addLast(new DelimiterBasedFrameDecoder(10 * 1024 * 1024, buf))
                                    .addLast(new FileDuplicateHandler());
                        }
                    });
            ChannelFuture f = b.bind(port).sync();
            logger.info("远程文件复制服务端已经启动");
            f.channel().closeFuture().sync();
        } finally {
            // 优雅关闭，释放线程池资源
            bossGroup.shutdownGracefully();
            workerGroup.shutdownGracefully();
        }
    }

    private class FileDuplicateHandler extends ChannelInboundHandlerAdapter {

        @Override
        public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
            ByteBuf buf = (ByteBuf) msg;
            if (buf.equals(Unpooled.copiedBuffer("Ping".getBytes()))) {
                Date date = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(date);
                logger.info(currentTime + " ：接收到客户端的心跳Ping信息 ");
                ctx.write(Unpooled.copiedBuffer("Pong".getBytes()));
                ctx.write(Unpooled.copiedBuffer(DELIMITER.getBytes()));
            } else {
                logger.info("==========================================================> 服务端读取到客户端的文件信息，开始复制 .....");
                byte[] remoteFilePathByteArray = new byte[buf.bytesBefore("#".getBytes()[0])];
                buf.readBytes(remoteFilePathByteArray);
                buf.readerIndex(buf.readerIndex() + 1);
                String remoteFilePath = new String(remoteFilePathByteArray);
                logger.info("==========================================================> 远程文件路径 : " + remoteFilePath);
                File file = new File(remoteFilePath);
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                if (file.exists()) {
                    file.delete();
                }
                file.createNewFile();
                RandomAccessFile raf = new RandomAccessFile(file, "rw");
                raf.getChannel().write(buf.nioBuffer());
                raf.close();
                logger.info("==========================================================> 文件复制成功");
                ctx.write(Unpooled.copiedBuffer("文件远程复制成功".getBytes()));
                ctx.write(Unpooled.copiedBuffer(DELIMITER.getBytes()));
            }
        }

        @Override
        public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
            ctx.flush();
        }

        @Override
        public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
            logger.error("系统出现异常", cause);
            ctx.write(Unpooled.copiedBuffer(("文件远程复制出现异常".getBytes())));
            ctx.write(Unpooled.copiedBuffer(DELIMITER.getBytes()));
        }

    }
}
