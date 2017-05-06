package com.yilidi.o2o.core.paramvalidate.build;

import com.yilidi.o2o.core.paramvalidate.state.IParamType;
import com.yilidi.o2o.core.paramvalidate.state.concrete.DoubleType;
import com.yilidi.o2o.core.paramvalidate.state.concrete.IntegerType;
import com.yilidi.o2o.core.paramvalidate.state.concrete.LongType;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrChinese;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrDate;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrDouble;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrEmail;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrIdentity;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrInteger;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrLong;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrMobile;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrNormal;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrNumber;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrPhone;
import com.yilidi.o2o.core.paramvalidate.state.concrete.StrPostcode;

/**
 * 封装验证参数
 * 
 * @author chenl
 * 
 */
public class Param {

	protected String name;

	protected IParamType paramType;

	protected Object value;

	protected Boolean isAllowEmpty;

	protected Integer minLength;

	protected Integer maxLength;

	protected Long minValue;

	protected Long maxValue;

	protected String regex;

	public static enum ParamType {

		STR_NORMAL(StrNormal.getInstance()), STR_MOBILE(StrMobile.getInstance()), STR_PHONE(StrPhone.getInstance()), STR_EMAIL(
				StrEmail.getInstance()), STR_DATE(StrDate.getInstance()), STR_IDENTITY(StrIdentity.getInstance()), STR_POSTCODE(
				StrPostcode.getInstance()), STR_NUMBER(StrNumber.getInstance()), STR_CHINESE(StrChinese.getInstance()), STR_INTEGER(
				StrInteger.getInstance()), STR_LONG(StrLong.getInstance()), STR_DOUBLE(StrDouble.getInstance()), INTEGER_TYPE(
				IntegerType.getInstance()), LONG_TYPE(LongType.getInstance()), DOUBLE_TYPE(DoubleType.getInstance());

		private IParamType type;

		private ParamType(IParamType type) {
			this.type = type;
		}

		public IParamType getType() {
			return type;
		}

	}

	public static class Builder {

		private String name;

		private IParamType paramType;

		private Object value;

		private Boolean isAllowEmpty;

		private Integer minLength;

		private Integer maxLength;

		private Long minValue;

		private Long maxValue;

		private String regex;

		public Builder(String name, IParamType paramType, Object value, Boolean isAllowEmpty) {
			super();
			this.name = name;
			this.paramType = paramType;
			this.value = value;
			this.isAllowEmpty = isAllowEmpty;
		}

		public Builder minLength(Integer val) {
			minLength = val;
			return this;
		}

		public Builder maxLength(Integer val) {
			maxLength = val;
			return this;
		}

		public Builder minValue(Long val) {
			minValue = val;
			return this;
		}

		public Builder maxValue(Long val) {
			maxValue = val;
			return this;
		}

		public Builder regex(String val) {
			regex = val;
			return this;
		}

		public Param build() {
			return new Param(this);
		}
	}

	protected Param() {

	}

	private Param(Builder builder) {
		name = builder.name;

		paramType = builder.paramType;

		value = builder.value;

		isAllowEmpty = builder.isAllowEmpty;

		minLength = builder.minLength;

		maxLength = builder.maxLength;

		minValue = builder.minValue;

		maxValue = builder.maxValue;

		regex = builder.regex;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public IParamType getParamType() {
		return paramType;
	}

	public void setParamType(IParamType paramType) {
		this.paramType = paramType;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public Boolean getIsAllowEmpty() {
		return isAllowEmpty;
	}

	public void setIsAllowEmpty(Boolean isAllowEmpty) {
		this.isAllowEmpty = isAllowEmpty;
	}

	public Integer getMinLength() {
		return minLength;
	}

	public void setMinLength(Integer minLength) {
		this.minLength = minLength;
	}

	public Integer getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(Integer maxLength) {
		this.maxLength = maxLength;
	}

	public Long getMinValue() {
		return minValue;
	}

	public void setMinValue(Long minValue) {
		this.minValue = minValue;
	}

	public Long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(Long maxValue) {
		this.maxValue = maxValue;
	}

	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}

}
