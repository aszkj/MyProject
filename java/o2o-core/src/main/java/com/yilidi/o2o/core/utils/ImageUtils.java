package com.yilidi.o2o.core.utils;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifDirectory;
import com.yilidi.o2o.core.exception.ProductServiceException;

/**
 * 功能描述：图片处理工具类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class ImageUtils {
    private static Logger logger = Logger.getLogger(ImageUtils.class);
    /** gif图片格式 **/
    public static final String IMAGE_TYPE_GIF = "gif";
    /** jpg图片格式 **/
    public static final String IMAGE_TYPE_JPG = "jpg";
    /** jpeg图片格式 **/
    public static final String IMAGE_TYPE_JPEG = "jpeg";
    
    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";

    private ImageUtils() {
    }

    /**
     * 给图片添加文字水印
     * 
     * @param pressText
     *            水印文字
     * @param srcImageFile
     *            源图像地址
     * @param destImageFile
     *            目标图像地址
     * @param fontName
     *            水印的字体名称
     * @param fontStyle
     *            水印的字体样式
     * @param color
     *            水印的字体颜色
     * @param fontSize
     *            水印的字体大小
     * @param x
     *            修正值
     * @param y
     *            修正值
     * @param alpha
     *            透明度：alpha 必须是范围 [0.0, 1.0] 之内（包含边界值）的一个浮点数字
     */
    public static void pressText(String pressText, String srcImageFile, String destImageFile, String fontName, int fontStyle,
            Color color, int fontSize, int x, int y, float alpha) {
        try {
            File srcFile = new File(srcImageFile);
            Image srcImageObj = ImageIO.read(srcFile);
            int width = srcImageObj.getWidth(null);
            int height = srcImageObj.getHeight(null);
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(srcImageObj, 0, 0, width, height, null);
            g.setColor(color);
            g.setFont(new Font(fontName, fontStyle, fontSize));
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
            FontMetrics metrics = g.getFontMetrics();
            // 在指定坐标绘制水印文字
            g.drawString(pressText, (width - metrics.stringWidth(pressText)) / 2 + x,
                    (height - metrics.getHeight()) / 2 + y);
            g.dispose();
            ImageIO.write((BufferedImage) image, IMAGE_TYPE_JPEG, new File(destImageFile));
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 指定垂直距离,水平居中给图片添加文字水印
     * 
     * @param pressText
     *            水印文字
     * @param srcImageFile
     *            源图像地址
     * @param destImageFile
     *            目标图像地址
     * @param fontName
     *            水印的字体名称
     * @param fontStyle
     *            水印的字体样式
     * @param color
     *            水印的字体颜色
     * @param fontSize
     *            水印的字体大小
     * @param y
     *            垂直距离
     * @param alpha
     *            透明度：alpha 必须是范围 [0.0, 1.0] 之内（包含边界值）的一个浮点数字
     */
    public static void pressText(String pressText, String srcImageFile, String destImageFile, String fontName, int fontStyle,
            Color color, int fontSize, int y, float alpha) {
        try {
            File srcFile = new File(srcImageFile);
            Image srcImageObj = ImageIO.read(srcFile);
            int width = srcImageObj.getWidth(null);
            int height = srcImageObj.getHeight(null);
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(srcImageObj, 0, 0, width, height, null);
            g.setColor(color);
            Font font = new Font(fontName, fontStyle, fontSize);
            g.setFont(font);
            FontMetrics metrics = g.getFontMetrics();
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
            // 在指定坐标绘制水印文字
            g.drawString(pressText, (width - metrics.stringWidth(pressText)) / 2, y + metrics.getHeight() / 2f);
            g.dispose();
            ImageIO.write((BufferedImage) image, IMAGE_TYPE_JPEG, new File(destImageFile));
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 给图片添加图片水印
     * 
     * @param pressImg
     *            水印图片
     * @param srcImageFile
     *            源图像地址
     * @param destImageFile
     *            目标图像地址
     * @param x
     *            修正值
     * @param y
     *            修正值
     * @param alpha
     *            透明度：alpha 必须是范围 [0.0, 1.0] 之内（包含边界值）的一个浮点数字
     */
    public static void pressImageByCoordinate(String pressImg, String srcImageFile, String destImageFile, int x, int y,
            float alpha) {
        try {
            File srcImageFileObj = new File(srcImageFile);
            Image srcImageObj = ImageIO.read(srcImageFileObj);
            int srcImageWidth = srcImageObj.getWidth(null);
            int srcImageHeight = srcImageObj.getHeight(null);
            BufferedImage image = new BufferedImage(srcImageWidth, srcImageHeight, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(srcImageObj, 0, 0, srcImageWidth, srcImageHeight, null);
            // 水印文件
            Image pressImageObj = ImageIO.read(new File(pressImg));
            int pressImageWidth = pressImageObj.getWidth(null);
            int pressImageHeight = pressImageObj.getHeight(null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
            g.drawImage(pressImageObj, (srcImageWidth - pressImageWidth) / 2 + x,
                    (srcImageHeight - pressImageHeight) / 2 + y, pressImageWidth, pressImageHeight, null);
            // 水印文件结束
            g.dispose();
            ImageIO.write((BufferedImage) image, IMAGE_TYPE_JPEG, new File(destImageFile));
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 指定垂直距离,水平居中给图片添加图片水印
     * 
     * @param pressImg
     *            水印图片
     * @param srcImageFile
     *            源图像地址
     * @param destImageFile
     *            目标图像地址
     * @param y
     *            指定垂直距离高度
     * @param alpha
     *            透明度：alpha 必须是范围 [0.0, 1.0] 之内（包含边界值）的一个浮点数字
     */
    public static void pressImage(String pressImg, String srcImageFile, String destImageFile, int y, float alpha) {
        try {
            File srcImageFileObj = new File(srcImageFile);
            Image srcImageObj = ImageIO.read(srcImageFileObj);
            int srcImageWidth = srcImageObj.getWidth(null);
            int srcImageHeight = srcImageObj.getHeight(null);
            BufferedImage image = new BufferedImage(srcImageWidth, srcImageHeight, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(srcImageObj, 0, 0, srcImageWidth, srcImageHeight, null);
            // 水印文件
            Image srcImage = ImageIO.read(new File(pressImg));
            int pressImageWidth = srcImage.getWidth(null);
            int pressImageHeight = srcImage.getHeight(null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
            g.drawImage(srcImage, (srcImageWidth - pressImageWidth) / 2, y, pressImageWidth, pressImageHeight, null);
            // 水印文件结束
            g.dispose();
            ImageIO.write((BufferedImage) image, IMAGE_TYPE_JPEG, new File(destImageFile));
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 缩放图像（按高度和宽度缩放）
     * 
     * @param srcImagePath
     *            源图像文件地址
     * @param destFilePath
     *            缩放后的图像地址
     * @param height
     *            缩放后的高度
     * @param width
     *            缩放后的宽度
     * @param filter
     *            比例不对时是否需要补白：true为补白; false为不补白;
     */
    public static void scaleImageByWidthAndHeight(String srcImagePath, String destFilePath, int height, int width,
            boolean filter) {
        try {
            double ratio = 0.0D; // 缩放比例
            File srcImageFile = new File(srcImagePath);
            BufferedImage bfImageObj = ImageIO.read(srcImageFile);
            if (bfImageObj.getWidth() <= width) {
                width = bfImageObj.getWidth();
                height = bfImageObj.getHeight();
            }
            Image srcImageObj = bfImageObj.getScaledInstance(width, height, BufferedImage.SCALE_SMOOTH);
            // 计算比例
            if ((bfImageObj.getHeight() > height) || (bfImageObj.getWidth() > width)) {
                if (bfImageObj.getHeight() > bfImageObj.getWidth()) {
                    ratio = (new Integer(height)).doubleValue() / bfImageObj.getHeight();
                } else {
                    ratio = (new Integer(width)).doubleValue() / bfImageObj.getWidth();
                }
                AffineTransformOp op = new AffineTransformOp(AffineTransform.getScaleInstance(ratio, ratio), null);
                srcImageObj = op.filter(bfImageObj, null);
            }
            if (filter) {
                BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = image.createGraphics();
                g.setColor(Color.white);
                g.fillRect(0, 0, width, height);
                if (width == srcImageObj.getWidth(null)) {
                    g.drawImage(srcImageObj, 0, (height - srcImageObj.getHeight(null)) / 2, srcImageObj.getWidth(null),
                            srcImageObj.getHeight(null), Color.white, null);
                } else {
                    g.drawImage(srcImageObj, (width - srcImageObj.getWidth(null)) / 2, 0, srcImageObj.getWidth(null),
                            srcImageObj.getHeight(null), Color.white, null);
                }
                g.dispose();
                srcImageObj = image;
            }
            ImageIO.write((BufferedImage) srcImageObj, IMAGE_TYPE_JPEG, new File(destFilePath));
        } catch (IOException e) {
            logger.error(e, e);
        }
    }

    /**
     * 缩放图像（按比例缩放）
     * 
     * @param srcImagePath
     *            源图像文件地址
     * @param destImagePath
     *            缩放后的图像地址
     * @param maxWidth
     *            最大宽度
     * @param maxHeight
     *            最大高度
     * @param scale
     *            缩放比例
     */
    public static void scale(String srcImagePath, String destImagePath, int maxWidth, int maxHeight, double scale) {
        File srcFile = new File(srcImagePath);
        File destFile = new File(destImagePath);
        scale(srcFile, destFile, maxWidth, maxHeight, scale);
    }

    /**
     * 缩放图像（按比例缩放）
     * 
     * @param srcImageFile
     *            源图像文件
     * @param destImageFile
     *            缩放后的图像
     * @param maxWidth
     *            最大宽度
     * @param maxHeight
     *            最大高度
     * @param scale
     *            缩放比例
     */
    public static void scale(File srcImageFile, File destImageFile, int maxWidth, int maxHeight, double scale) {
        try {
            BufferedImage src = ImageIO.read(srcImageFile); // 读入文件
            int width = src.getWidth(); // 得到源图宽
            int height = src.getHeight(); // 得到源图长
            int destWidth = (int) (width * scale);
            int destHeight = (int) (height * scale);
            if (destWidth > maxWidth) {
                double scale1 = (double) maxWidth / destWidth;
                destWidth = maxWidth;
                destHeight = (int) (destHeight * scale1);
            }
            Image image = src.getScaledInstance(destWidth, destHeight, Image.SCALE_DEFAULT);
            BufferedImage tag = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
            Graphics g = tag.getGraphics();
            g.drawImage(image, 0, 0, null); // 绘制缩小后的图
            g.dispose();
            ImageIO.write(tag, IMAGE_TYPE_JPEG, destImageFile); // 输出到文件流
        } catch (IOException e) {
            logger.error(e, e);
        }
    }

    /**
     * 图片翻转时，计算图片翻转到正常显示需旋转角度
     * 
     * @param imageFullPath
     *            图片绝对路径
     * @return 图片旋转角度
     */
    public static int getRotateAngleForImage(String imageFullPath) {
        int angel = 0;
        try {
            File srcImage = new File(imageFullPath);
            angel = getRotateAngleForImage(srcImage);
        } catch (Exception e) {
            logger.error(e, e);
        }
        logger.info("图片旋转角度：" + angel);
        return angel;
    }

    /**
     * 图片翻转时，计算图片翻转到正常显示需旋转角度
     * 
     * @param srcFile
     *            文件
     * @return 图片旋转角度
     */
    public static int getRotateAngleForImage(File srcFile) {
        int angel = 0;
        Metadata metadata;
        try {
            metadata = JpegMetadataReader.readMetadata(srcFile);
            Directory directory = metadata.getDirectory(ExifDirectory.class);
            if (directory.containsTag(ExifDirectory.TAG_ORIENTATION)) {
                // Exif信息中方向
                int orientation = directory.getInt(ExifDirectory.TAG_ORIENTATION);
                // 原图片的方向信息
                if (6 == orientation) {
                    // 6旋转90
                    angel = 90;
                } else if (3 == orientation) {
                    // 3旋转180
                    angel = 180;
                } else if (8 == orientation) {
                    // 8旋转90
                    angel = 270;
                }
            }
        } catch (JpegProcessingException e) {
            logger.error(e, e);
        } catch (MetadataException e) {
            logger.error(e, e);
        }
        logger.info("图片旋转角度：" + angel);
        return angel;
    }

    /**
     * 纠正图片角度
     * 
     * @param srcImgaeFullPath
     */
    public static void rotateImage(String srcImgaeFullPath, String destImgaeFullPath) {
        try {
            if (ObjectUtils.isNullOrEmpty(srcImgaeFullPath)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(destImgaeFullPath)) {
                destImgaeFullPath = srcImgaeFullPath;
            }
            File imageFile = new File(srcImgaeFullPath);
            if (!imageFile.exists()) {
                return;
            }
            File destFile = new File(destImgaeFullPath);
            rotateImage(imageFile, destFile);
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 纠正图片角度
     * 
     * @param srcFile
     *            源文件对象
     * @param destFile
     *            转换后文件
     */
    public static void rotateImage(File srcFile, File destFile) {
        try {
            if (destFile == null || destFile.isDirectory()) {
                return;
            }
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            int angel = getRotateAngleForImage(srcFile);
            if (angel == 0) {
                return;
            }
            BufferedImage src = ImageIO.read(srcFile);
            if (null == src) {
                logger.info("buffered image is null");
                return;
            }
            BufferedImage tag = null;
            // 图片被翻转，调整图片
            int srcWidth = src.getWidth(null);
            int srcHeight = src.getHeight(null);
            Rectangle rectDes = calcRotatedSize(new Rectangle(new Dimension(srcWidth, srcHeight)), angel);
            tag = new BufferedImage(rectDes.width, rectDes.height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2 = tag.createGraphics();
            g2.translate((rectDes.width - srcWidth) / 2, (rectDes.height - srcHeight) / 2);
            g2.rotate(Math.toRadians(angel), srcWidth / 2, srcHeight / 2);
            g2.drawImage(src, null, null);
            g2.dispose();
            ImageIO.write(tag, IMAGE_TYPE_JPEG, destFile); // 输出到文件流
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 计算旋转参数
     */
    private static Rectangle calcRotatedSize(Rectangle src, int angel) {
        // if angel is greater than 90 degree,we need to do some conversion.
        if (angel > 90) {
            if (angel / 9 % 2 == 1) {
                int temp = src.height;
                src.height = src.width;
                src.width = temp;
            }
            angel = angel % 90;
        }
        double r = Math.sqrt(src.height * src.height + src.width * src.width) / 2;
        double len = 2 * Math.sin(Math.toRadians(angel) / 2) * r;
        double angelAlpha = (Math.PI - Math.toRadians(angel)) / 2;
        double angelDaltaWidth = Math.atan((double) src.height / src.width);
        double angelDaltaHeight = Math.atan((double) src.width / src.height);

        int lenDaltaWidth = (int) (len * Math.cos(Math.PI - angelAlpha - angelDaltaWidth));
        int lenDaltaHeight = (int) (len * Math.cos(Math.PI - angelAlpha - angelDaltaHeight));
        int desWidth = src.width + lenDaltaWidth * 2;
        int desHeight = src.height + lenDaltaHeight * 2;
        return new java.awt.Rectangle(new Dimension(desWidth, desHeight));
    }
    
    public static void operateImage(String imageFlag, String delImageUrl, String classImageUrl)
			throws ProductServiceException {
		try {
			FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
			if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
				fileUploadUtils.uploadPublishFile(classImageUrl);
			}
			if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
				fileUploadUtils.deletePublishFile(delImageUrl);
			}
		} catch (ProductServiceException e) {
			logger.error("operateImage异常", e);
			throw new ProductServiceException(e.getMessage());
		}
	}
    
}