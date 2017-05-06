package com.yilidi.o2o.core.payment.tencent.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundOrderData;

/**
 * xml解析器
 * 
 * @author simpson
 * 
 */
public final class XMLParser {

    private XMLParser() {
    }

    /**
     * 从RefunQueryResponseString里面解析出退款订单数据
     * 
     * @param refundQueryResponseString
     *            RefundQuery API返回的数据
     * @return 因为订单数据有可能是多个，所以返回一个列表
     * @throws IOException
     *             IO异常
     * @throws SAXException
     *             SAX异常
     * @throws ParserConfigurationException
     *             解析异常
     */
    public static List<RefundOrderData> getRefundOrderList(String refundQueryResponseString) throws IOException,
            SAXException, ParserConfigurationException {
        List<RefundOrderData> list = new ArrayList<RefundOrderData>();

        Map<String, Object> map = XMLParser.getMapFromXML(refundQueryResponseString);

        int count = Integer.parseInt((String) map.get("refund_count"));
        Util.log("count:" + count);

        if (count < 1) {
            return list;
        }

        RefundOrderData refundOrderData;

        for (int i = 0; i < count; i++) {
            refundOrderData = new RefundOrderData();

            refundOrderData.setOutRefundNo(Util.getStringFromMap(map, "out_refund_no_" + i, ""));
            refundOrderData.setRefundID(Util.getStringFromMap(map, "refund_id_" + i, ""));
            refundOrderData.setRefundChannel(Util.getStringFromMap(map, "refund_channel_" + i, ""));
            refundOrderData.setRefundFee(Util.getIntFromMap(map, "refund_fee_" + i));
            refundOrderData.setCouponRefundFee(Util.getIntFromMap(map, "coupon_refund_fee_" + i));
            refundOrderData.setRefundStatus(Util.getStringFromMap(map, "refund_status_" + i, ""));
            list.add(refundOrderData);
        }

        return list;
    }

    /**
     * xml转换map
     * 
     * @param xmlString
     *            xml字符串
     * @return map
     * @throws IOException
     *             IO异常
     * @throws SAXException
     *             SAX异常
     * @throws ParserConfigurationException
     *             解析异常
     */
    public static Map<String, Object> getMapFromXML(String xmlString) throws ParserConfigurationException, IOException,
            SAXException {

        // 这里用Dom的方式解析回包的最主要目的是防止API新增回包字段
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputStream is = Util.getStringStream(xmlString);
        Document document = builder.parse(is);

        // 获取到document里面的全部结点
        NodeList allNodes = document.getFirstChild().getChildNodes();
        Node node;
        Map<String, Object> map = new HashMap<String, Object>();
        int i = 0;
        while (i < allNodes.getLength()) {
            node = allNodes.item(i);
            if (node instanceof Element) {
                map.put(node.getNodeName(), node.getTextContent());
            }
            i++;
        }
        return map;

    }

}
