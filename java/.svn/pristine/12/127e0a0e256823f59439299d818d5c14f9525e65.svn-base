package com.yilidi.o2o.common.session.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.core.utils.StringUtils;

import redis.clients.jedis.Jedis;

/**
 * YiLiDiSession的Model类
 * 
 * @author chenl
 * 
 */
public class YiLiDiSession implements Serializable {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 1L;

    /**
     * logger日志
     */
    private static final Logger LOGGER = Logger.getLogger(YiLiDiSession.class);

    /**
     * 参数Map
     */
    private Map<String, Object> attributeMap;

    /**
     * Session的id(即，生成的UUID)
     */
    private String id;

    /**
     * session创建时间
     */
    private Date creationTime;

    /**
     * 最近访问时间
     */
    private Date lastAccessedTime;

    /**
     * 最大不活跃间隔时间。单位：秒
     */
    private Integer maxInactiveInterval;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    public Date getLastAccessedTime() {
        return lastAccessedTime;
    }

    public void setLastAccessedTime(Date lastAccessedTime) {
        this.lastAccessedTime = lastAccessedTime;
    }

    public Integer getMaxInactiveInterval() {
        return maxInactiveInterval;
    }

    /**
     * 设为负值表示Session永不过期
     * 
     * @param maxInactiveInterval
     */
    public void setMaxInactiveInterval(Integer maxInactiveInterval) {
        this.maxInactiveInterval = maxInactiveInterval;
    }

    public Map<String, Object> getAttributeMap() {
        return attributeMap;
    }

    public void setAttributeMap(Map<String, Object> attributeMap) {
        this.attributeMap = attributeMap;
    }

    public Object getAttribute(String attributeName) {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(this.id)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes())) {
                    if (ObjectUtils.isNullOrEmpty(this.attributeMap)) {
                        return null;
                    }
                    return this.attributeMap.get(attributeName);
                } else {
                    throwNoSessionException();
                }
            } else {
                throwNoSessionException();
            }
            return null;
        } catch (Exception e) {
            if (StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error("获取Session属性值出现系统异常", e);
                throw new IllegalStateException("获取Session属性值出现系统异常", e);
            } else {
                LOGGER.error(e.getMessage(), e);
                throw new IllegalStateException(e.getMessage(), e);
            }
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    public void setAttribute(String attributeName, Object attribute) {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(this.id)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes())) {
                    if (null == this.attributeMap) {
                        this.attributeMap = new HashMap<String, Object>();
                    }
                    this.attributeMap.put(attributeName, attribute);
                    jedis.hset(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes(),
                            SerializableUtils.write(this));
                } else {
                    throwNoSessionException();
                }
            } else {
                throwNoSessionException();
            }
        } catch (Exception e) {
            if (StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error("设置Session属性值出现系统异常", e);
                throw new IllegalStateException("设置Session属性值出现系统异常", e);
            } else {
                LOGGER.error(e.getMessage(), e);
                throw new IllegalStateException(e.getMessage(), e);
            }
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    public List<String> getAttributeNames() {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(this.id)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes())) {
                    if (ObjectUtils.isNullOrEmpty(this.attributeMap)) {
                        return null;
                    }
                    List<String> attributeNames = new ArrayList<String>();
                    for (Map.Entry<String, Object> entry : this.attributeMap.entrySet()) {
                        attributeNames.add(entry.getKey());
                    }
                    return attributeNames;
                } else {
                    throwNoSessionException();
                }
            } else {
                throwNoSessionException();
            }
            return null;
        } catch (Exception e) {
            if (StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error("获取Session属性名出现系统异常", e);
                throw new IllegalStateException("获取Session属性名出现系统异常", e);
            } else {
                LOGGER.error(e.getMessage(), e);
                throw new IllegalStateException(e.getMessage(), e);
            }
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    public void invalidate() {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(this.id)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes())) {
                    if (!ObjectUtils.isNullOrEmpty(this.attributeMap)) {
                        Iterator<Map.Entry<String, Object>> it = this.attributeMap.entrySet().iterator();
                        while (it.hasNext()) {
                            it.next();
                            it.remove();
                        }
                    }
                    // 删除Redis关于该Session的信息，Cookie不用删除，因为Cookie过了有效期会自动删除，如果在有效期内再次访问，发现找不到相应的Redis缓存，拦截器里也会删除掉该Cookie
                    jedis.hdel(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes());
                    this.id = null;
                } else {
                    throwNoSessionException();
                }
            } else {
                throwNoSessionException();
            }
        } catch (Exception e) {
            if (StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error("设置Session失效出现系统异常", e);
                throw new IllegalStateException("设置Session失效出现系统异常", e);
            } else {
                LOGGER.error(e.getMessage(), e);
                throw new IllegalStateException(e.getMessage(), e);
            }
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    public void removeAttribute(String attributeName) {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(this.id)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes())) {
                    if (!ObjectUtils.isNullOrEmpty(this.attributeMap) && this.attributeMap.containsKey(attributeName)) {
                        this.attributeMap.remove(attributeName);
                        jedis.hset(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), this.id.getBytes(),
                                SerializableUtils.write(this));
                    }
                } else {
                    throwNoSessionException();
                }
            } else {
                throwNoSessionException();
            }
        } catch (Exception e) {
            if (StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error("移除Session属性值出现系统异常", e);
                throw new IllegalStateException("移除Session属性值出现系统异常", e);
            } else {
                LOGGER.error(e.getMessage(), e);
                throw new IllegalStateException(e.getMessage(), e);
            }
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    private void throwNoSessionException() {
        String msg = "Session不存在！";
        LOGGER.error(msg);
        throw new IllegalStateException(msg);
    }

}
