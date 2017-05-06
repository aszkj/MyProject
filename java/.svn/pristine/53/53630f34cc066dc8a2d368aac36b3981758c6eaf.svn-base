package com.yilidi.o2o.core.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

import com.github.junrar.Archive;
import com.github.junrar.rarfile.FileHeader;
import com.yilidi.o2o.core.CommonConstants;

/**
 * 压缩工具类（支持zip、rar格式的解压缩）
 * 
 * @author: chenlian
 * @date: 2016年12月16日 上午11:15:01
 */
public class CompressUtils {

    protected static final Log LOGGER = LogFactory.getLog(CompressUtils.class);

    /**
     * 私有构造方法
     */
    private CompressUtils() {
    }

    /**
     * 利用内部类的方式产生CompressUtils的单例
     * 
     * @author: chenlian
     * @date: 2016年12月16日 上午11:30:15
     */
    private static class CompressUtilsHolder {
        private static final CompressUtils COMPRESSUTILS = new CompressUtils();
    }

    public static CompressUtils getInstance() {
        return CompressUtilsHolder.COMPRESSUTILS;
    }

    /**
     * 压缩ZIP文件
     * 
     * @param srcFiles
     *            压缩的源文件
     * @param zip
     *            压缩的目的地址
     */
    public void zip(List<File> srcFiles, String zip) {
        ZipOutputStream zipOut = null;
        try {
            if (zip.endsWith(".zip") || zip.endsWith(".ZIP")) {
                zipOut = new ZipOutputStream(new FileOutputStream(new File(zip)));
                zipOut.setEncoding(CommonConstants.UTF_8);
                for (File f : srcFiles) {
                    handlerFile(zipOut, zip, f, "");
                }
                zipOut.close();
            } else {
                LOGGER.error("目标文件[" + zip + "] 不是 .zip 文件类型");
                throw new IllegalStateException("目标文件[" + zip + "] 不是 .zip 文件类型");
            }
        } catch (Exception e) {
            LOGGER.error("解压zip文件出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    private void handlerFile(ZipOutputStream zipOut, String zip, File srcFile, String path) throws IOException {
        LOGGER.info(" 开始压缩文件[" + srcFile.getName() + "]");
        if (!"".equals(path) && !path.endsWith(File.separator)) {
            path += File.separator;
        }
        if (!srcFile.getPath().equals(zip)) {
            if (srcFile.isDirectory()) {
                File[] files = srcFile.listFiles();
                if (files.length == 0) {
                    zipOut.putNextEntry(new ZipEntry(path + srcFile.getName() + File.separator));
                    zipOut.closeEntry();
                } else {
                    for (File f : files) {
                        handlerFile(zipOut, zip, f, path + srcFile.getName());
                    }
                }
            } else {
                InputStream in = new FileInputStream(srcFile);
                zipOut.putNextEntry(new ZipEntry(path + srcFile.getName()));
                int len = 0;
                byte[] byteArray = new byte[1024];
                while ((len = in.read(byteArray)) > 0) {
                    zipOut.write(byteArray, 0, len);
                }
                in.close();
                zipOut.closeEntry();
            }
        }
    }

    /**
     * 解压缩ZIP文件，将ZIP文件里的内容解压到descDir目录下
     * 
     * @param zipPath
     *            待解压缩的ZIP文件路径
     * @param descDir
     *            目标目录
     */
    public List<File> unzip(String zipPath, String descDir) {
        return unzip(new File(zipPath), descDir);
    }

    @SuppressWarnings("rawtypes")
    private List<File> unzip(File zipFile, String descDir) {
        List<File> list = new ArrayList<File>();
        try {
            ZipFile zfile = new ZipFile(zipFile, CommonConstants.UTF_8);
            for (Enumeration entries = zfile.getEntries(); entries.hasMoreElements();) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                File file = new File(descDir + File.separator + entry.getName());
                if (file.exists()) {
                    file.delete();
                }
                if (entry.isDirectory()) {
                    file.mkdirs();
                    list.add(file);
                } else {
                    File parent = file.getParentFile();
                    if (!parent.exists()) {
                        parent.mkdirs();
                    }
                    InputStream in = zfile.getInputStream(entry);
                    OutputStream out = new FileOutputStream(file);
                    int len = 0;
                    byte[] byteArray = new byte[1024];
                    while ((len = in.read(byteArray)) > 0) {
                        out.write(byteArray, 0, len);
                    }
                    in.close();
                    out.flush();
                    out.close();
                    list.add(file);
                }
            }
            return list;
        } catch (Exception e) {
            LOGGER.error("解压zip文件出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    /**
     * 解压rar文件
     * 
     * @param rarFilePath
     *            原始rar文件路径
     * @param outFilePath
     *            解压后文件路径
     * @return 解压后文件列表(包含目录)
     * @throws IOException
     *             IO异常
     */
    public List<File> unrar(String rarFilePath, String outFilePath) throws IOException {
        Archive archive = null;
        List<File> list = new ArrayList<File>();
        try {
            if (ObjectUtils.isNullOrEmpty(rarFilePath)) {
                throw new IllegalStateException("参数rarFilePath不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(outFilePath)) {
                throw new IllegalStateException("参数outFilePath不能为空");
            }
            archive = new Archive(new File(rarFilePath));
            if (archive.isEncrypted()) {
                throw new IllegalStateException("压缩文件是被加密的，无法解压");
            }
            FileHeader fh = null;
            while (true) {
                fh = archive.nextFileHeader();
                if (fh == null) {
                    break;
                }
                if (fh.isEncrypted()) {
                    LOGGER.info("文件是被加密的，无法解压");
                    continue;
                }
                try {
                    if (fh.isDirectory()) {
                        File f = createDirectory(fh, new File(outFilePath));
                        list.add(f);
                    } else {
                        File f = createFile(fh, new File(outFilePath));
                        OutputStream stream = new FileOutputStream(f);
                        archive.extractFile(fh, stream);
                        stream.close();
                        list.add(f);
                    }
                } catch (Exception e) {
                    LOGGER.error("解压rar文件出现系统异常", e);
                }
            }
            return list;
        } catch (Exception e) {
            LOGGER.error("解压rar文件出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        } finally {
            if (!ObjectUtils.isNullOrEmpty(archive)) {
                archive.close();
            }
        }
    }

    private File createFile(FileHeader fh, File destination) {
        File f = null;
        String name = null;
        if (fh.isFileHeader() && fh.isUnicode()) {
            name = fh.getFileNameW();
        } else {
            name = fh.getFileNameString();
        }
        f = new File(destination, name);
        if (!f.exists()) {
            try {
                f = makeFile(destination, name);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return f;
    }

    private File makeFile(File destination, String name) throws IOException {
        String[] dirs = name.split("\\\\");
        if (dirs == null) {
            return null;
        }
        String path = "";
        int size = dirs.length;
        if (size == 1) {
            return new File(destination, name);
        } else if (size > 1) {
            for (int i = 0; i < dirs.length - 1; i++) {
                path = path + File.separator + dirs[i];
                new File(destination, path).mkdir();
            }
            path = path + File.separator + dirs[dirs.length - 1];
            File f = new File(destination, path);
            f.createNewFile();
            return f;
        } else {
            return null;
        }
    }

    private File createDirectory(FileHeader fh, File destination) {
        File f = null;
        if (fh.isDirectory() && fh.isUnicode()) {
            f = new File(destination, fh.getFileNameW());
            if (!f.exists()) {
                makeDirectory(destination, fh.getFileNameW());
            }
        } else if (fh.isDirectory() && !fh.isUnicode()) {
            f = new File(destination, fh.getFileNameString());
            if (!f.exists()) {
                makeDirectory(destination, fh.getFileNameString());
            }
        }
        return f;
    }

    private void makeDirectory(File destination, String fileName) {
        String[] dirs = fileName.split("\\\\");
        if (dirs == null) {
            return;
        }
        String path = "";
        for (String dir : dirs) {
            path = path + File.separator + dir;
            new File(destination, path).mkdir();
        }
    }

}