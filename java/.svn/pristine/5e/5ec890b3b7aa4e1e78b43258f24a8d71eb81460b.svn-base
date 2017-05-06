package com.yilidi.o2o.core.utils;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

/**
 * 二维码工具类
 * 
 * @author: chenb
 * @date: 2016年12月16日 下午2:49:09
 */
public final class QRCodeUtil {

    private static Logger logger = Logger.getLogger(QRCodeUtil.class);
    private static final int BLACK = 0xFF000000;
    private static final int WHITE = 0xFFFFFFFF;
    private static final String QRCODE_DEFAULT_CHARSET = "UTF-8";
    private static final String FORMAT = "png";
    // 二维码默认高度
    private static final int QRCODE_DEFAULT_HEIGHT = 300;
    // 二维码默认宽度
    private static final int QRCODE_DEFAULT_WIDTH = 300;

    private QRCodeUtil() {
    }

    private static BufferedImage toBufferedImage(BitMatrix matrix) {
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);
            }
        }
        return image;
    }

    private static void writeToFile(BitMatrix matrix, String format, File file) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        if (!ImageIO.write(image, format, file)) {
            throw new IOException("Could not write an image of format " + format + " to " + file);
        }
    }

    private static void writeToFile(BufferedImage image, String format, File file) throws IOException {
        if (!ImageIO.write(image, format, file)) {
            throw new IOException("Could not write an image of format " + format + " to " + file);
        }
    }

    private static void writeToStream(BitMatrix matrix, String format, OutputStream stream) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        if (!ImageIO.write(image, format, stream)) {
            throw new IOException("Could not write an image of format " + format);
        }
    }

    /**
     * 生成二维码图片
     * 
     * @param data
     *            要生成二维码文字
     * @param width
     *            二维码宽度
     * @param height
     *            二维码高度
     * @param fileFullPath
     *            文件完整路径地址
     * @return
     */
    public static void generateQRCodeImage(String data, int width, int height, String fileFullPath) {
        if (ObjectUtils.isNullOrEmpty(fileFullPath)) {
            throw new IllegalStateException("文件不能为空");
        }
        try {
            File destFile = new File(fileFullPath);
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            BufferedImage bufferedImage = createQRCode(data, width, height);
            // 生成二维码
            File outFile = new File(fileFullPath);
            writeToFile(bufferedImage, FORMAT, outFile);
        } catch (Exception e) {
            logger.error("生成二维码发生异常", e);
        }
    }

    /**
     * 生成默认宽高二维码图片
     * 
     * @param data
     *            要生成二维码文字
     * @param fileFullPath
     *            文件完整路径地址
     * @return
     */
    public static void generateQRCodeImage(String data, String fileFullPath) {
        generateQRCodeImage(data, QRCODE_DEFAULT_WIDTH, QRCODE_DEFAULT_HEIGHT, fileFullPath);
    }

    /**
     * 生成含有Logo的二维码
     * 
     * @param data
     *            二维码文字
     * @param width
     *            宽度
     * @param height
     *            高度
     * @param logoFilePath
     *            logo绝对路径
     * @param fileFullPath
     *            二维码存储绝对路径
     */
    public static void createQRCodeWithLogo(String data, int width, int height, String logoFilePath, String fileFullPath) {
        if (ObjectUtils.isNullOrEmpty(logoFilePath)) {
            generateQRCodeImage(data, width, height, fileFullPath);
            return;
        }
        try {
            File logoFile = new File(logoFilePath);
            BufferedImage bufferedImage = createQRCodeWithLogo(data, width, height, logoFile);
            File destFile = new File(fileFullPath);
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            // 生成二维码
            File outFile = new File(fileFullPath);
            writeToFile(bufferedImage, FORMAT, outFile);
        } catch (Exception e) {
            logger.error("生成二维码发生异常", e);
        }
    }

    /**
     * 读取二维码内容
     * 
     * @param absolutePath
     *            二维码图片绝对路径
     * @return 内容字符串
     */
    public static String readTextFromQRCode(String absolutePath) {
        File readFile = new File(absolutePath);
        if (!readFile.isFile()) {
            throw new IllegalStateException("不是有效的文件");
        }
        BufferedImage image = null;
        Result result = null;
        try {
            image = ImageIO.read(readFile);
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));

            Map<DecodeHintType, Object> hints = new Hashtable<DecodeHintType, Object>();
            // 注意要使用 utf-8，因为刚才生成二维码时，使用了utf-8
            hints.put(DecodeHintType.CHARACTER_SET, QRCODE_DEFAULT_CHARSET);
            result = new MultiFormatReader().decode(bitmap, hints);
            return result.getText();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return "";
    }

    /**
     * 默认的配置生成二维码
     * 
     * @param data
     *            二维码内容
     * @return BufferedImage
     */
    public static BufferedImage createQRCode(String data) {
        return createQRCode(data, QRCODE_DEFAULT_WIDTH, QRCODE_DEFAULT_HEIGHT);
    }

    /**
     * 指定宽高生成二维码
     *
     * @param data
     *            二维码内容
     * @param width
     *            二维码宽度
     * @param height
     *            二维码高度
     * @return BufferedImage
     */
    public static BufferedImage createQRCode(String data, int width, int height) {
        return createQRCode(data, QRCODE_DEFAULT_CHARSET, width, height);
    }

    /**
     * 指定宽高和字符集生成二维码
     *
     * @param data
     *            文字内容
     * @param charset
     *            字符集
     * @param width
     *            宽度
     * @param height
     *            高度
     * @return BufferedImage
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static BufferedImage createQRCode(String data, String charset, int width, int height) {
        Map hint = new HashMap();
        hint.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hint.put(EncodeHintType.CHARACTER_SET, charset);
        return createQRCode(data, charset, hint, width, height);
    }

    /**
     * 根据设置生成二维码
     *
     * @param data
     *            文字内容
     * @param charset
     *            字符集
     * @param hint
     *            Map<EncodeHintType, ?>
     * @param width
     *            宽度
     * @param height
     *            高度
     * @return BufferedImage
     */
    public static BufferedImage createQRCode(String data, String charset, Map<EncodeHintType, ?> hint, int width,
            int height) {
        BitMatrix matrix;
        try {
            matrix = new MultiFormatWriter().encode(new String(data.getBytes(charset), charset), BarcodeFormat.QR_CODE,
                    width, height, hint);
            return toBufferedImage(matrix);
        } catch (WriterException e) {
            throw new RuntimeException(e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }

    /**
     * 根据默认设置生成有logo的二维码
     *
     * @param data
     *            二维码文字
     * @param logoFile
     *            logo文件
     * @return BufferedImage
     */
    public static BufferedImage createQRCodeWithLogo(String data, File logoFile) {
        return createQRCodeWithLogo(data, QRCODE_DEFAULT_WIDTH, QRCODE_DEFAULT_HEIGHT, logoFile);
    }

    /**
     * 根据宽高生成logo的二维码
     *
     * @param data
     *            二维文字
     * @param width
     *            宽度
     * @param height
     *            高度
     * @param logoFile
     *            logo文件
     * @return BufferedImage
     */
    public static BufferedImage createQRCodeWithLogo(String data, int width, int height, File logoFile) {
        return createQRCodeWithLogo(data, QRCODE_DEFAULT_CHARSET, width, height, logoFile);
    }

    /**
     * 根据宽高和字符集生成二维码
     *
     * @param data
     *            二维码文字
     * @param charset
     *            字符集
     * @param width
     *            宽度
     * @param height
     *            高度
     * @param logoFile
     *            logo文件
     * @return BufferedImage
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static BufferedImage createQRCodeWithLogo(String data, String charset, int width, int height, File logoFile) {
        Map hint = new HashMap();
        hint.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hint.put(EncodeHintType.CHARACTER_SET, charset);
        hint.put(EncodeHintType.MARGIN, 0);
        return createQRCodeWithLogo(data, charset, hint, width, height, logoFile);
    }

    /**
     * 指定设置生成二维码
     *
     * @param data
     *            二维码文字
     * @param charset
     *            字符集
     * @param hint
     *            Map<EncodeHintType, ?>
     * @param width
     *            宽度
     * @param height
     *            高度
     * @param logoFile
     *            logo文件
     * @return BufferedImage
     */
    public static BufferedImage createQRCodeWithLogo(String data, String charset, Map<EncodeHintType, ?> hint, int width,
            int height, File logoFile) {
        try {
            BufferedImage qrcode = createQRCode(data, charset, hint, width, height);
            BufferedImage logo = ImageIO.read(logoFile);
            int deltaHeight = height - logo.getHeight();
            int deltaWidth = width - logo.getWidth();

            BufferedImage combined = new BufferedImage(height, width, BufferedImage.TYPE_INT_ARGB);
            Graphics2D g = (Graphics2D) combined.getGraphics();
            g.drawImage(qrcode, 0, 0, null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 1f));
            g.drawImage(logo, (int) Math.round(deltaWidth / 2), (int) Math.round(deltaHeight / 2), null);
            return combined;
        } catch (IOException e) {
            throw new RuntimeException(e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
}
