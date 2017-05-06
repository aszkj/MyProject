package com.yilidi.o2o.core.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.file.RemoteFileDeleteClient;
import com.yilidi.o2o.core.file.RemoteFileDuplicateClient;

public class FileUploadUtils {

    protected static final Log LOGGER = LogFactory.getLog(FileUploadUtils.class);

    /**
     * 本地服务器存放上传文件的基础路径
     */
    private static String localUploadFileBasePath;

    /**
     * 远程Web服务器Nginx所在节点1的IP地址
     */
    private static String remoteWebServerOneIp;

    /**
     * 远程Web服务器Nginx所在节点1的文件复制监听端口
     */
    private static Integer remoteWebServerOneDuplicatePort;

    /**
     * 远程Web服务器Nginx所在节点1的文件删除监听端口
     */
    private static Integer remoteWebServerOneDeletePort;

    /**
     * 远程Web服务器Nginx存放上传文件的正式基础路径
     */
    private static String remoteUploadFilePublishBasePath;

    /**
     * 上传文件（图片）后缀格式，用|号分割
     */
    private static String uploadFileImagePostfixFormat;

    /**
     * 上传文件（图片）大小的最大值，单位：字节
     */
    private static Long uploadFileImageMaxSize;

    /**
     * 上传文件（Excel）后缀格式，用|号分割
     */
    private static String uploadFileExcelPostfixFormat;

    /**
     * 上传文件（Excel）大小的最大值，单位：字节
     */
    private static Long uploadFileExcelMaxSize;

    /**
     * 上传文件（压缩数据包）后缀格式，用|号分割
     */
    private static String uploadFileCompressedDataPacketPostfixFormat;

    /**
     * 上传文件（压缩数据包）大小的最大值，单位：字节
     */
    private static Long uploadFileCompressedDataPacketMaxSize;

    /**
     * 
     * @Description:TODO(上传文件类型枚举)
     * @author: chenlian
     * @date: 2015年11月21日 上午11:05:50
     * 
     */
    public static enum UploadFileType {

        IMAGE("image"), EXCEL("excel"), COMPRESSEDDATAPACKET("CompressedDataPacket");

        private String type;

        private UploadFileType(String type) {
            this.type = type;
        }

        public String getType() {
            return type;
        }

    }

