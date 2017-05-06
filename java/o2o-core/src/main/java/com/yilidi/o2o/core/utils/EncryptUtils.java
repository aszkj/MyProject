/**
 * 文件名称：EncryptUtil.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：加解密工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class EncryptUtils {

	/**
	 * DES算法字符串常量
	 */
	private static final String DES = "DES";

	private EncryptUtils() {
	}

	/**
	 * Base64编码
	 * 
	 * @param strEncode
	 *            待编码的字符串
	 * @return 如果字符为空或null，则返回"" ，否则返回编码结果
	 */
	public static String base64Encode(String strEncode) {

		if (StringUtils.isEmpty(strEncode)) {
			return "";
		} else {
			return Base64.encodeBase64String(strEncode.getBytes());
		}
	}

	/**
	 * Base64解码
	 * 
	 * @param strDecode
	 *            待解码的字符串
	 * @return 如果字符为空或null，则返回"" ，否则返回解码结果
	 */
	public static String base64Decode(String strDecode) {
		if (StringUtils.isEmpty(strDecode)) {
			return "";
		} else {
			return new String(Base64.decodeBase64(strDecode));
		}
	}

	/**
	 * MD5加密
	 * 
	 * @param strEncode
	 *            待加密字符串
	 * @return 加密后字符串
	 */
	public static String md5Crypt(String strEncode) {
		if (StringUtils.isEmpty(strEncode)) {
			return "";
		} else {
			return DigestUtils.md5Hex(strEncode).toUpperCase();
		}
	}

	/**
	 * DES加密
	 * 
	 * @param toEncryptStr
	 *            待加密字符串
	 * @param enCryptKey
	 *            加密使用的key(长度为8个字节)，如果为null或者"", 则使用默认的key
	 * @return 加密后的字符串
	 */
	public static String desEncrypt(String toEncryptStr, String enCryptKey) {

		if (StringUtils.isEmpty(toEncryptStr)) {
			return "";
		}
		byte[] bytes = toEncryptStr.getBytes();
		try {
			Cipher cipher = Cipher.getInstance(DES);
			Key key = null;
			if (StringUtils.isEmpty(enCryptKey)) {
				key = getKey(CommonConstants.ENCRYPT_KEY);
			} else {
				key = getKey(enCryptKey);
			}
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] encryptStrBytes = cipher.doFinal(bytes);
			return Base64.encodeBase64String(encryptStrBytes);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * DES解密
	 * 
	 * @param toDecryptStr
	 *            待解密的字符串
	 * @param enCryptKey
	 *            解密使用的key(长度为8个字节，要与加密的key保持一致)，如果为null或者"", 则使用默认的key
	 * @return 解密后的字符串
	 */
	public static String desDecrypt(String toDecryptStr, String enCryptKey) {
		if (StringUtils.isEmpty(toDecryptStr)) {
			return "";
		}
		try {
			byte[] bytes = Base64.decodeBase64(toDecryptStr);
			Cipher cipher = Cipher.getInstance(DES);
			Key key = null;
			if (StringUtils.isEmpty(enCryptKey)) {
				key = getKey(CommonConstants.ENCRYPT_KEY);
			} else {
				key = getKey(enCryptKey);
			}
			cipher.init(Cipher.DECRYPT_MODE, key);
			bytes = cipher.doFinal(bytes);
			return new String(bytes);
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}

	/**
	 * DES 加密（使用默认的key进行加密）
	 * 
	 * @param toEncryptStr
	 *            待加密字符串
	 * @return 加密后字符串
	 */
	public static String desEncrypt(String toEncryptStr) {
		return desEncrypt(toEncryptStr, CommonConstants.ENCRYPT_KEY);
	}

	/**
	 * DES解密 （使用默认的key进行解密）
	 * 
	 * @param toDecryptStr
	 *            待解密字符串
	 * @return 解密后字符串
	 */
	public static String desDecrypt(String toDecryptStr) {
		return desDecrypt(toDecryptStr, CommonConstants.ENCRYPT_KEY);
	}

	private static Key getKey(String strKey) {
		try {
			DESKeySpec objDesKeySpec = new DESKeySpec(strKey.getBytes(CommonConstants.UTF_8));
			SecretKeyFactory objKeyFactory = SecretKeyFactory.getInstance(DES);
			return objKeyFactory.generateSecret(objDesKeySpec);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
