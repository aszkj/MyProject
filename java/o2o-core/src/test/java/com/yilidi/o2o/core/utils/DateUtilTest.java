/**
 * 文件名称：DateUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.text.ParseException;
import java.util.Date;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 */
public class DateUtilTest {
    
    Logger logger = Logger.getLogger(this.getClass());

    @Test
    public void testAddMinutes() throws ParseException {

        String dateStr1 = "1999-02-28 12:15:45";
        Date date1 = DateUtils.parseDate(dateStr1, CommonConstants.DATE_FORMAT_CURRENTTIME);
        Date date2 = DateUtils.addMinutes(date1, 50);
        String dateStr2 = DateUtils.formatDate(date2, CommonConstants.DATE_FORMAT_CURRENTTIME);
        
        Assert.assertEquals("1999-02-28 13:05:45", dateStr2);
    }
    
    @Test
    public void testAddHours() throws ParseException {

        String dateStr1 = "1999-02-28 12:15:45";
        Date date1 = DateUtils.parseDate(dateStr1, CommonConstants.DATE_FORMAT_CURRENTTIME);
        Date date2 = DateUtils.addHours(date1, 12);
        String dateStr2 = DateUtils.formatDate(date2, CommonConstants.DATE_FORMAT_CURRENTTIME);
        
        Assert.assertEquals("1999-03-01 00:15:45", dateStr2);
    }
    
    @Test
    public void testAddDays() throws ParseException {

        String dateStr1 = "2015-02-28";
        Date date1 = DateUtils.parseDate(dateStr1, CommonConstants.DATE_FORMAT_DAY);
        Date date2 = DateUtils.addDays(date1, -7);
        String dateStr2 = DateUtils.formatDate(date2, CommonConstants.DATE_FORMAT_DAY);
        
        Assert.assertEquals("2015-02-21", dateStr2);
    }
    
    @Test
    public void testAddMonth() throws ParseException {

        String dateStr1 = "1999-02-28 12:15:45";
        Date date1 = DateUtils.parseDate(dateStr1, CommonConstants.DATE_FORMAT_CURRENTTIME);
        Date date2 = DateUtils.addMonths(date1, 12);
        String dateStr2 = DateUtils.formatDate(date2, CommonConstants.DATE_FORMAT_CURRENTTIME);
        
        Assert.assertEquals("2000-02-28 12:15:45", dateStr2);
    }

    @Test
    public void testDaysBetween() throws ParseException {
        Date d1 = new Date();
        // 增加22天
        Date d2 = DateUtils.addDays(d1, 22);
        
        long diff = DateUtils.daysBetween(d1, d2);
        Assert.assertEquals(22, diff);
        
        
        String date1 = "1982-03-12 23:15:45";
        String date2 = "1982-04-12 23:15:45";
        
        diff = DateUtils.daysBetween(date1, date2);
        logger.info(diff);
        
       
        
    }
    
    @Test
    public void testParseDate() {
        try {
            Date d = DateUtils.parseDate("2014122014130123", "yyyyMMddHHmmssSSS");
            String str = DateUtils.formatDate(d, "yyyyMMddHHmmssSSS");
            logger.info("length: " + d);
            logger.info("length: " + str);
            
            Date currentDate = new Date();
            
            long diff = DateUtils.daysBetween(currentDate, d);
            
            logger.info(diff);
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    
    
}
