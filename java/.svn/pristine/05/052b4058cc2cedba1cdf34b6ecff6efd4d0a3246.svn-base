package com.yilidi.o2o.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.controller.common.BaseController;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 测试Session功能Controller
 * 
 * @author chenl
 * 
 */
@Controller
public class TestSessionController extends BaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/setSession", method = RequestMethod.GET)
	public void setSession(HttpServletRequest req, HttpServletResponse resp) throws UserServiceException {
		try {
			logger.info("----------------- setSession --------------------");
			YiLiDiSession session = YiLiDiSessionHolder.getSession();
			logger.info("-----------------++++++++++++++++++++++++ session ++++++++++++++++++++++-------------------- : session : "
					+ JsonUtils.toJsonStringWithDateFormat(session));

			UserDto userDto = new UserDto();
			userDto.setUserName("hotcoolchen");
			userDto.setEmail("hotcoolchen@126.com");
			userDto.setNote("HAHAHAHAHA");

			session.setAttribute("userDto", userDto);
			session.setAttribute("userName", "hotcoolchen");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new UserServiceException(e);
		}
	}

	@RequestMapping(value = "/getSession", method = RequestMethod.GET)
	public void getSession(HttpServletRequest req, HttpServletResponse resp) {

		logger.info("----------------- getSession --------------------");
		YiLiDiSession session = YiLiDiSessionHolder.getSession();
		logger.info("-----------------++++++++++++++++++++++++ session ++++++++++++++++++++++-------------------- : session : "
				+ JsonUtils.toJsonStringWithDateFormat(session));

		if (null != session.getAttribute("userDto")) {
			UserDto userDto = (UserDto) session.getAttribute("userDto");
			logger.info("================================================================: userDto : "
					+ JsonUtils.toJsonStringWithDateFormat(userDto));
		} else {
			logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: userDto : "
					+ session.getAttribute("userDto"));
		}

		if (null != session.getAttribute("userName")) {
			String userName = (String) session.getAttribute("userName");
			logger.info("================================================================: userName : " + userName);
		} else {
			logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: userName : "
					+ session.getAttribute("userName"));
		}

		if (!ObjectUtils.isNullOrEmpty(session.getAttributeNames())) {
			for (String attributeName : session.getAttributeNames()) {
				logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: attributeName : "
						+ attributeName);
			}
		}

		session.removeAttribute("userName");

		logger.info("removeAttribute后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: userName : "
				+ session.getAttribute("userName"));

		if (!ObjectUtils.isNullOrEmpty(session.getAttributeNames())) {
			for (String attributeName : session.getAttributeNames()) {
				logger.info("removeAttribute后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: attributeName : "
						+ attributeName);
			}
		}

		session.invalidate();
		logger.info("invalidate后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: session.getId() : "
				+ session.getId());

		if (null != session.getAttribute("userDto")) {
			UserDto userDto = (UserDto) session.getAttribute("userDto");
			logger.info("invalidate后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: userDto : "
					+ JsonUtils.toJsonStringWithDateFormat(userDto));
		} else {
			logger.info("invalidate后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: userDto : "
					+ session.getAttribute("userDto"));
		}

		session.setAttribute("aa", "aa");
		logger.info("invalidate后+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: aa : "
				+ session.getAttribute("aa"));

		HttpSession s = req.getSession();
		s.setAttribute("ss", "ss");
		s.invalidate();
		logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: s.getId() : " + s.getId());
		logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: ss: " + s.getAttribute("ss"));
		s.setAttribute("aa", "aa");
		logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++: aa : " + s.getAttribute("aa"));
	}

}