    /**
     * 初始化上传文件所需的系统参数
     */
    static {
        localUploadFileBasePath = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH);
        if (StringUtils.isEmpty(localUploadFileBasePath)) {
            throw new IllegalStateException(
                    "本地服务器存放上传文件的基础路径LOCAL_UPLOAD_FILE_BASE_PATH在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        remoteWebServerOneIp = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_IP);
        if (StringUtils.isEmpty(remoteWebServerOneIp)) {
            throw new IllegalStateException(
                    "远程Web服务器Nginx所在节点1的IP地址REMOTE_WEB_SERVER_ONE_IP在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        String strRemoteWebServerOneDuplicatePort = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT);
        if (StringUtils.isEmpty(strRemoteWebServerOneDuplicatePort)) {
            throw new IllegalStateException(
                    "远程Web服务器Nginx所在节点1的文件复制监听端口REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        remoteWebServerOneDuplicatePort = new Integer(strRemoteWebServerOneDuplicatePort);
        String strRemoteWebServerOneDeletePort = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_DELETE_PORT);
        if (StringUtils.isEmpty(strRemoteWebServerOneDeletePort)) {
            throw new IllegalStateException(
                    "远程Web服务器Nginx所在节点1的文件删除监听端口REMOTE_WEB_SERVER_ONE_DELETE_PORT在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        remoteWebServerOneDeletePort = new Integer(strRemoteWebServerOneDeletePort);
        remoteUploadFilePublishBasePath = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.REMOTE_UPLOAD_FILE_PUBLISH_BASE_PATH);
        if (StringUtils.isEmpty(remoteUploadFilePublishBasePath)) {
            throw new IllegalStateException(
                    "远程Web服务器Nginx存放上传文件的正式基础路径REMOTE_UPLOAD_FILE_PUBLISH_BASE_PATH在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        uploadFileImagePostfixFormat = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_IMAGE_POSTFIX_FORMAT);
        if (StringUtils.isEmpty(uploadFileImagePostfixFormat)) {
            throw new IllegalStateException(
                    "上传文件（图片）后缀格式UPLOAD_FILE_IMAGE_POSTFIX_FORMAT在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        String strUploadFileImageMaxSize = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_IMAGE_MAX_SIZE);
        if (StringUtils.isEmpty(strUploadFileImageMaxSize)) {
            throw new IllegalStateException(
                    "上传文件（图片）大小的最大值UPLOAD_FILE_IMAGE_MAX_SIZE在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        uploadFileImageMaxSize = new Long(strUploadFileImageMaxSize);
        uploadFileExcelPostfixFormat = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_EXCEL_POSTFIX_FORMAT);
        if (StringUtils.isEmpty(uploadFileExcelPostfixFormat)) {
            throw new IllegalStateException(
                    "上传文件（Excel）后缀格式UPLOAD_FILE_EXCEL_POSTFIX_FORMAT在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        String strUploadFileExcelMaxSize = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_EXCEL_MAX_SIZE);
        if (StringUtils.isEmpty(strUploadFileExcelMaxSize)) {
            throw new IllegalStateException(
                    "上传文件（Excel）大小的最大值UPLOAD_FILE_EXCEL_MAX_SIZE在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        uploadFileExcelMaxSize = new Long(strUploadFileExcelMaxSize);
        uploadFileCompressedDataPacketPostfixFormat = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_COMPRESSEDDATAPACKET_POSTFIX_FORMAT);
        if (StringUtils.isEmpty(uploadFileCompressedDataPacketPostfixFormat)) {
            throw new IllegalStateException(
                    "上传文件（压缩数据包）后缀格式UPLOAD_FILE_COMPRESSEDDATAPACKET_POSTFIX_FORMAT在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        String strUploadFileCompressedDataPacketMaxSize = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_COMPRESSEDDATAPACKET_MAX_SIZE);
        if (StringUtils.isEmpty(strUploadFileCompressedDataPacketMaxSize)) {
            throw new IllegalStateException(
                    "上传文件（压缩数据包）大小的最大值UPLOAD_FILE_COMPRESSEDDATAPACKET_MAX_SIZE在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        uploadFileCompressedDataPacketMaxSize = new Long(strUploadFileCompressedDataPacketMaxSize);
    }

    /**
     * 私有构造方法
     */
    private FileUploadUtils() {
    }

    /**
     * 
     * @Description:TODO(利用内部类的方式产生FileUploadUtils的单例)
     * @author: chenlian
     * @date: 2015年11月17日 下午2:13:36
     * 
     */
    private static class FileUploadUtilsHolder {
        private static final FileUploadUtils FILEUPLOADUTILS = new FileUploadUtils();
    }

    public static FileUploadUtils getInstance() {
        return FileUploadUtilsHolder.FILEUPLOADUTILS;
    }

    /**
     * 
     * @Description TODO(获得上传的文件)
     * @param request
     * @return List<FileItem> 上传的文件List
     */
    public List<FileItem> getUploadFiles(HttpServletRequest request) {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            LOGGER.error("请求的request不是 Multipart request，无法上传文件");
            throw new IllegalStateException("请求的request不是 Multipart request，无法上传文件");
        }
        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("utf-8");
            List<FileItem> items = upload.parseRequest(request);
            List<FileItem> fileItemList = new ArrayList<FileItem>();
            if (!ObjectUtils.isNullOrEmpty(items)) {
                for (FileItem fileItem : items) {
                    if (!StringUtils.isEmpty(fileItem.getName())) {
                        fileItemList.add(fileItem);
                    }
                }
            }
            return fileItemList;
        } catch (FileUploadException e) {
            LOGGER.error("上传文件出现系统异常", e);
            throw new IllegalStateException("上传文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(上传文件到本地服务器用作临时存储)
     * @param fileItem
     * @param fileRelativePath
     * @param uploadFileType
     * @return String
     */
    public String uploadTempFile(FileItem fileItem, String fileRelativePath, FileUploadUtils.UploadFileType uploadFileType) {
        validateUploadFile(fileItem, fileRelativePath, uploadFileType);
        try {
            String localFileFullPath = getLocalFileFullPath(fileItem, fileRelativePath);
            File destFile = new File(localFileFullPath);
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            saveUploadFile(fileItem.get(), destFile);
            String filePathSub = localFileFullPath.substring(localUploadFileBasePath.length());
            return filePathSub;
        } catch (Exception e) {
            LOGGER.error("上传文件出现系统异常", e);
            throw new IllegalStateException("上传文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(上传文件到本地服务器用作临时存储)
     * @param fileItem
     * @param fileRelativePath
     * @param uploadFileType
     * @param width
     * @param height
     * @return String
     */
    public String uploadTempFileByWidthAndHeight(FileItem fileItem, String fileRelativePath,
            FileUploadUtils.UploadFileType uploadFileType, Integer width, Integer height, double rate) {
        validateUploadFile(fileItem, fileRelativePath, uploadFileType);
        try {
            String localFileFullPath = getLocalFileFullPath(fileItem, fileRelativePath);
            File destFile = new File(localFileFullPath);
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            saveUploadFile(fileItem.get(), destFile);
            ImageUtils.rotateImage(localFileFullPath, localFileFullPath);
            ImageUtils.scale(localFileFullPath, localFileFullPath, width, height, rate);
            String filePathSub = localFileFullPath.substring(localUploadFileBasePath.length());
            return filePathSub;
        } catch (Exception e) {
            LOGGER.error("上传文件出现系统异常", e);
            throw new IllegalStateException("上传文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(上传文件到本地服务器用作临时存储)
     * @param fileItem
     * @param fileRelativePath
     * @param uploadFileType
     * @param widthHeightKeyPairs
     *            高度和宽度列表
     * @return String
     */
    public String uploadAndScaleTempFile(FileItem fileItem, String fileRelativePath,
            FileUploadUtils.UploadFileType uploadFileType, int width, int height, double rate) {
        validateUploadFile(fileItem, fileRelativePath, uploadFileType);
        try {
            String filePathSub = uploadTempFileByWidthAndHeight(fileItem, fileRelativePath, uploadFileType, width, height,
                    1);
            String srcFileFullPath = localUploadFileBasePath + filePathSub;
            if (rate > 0) {
                filePathSub = filePathSub.replaceAll("\\\\", CommonConstants.BACKSLASH);
                String localFileFullPath = localUploadFileBasePath + getThumbnailNameBySourceFileName(filePathSub);
                ImageUtils.scale(srcFileFullPath, localFileFullPath, width, height, rate);
                filePathSub = localFileFullPath.substring(localUploadFileBasePath.length());
            }
            return filePathSub;
        } catch (Exception e) {
            LOGGER.error("上传文件出现系统异常", e);
            throw new IllegalStateException("上传文件出现系统异常", e);
        }
    }

    public String getThumbnailNameBySourceFileName(String sourceFileName) {
        if (StringUtils.isEmpty(sourceFileName)) {
            return StringUtils.EMPTY;
        }
        sourceFileName = sourceFileName.replaceAll("\\\\", CommonConstants.BACKSLASH);
        int backSlashIndex = sourceFileName.lastIndexOf(CommonConstants.BACKSLASH);
        int startIndex = 0;
        if (-1 != backSlashIndex) {
            startIndex = backSlashIndex + 1;
        }
        int endIndex = sourceFileName.lastIndexOf('.');
        if (-1 == backSlashIndex || -1 == endIndex) {
            endIndex = sourceFileName.length();
        }
        String thumbnailName = CommonConstants.THUMBNAILNAME_PREFFIX + sourceFileName.substring(startIndex, endIndex)
                + getExtensionName(sourceFileName);
        String thumbnailNamePath = sourceFileName.substring(0, startIndex) + thumbnailName;
        return thumbnailNamePath;
    }

    /**
     * 
     * @Description TODO(删除本地服务器中的临时文件)
     * @param filePathSub
     * @return String
     */
    public void deleteTempFile(String filePathSub) {
        try {
            String localFileFullPath = localUploadFileBasePath + filePathSub;
            File file = new File(localFileFullPath);
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception e) {
            LOGGER.error("删除本地服务器中的临时文件出现系统异常", e);
            throw new IllegalStateException("删除本地服务器中的临时文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(上传文件到远程文件服务器的正式目录，实际上是将文件从本地服务器复制到远程服务器，并将本地服务器中该文件删除的一个过程)
     * @param filePathSub
     * @return String
     */
    public String uploadPublishFile(String filePathSub) {
        try {
            if (!ObjectUtils.isNullOrEmpty(filePathSub)) {
                filePathSub = filePathSub.replace("/local/", "/");
            }
            String localFileFullPath = localUploadFileBasePath + filePathSub;
            String remotePublishFileFullPath = remoteUploadFilePublishBasePath + filePathSub;
            File file = new File(localFileFullPath);
            if (file.exists()) {
                new RemoteFileDuplicateClient(remoteWebServerOneIp, remoteWebServerOneDuplicatePort, localFileFullPath,
                        remotePublishFileFullPath).run();
            }
            LOGGER.info("返回远程服务器存放文件的正式目录：" + remotePublishFileFullPath);
            String remotePublishfilePathSub = remotePublishFileFullPath.substring(remoteUploadFilePublishBasePath.length());
            return remotePublishfilePathSub;
        } catch (Exception e) {
            LOGGER.error("上传文件出现系统异常", e);
            throw new IllegalStateException("上传文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(删除远程服务器中的正式文件)
     * @param filePathSub
     */
    public void deletePublishFile(String filePathSub) {
        try {
            String remotePublishFileFullPath = remoteUploadFilePublishBasePath + filePathSub;
            new RemoteFileDeleteClient(remoteWebServerOneIp, remoteWebServerOneDeletePort, remotePublishFileFullPath).run();
        } catch (Exception e) {
            LOGGER.error("删除远程服务器中的正式文件出现系统异常", e);
            throw new IllegalStateException("删除远程服务器中的正式文件出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(验证上传文件是否合法)
     * @param fileItem
     * @param fileRelativePath
     * @param uploadFileType
     */
    private void validateUploadFile(FileItem fileItem, String fileRelativePath,
            FileUploadUtils.UploadFileType uploadFileType) {
        String msg = null;
        if (null == fileItem) {
            msg = "无法获取到上传的文件";
            LOGGER.error(msg);
            throw new IllegalArgumentException(msg);
        }
        if (null == uploadFileType) {
            msg = "上传文件的文件类型不能为空";
            LOGGER.error(msg);
            throw new IllegalArgumentException(msg);
        }
        String uploadFilePostfixFormat = uploadFileImagePostfixFormat;
        Long uploadFileMaxSize = uploadFileImageMaxSize;
        if (uploadFileType.getType().equals(FileUploadUtils.UploadFileType.EXCEL.getType())) {
            uploadFilePostfixFormat = uploadFileExcelPostfixFormat;
            uploadFileMaxSize = uploadFileExcelMaxSize;
        }
        if (uploadFileType.getType().equals(FileUploadUtils.UploadFileType.COMPRESSEDDATAPACKET.getType())) {
            uploadFilePostfixFormat = uploadFileCompressedDataPacketPostfixFormat;
            uploadFileMaxSize = uploadFileCompressedDataPacketMaxSize;
        }
        if (!validateUploadFileName(fileItem, uploadFilePostfixFormat)) {
            StringTokenizer st = new StringTokenizer(uploadFilePostfixFormat, "|");
            String allowedFormats = "";
            while (st.hasMoreTokens()) {
                allowedFormats += st.nextToken().replaceAll("\\.", "") + "、";
            }
            if (allowedFormats.endsWith("、")) {
                allowedFormats = allowedFormats.substring(0, allowedFormats.length() - 1);
            }
            msg = "上传的文件" + fileItem.getName() + "的格式只能为" + allowedFormats + "的格式";
            LOGGER.error(msg);
            throw new IllegalStateException(msg);
        }
        if (!validateUploadFileSize(fileItem, uploadFileMaxSize)) {
            msg = "上传的文件" + fileItem.getName() + "不能大于" + uploadFileMaxSize.longValue() / 1024 / 1024 + "M";
            LOGGER.error(msg);
            throw new IllegalStateException(msg);
        }
    }

    /**
     * 
     * @Description TODO(验证文件名是否合法)
     * @param fileItem
     * @param postfixFormats
     * @return Boolean
     */
    private Boolean validateUploadFileName(FileItem fileItem, String postfixFormats) {
        return postfixFormats.contains(getExtensionName(fileItem.getName()));
    }

    /**
     * 
     * @Description TODO(验证文件大小是否合法)
     * @param fileItem
     * @param maxSize
     * @return Boolean
     */
    private Boolean validateUploadFileSize(FileItem fileItem, Long maxSize) {
        return fileItem.getSize() <= maxSize;
    }

    /**
     * 
     * @Description TODO(获取本地文件全路径)
     * @param fileItem
     * @param fileRelativePath
     * @return String
     */
    private String getLocalFileFullPath(FileItem fileItem, String fileRelativePath) {
        String filename = getFileName(getExtensionName(fileItem.getName()).replace(".", ""));
        String destFilePathSub = "";
        if (!ObjectUtils.isNullOrEmpty(fileRelativePath)) {
            destFilePathSub = getFileDir(fileRelativePath) + filename;
        } else {
            destFilePathSub = CommonConstants.BACKSLASH + filename;
        }
        String destFilePath = localUploadFileBasePath + destFilePathSub;
        return destFilePath;
    }

    /**
     * 
     * @Description TODO(获取上传后文件的文件名)
     * @param ext
     * @return String
     */
    private String getFileName(String ext) {
        Date date = Calendar.getInstance().getTime();
        String datestr = DateUtils.formatDate(date, "yyyyMMddHHmmssSS");
        Random random = new Random();
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String rand = String.valueOf(random.nextInt(10));
            sRand += rand;
        }
        if (ObjectUtils.isNullOrEmpty(ext)) {
            return datestr + sRand;
        }
        return datestr + sRand + "." + ext;
    }

    /**
     * 
     * @Description TODO(获取文件的后缀名)
     * @param filename
     * @return String
     */
    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    /**
     * 
     * @Description TODO(获取中间文件夹路径)
     * @param fileRelativePath
     * @return String
     */
    private String getFileDir(String fileRelativePath) {
        Calendar calendar = Calendar.getInstance();
        return fileRelativePath + CommonConstants.BACKSLASH + DateUtils.formatDate(calendar.getTime(), "yyyyMM")
                + CommonConstants.BACKSLASH + calendar.get(Calendar.DAY_OF_MONTH) + CommonConstants.BACKSLASH;
    }

    /**
     * 
     * @Description TODO(保存上传文件)
     * @param inBytes
     * @param out
     * @throws Exception
     */
    public void saveUploadFile(byte[] inBytes, File out) throws Exception {
        OutputStream bos = null;
        try {
            bos = new FileOutputStream(out);
            bos.write(inBytes);
        } catch (FileNotFoundException ex) {
            throw new Exception(ex);
        } catch (IOException ex) {
            throw new Exception(ex);
        } catch (Exception ex) {
            throw new Exception(ex);
        } finally {
            if (null != bos) {
                bos.close();
                bos = null;
            }
        }
    }

    /**
     * 从http url中下载文件
     * 
     * @param httpUrl
     *            http url
     * @param destFileName
     *            指定创建的文件名,可以为空
     * @param fileRelativePath
     *            存储本地的相对路径
     * @throws Exception
     */
    public String uploadFromUrl(String httpUrl, String destFileName, String fileRelativePath) throws Exception {
        InputStream is = null;
        HttpURLConnection conn = null;
        try {
            httpUrl = httpUrl.replaceAll("\\\\", CommonConstants.BACKSLASH);
            URL url = new URL(httpUrl);
            conn = (HttpURLConnection) url.openConnection();
            // 设置超时间为20秒
            conn.setConnectTimeout(20 * 1000);
            // 防止屏蔽程序抓取而返回403错误
            conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
            // 得到输入流
            is = conn.getInputStream();
            if (ObjectUtils.isNullOrEmpty(destFileName)) {
                destFileName = getFileNameFromUrl(httpUrl);
            }
            fileRelativePath = fileRelativePath.replaceAll("\\\\", CommonConstants.BACKSLASH);
            String destFilePathSub = getFileDir(fileRelativePath) + destFileName;
            String localFileFullPath = localUploadFileBasePath + destFilePathSub;
            File destFile = new File(localFileFullPath);
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            byte[] bytes = readInputStream(is);
            saveUploadFile(bytes, destFile);
            return destFilePathSub;
        } catch (Exception e) {
            LOGGER.error(e, e);
            throw new Exception(e.getMessage());
        } finally {
            if (null != is) {
                is.close();
                is = null;
            }
            if (null != conn) {
                conn.disconnect();
                conn = null;
            }
        }
    }

    /**
     * 从输入流中获取字节数组
     * 
     * @param is
     *            输入流
     * @return 字节数组
     * @throws Exception
     *             操作异常
     */
    public static byte[] readInputStream(InputStream is) throws Exception {
        ByteArrayOutputStream bos = null;
        try {
            byte[] buffer = new byte[1024];
            int len = 0;
            bos = new ByteArrayOutputStream();
            while ((len = is.read(buffer)) != -1) {
                bos.write(buffer, 0, len);
            }
            return bos.toByteArray();
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            if (null != bos) {
                bos.close();
                bos = null;
            }
        }
    }

    /**
     * 从网络url中获取文件名
     * 
     * @param url
     *            http url
     * @return 文件名
     */
    public String getFileNameFromUrl(String url) {
        if (ObjectUtils.isNullOrEmpty(url)) {
            return "";
        }
        String fileName = "";
        int index = url.lastIndexOf(CommonConstants.BACKSLASH);
        if (index > 0 && index < (url.length() - 1)) {
            fileName = url.substring(index + 1).trim();
        }
        String ext = getExtensionName(fileName);
        if (ObjectUtils.isNullOrEmpty(ext)) {
            ext = "jpg";
        }
        fileName = getFileName(ext);
        return fileName;
    }

}
