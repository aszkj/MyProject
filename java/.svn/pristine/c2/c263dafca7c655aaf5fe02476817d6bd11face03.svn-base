package com.yilidi.o2o.controller;

import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yilidi.o2o.controller.common.BaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.crossdomain.IUserCrossDomainMainService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 测试跨域分布式事务功能Controller
 * 
 * @author chenl
 * 
 */
@Controller
public class TestCrossDomainTransactionController extends BaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserCrossDomainMainService userCrossDomainMainService;

    @RequestMapping(value = "/testCrossDomainTransaction", method = RequestMethod.GET)
    public void testCrossDomainTransaction(HttpServletRequest req, HttpServletResponse resp) throws UserServiceException {
        try {
            logger.info("----------------- testCrossDomainTransaction --------------------");

            String requsetURI = req.getRequestURI();
            logger.info("------------------------------------ requsetURI : " + requsetURI);

            String requestURL = req.getRequestURL().toString();
            logger.info("------------------------------------ requestURL : " + requestURL);

            String LocalAddr = req.getLocalAddr();
            logger.info("------------------------------------ LocalAddr : " + LocalAddr);

            Enumeration HeaderNames = req.getHeaderNames();
            while (HeaderNames.hasMoreElements()) {
                String a = (String) HeaderNames.nextElement();
                logger.info("------------------------------------ a : " + a);
                logger.info("------------------------------------ req.getHeader(a) : " + req.getHeader(a));
            }

            String referrer = req.getHeader("Referer");
            logger.info("------------------------------------ referrer : " + referrer);

            String RemoteAddr = req.getRemoteAddr();
            logger.info("------------------------------------ RemoteAddr : " + RemoteAddr);

            String RemoteHost = req.getRemoteHost();
            logger.info("------------------------------------ RemoteHost : " + RemoteHost);

            String ServletPath = req.getServletPath();
            logger.info("------------------------------------ ServletPath : " + ServletPath);

            Integer id = 6;
            UserDto uDto = new UserDto();
            uDto.setId(id);
            uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
            uDto.setAuditUserId(999);
            uDto.setAuditTime(new Date());
            uDto.setAuditNote("AAAAAAA");
            uDto.setModifyUserId(999);
            uDto.setModifyTime(new Date());
            userCrossDomainMainService.updateSubUserForAudit(uDto);
            logger.info("updateSubUserForAudit Success");
        } catch (Exception e) {
            logger.error("系统出现异常", e);
            throw new UserServiceException(e);
        }
    }

}
