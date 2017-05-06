package com.yilidi.o2o.core.payment.tencent.protocol.orderquery;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.RandomStringGenerator;
import com.yilidi.o2o.core.payment.tencent.common.Signature;

/**
 * 查询订单请求结构
 * 
 * @author simpson
 * 
 */
public class OrderQueryReqData {

	// 每个字段具体的意思请查看API文档
	private String appid = "";
	private String mch_id = "";
	private String transaction_id = "";
	private String out_trade_no = "";
	private String nonce_str = "";
	private String sign = "";

	/**
	 * 请求支付查询服务
	 * 
	 * @param transactionID
	 *            是微信系统为每一笔支付交易分配的订单号，通过这个订单号可以标识这笔交易，它由支付订单API支付成功时返回的数据里面获取到。
	 *            建议优先使用
	 * @param outTradeNo
	 *            商户系统内部的订单号,transaction_id 、out_trade_no
	 *            二选一，如果同时存在优先级：transaction_id>out_trade_no
	 * @throws Exception
	 */
	public OrderQueryReqData(String transactionID, String outTradeNo, boolean isJsApi) {
		// 微信分配的公众号ID（开通公众号之后可以获取到）
		setAppid(Configure.getAppid(isJsApi));
		// 微信支付分配的商户号ID（开通公众号的微信支付功能之后可以获取到）
		setMch_id(Configure.getMchid(isJsApi));
		// transaction_id是微信系统为每一笔支付交易分配的订单号，通过这个订单号可以标识这笔交易，它由支付订单API支付成功时返回的数据里面获取到。
		setTransaction_id(transactionID);
		// 商户系统自己生成的唯一的订单号
		setOut_trade_no(outTradeNo);
		// 随机字符串，不长于32 位
		setNonce_str(RandomStringGenerator.getRandomStringByLength(32));
		// 根据API给的签名规则进行签名
		setSign(Signature.getSign(toMap(), isJsApi));
	}

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getMch_id() {
		return mch_id;
	}

	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}

	public String getTransaction_id() {
		return transaction_id;
	}

	public void setTransaction_id(String transaction_id) {
		this.transaction_id = transaction_id;
	}

	public String getOut_trade_no() {
		return out_trade_no;
	}

	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}

	public String getNonce_str() {
		return nonce_str;
	}

	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	/**
	 * 类转换为map
	 * 
	 * @return map
	 */
	public Map<String, Object> toMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		Field[] fields = this.getClass().getDeclaredFields();
		for (Field field : fields) {
			Object obj;
			try {
				obj = field.get(this);
				if (obj != null) {
					map.put(field.getName(), obj);
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
}
