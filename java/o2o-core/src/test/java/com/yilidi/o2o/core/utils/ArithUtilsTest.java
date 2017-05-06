/**
 * 文件名称：ArithUtilsTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import org.junit.Assert;
import org.junit.Test;

import com.yilidi.o2o.core.utils.ArithUtils;

/**
 * 功能描述：测试 ArithUtils的功能
 * 
 * @author : chenl
 * 
 */

public class ArithUtilsTest {

    @Test
    public void testAdd() {
        double actual = ArithUtils.add(15.1, 16.358);
        Assert.assertEquals(31.458d, actual, 0.00000001);

        actual = ArithUtils.add(15555147147.104475, 16.30058);
        Assert.assertEquals(15555147163.405055d, actual, 0.0000000001);
    }

    @Test
    public void testSub() {
        double actual = ArithUtils.sub(18.1, 16.358);
        Assert.assertEquals(1.742d, actual, 0.00000001);
    }

    @Test
    public void testMul() {
        double actual = ArithUtils.mul(15.021, 13.258);
        Assert.assertEquals(199.148418d, actual, 0.00000001);
    }

    @Test
    public void testDiv() {
        double actual = ArithUtils.div(286.3584, 42.268);
        Assert.assertEquals(6.774827292514431721396801362733d, actual, 0.00000001);
    }

    @Test
    public void testConvertToInt() {
        int actual = ArithUtils.convertsToIntNoRound(286.3584);
        Assert.assertEquals(286, actual);
    }
    
    @Test
    public void testConvertToIntWithRound() {
        int actual = ArithUtils.convertsToIntWithRound(286.3584);
        Assert.assertEquals(286, actual);
    }
    
    @Test
    public void testConvertToLongNoRound() {
        Long actual = ArithUtils.convertsToLongNoRound(28889885856.7584);
        Assert.assertEquals(28889885856L, actual.longValue());
    }
    
    @Test
    public void testConvertToLongWithRound() {
        Long actual = ArithUtils.convertsToLongWithRound(28889885856.7584);
        Assert.assertEquals(28889885857L, actual.longValue());
    }

    @Test
    public void testRound() {
        double actual = ArithUtils.round(2856.5875, 2);
        Assert.assertEquals(2856.59d, actual, 0.000000001);
        
    }
    
    @Test
    public void testReturnMax() {
        double d1 = 0.000001254;
        double d2 = 0.000001253;
        
        double max = ArithUtils.returnMax(d1, d2);
        Assert.assertEquals(0.000001254d, max, 0.0000000001);
    }
}
