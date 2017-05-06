/**
 * 文件名称：ProductImageService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ProductImageMapper;
import com.yilidi.o2o.product.model.ProductImage;
import com.yilidi.o2o.product.service.IProductImageService;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:产品图片服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productImageService")
public class ProductImageServiceImpl extends BasicDataService implements IProductImageService {

    @Autowired
    private ProductImageMapper productImageMapper;

    @Override
    public void saveProductImages(List<ProductImageDto> saveProductImageDtos) {
        logger.debug("saveProductImageDtos -> " + saveProductImageDtos);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductImageDtos)) {
                logger.error("ProductImageService.saveProductImages => 产品图片参数为空");
                throw new ProductServiceException("ProductImageService的saveProductImages方法参数为空");
            }
            for (ProductImageDto productImageDto : saveProductImageDtos) {
                this.saveProductImage(productImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存产品所有图片出错");
            throw new ProductServiceException("异常：保存产品所有图片出错");
        }
    }

    @Override
    public void saveProductImage(ProductImageDto saveProductImageDto) {
        logger.debug("saveProductImageDto -> " + saveProductImageDto);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductImageDto)) {
                logger.error("ProductImageService.saveProductImages => 保存单张产品图片参数为空");
                throw new ProductServiceException("ProductImageService的saveProductImage方法参数为空");
            }
            // 保存产品单张图片
            // 如果图片id不存在，则新增
            if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getId())) {
                // 检查产品ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getProductId())) {
                    logger.error("ProductImageService.saveProductImage =>产品ID参数为空");
                    throw new ProductServiceException("产品ID参数为空");
                }
                // 检查产品主图标志参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getMasterFlag())) {
                    logger.error("ProductImageService.saveProductImage =>产品主图标志参数为空");
                    throw new ProductServiceException("产品主图标志参数为空");
                }
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getChannelCode())) {
                    logger.error("ProductImageService.saveProductImage =>产品渠道编码为空");
                    throw new ProductServiceException("产品渠道编码为空");
                }
                // 检查产品创建人ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getCreateUserId())) {
                    logger.error("ProductImageService.saveProductImage =>产品创建人ID参数为空");
                    throw new ProductServiceException("产品创建人ID参数为空");
                }
                // 检查产品创建时间参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getCreateTime())) {
                    logger.error("ProductImageService.saveProductImage =>产品创建时间参数为空");
                    throw new ProductServiceException("产品创建时间参数为空");
                }
                // 检查产品创建时间参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductImageDto.getImageUrl())) {
                    logger.error("ProductImageService.saveProductImage =>产品创建图片url参数为空");
                    throw new ProductServiceException("产品创建图片url参数为空");
                }
                // 检查产品图片Url参数是否为空
                if (!ObjectUtils.isNullOrEmpty(saveProductImageDto.getImageUrl())) {
                    ProductImage productImage = new ProductImage();
                    productImage.setProductId(saveProductImageDto.getProductId());
                    productImage.setChannelCode(saveProductImageDto.getChannelCode());
                    // 获取图片路径
                    String ext = this.getExtensionName(saveProductImageDto.getImageUrl()).replace(".", "");
                    productImage.setImageUrl1(saveProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_1." + ext));
                    productImage.setImageUrl2(saveProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_2." + ext));
                    productImage.setImageUrl3(saveProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_3." + ext));
                    // 图片只有一张的时候设置值为1，数据库该字段为非null
                    productImage.setImageOrder(saveProductImageDto.getImageOrder());
                    // 设置主图标示
                    productImage.setMasterFlag(saveProductImageDto.getMasterFlag());
                    productImage.setCreateTime(saveProductImageDto.getCreateTime());
                    // 此处创建人id需要取到用户登录的id
                    productImage.setCreateUserId(saveProductImageDto.getCreateUserId());
                    productImageMapper.saveProductImage(productImage);
                }
            }

        } catch (ProductServiceException e) {
            logger.error("保存产品单张图片出错");
            throw new ProductServiceException("异常：保存产品单张图片出错");
        }
    }

    /**
     * 
     * @Description TODO(获取文件的后缀名)
     * @param filename
     * @return String
     */
    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    @Override
    public void updateProductImage(ProductImageDto updateProductImageDto) throws ProductServiceException {
        logger.debug("updateProductImageDto -> " + updateProductImageDto);
        // 更新产品某一张图片
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductImageDto)) {
                logger.error("ProductImageService.updateProductImageDto => 产品其中一张图片的参数为空");
                throw new ProductServiceException("ProductImageService的updateProductImage方法参数为空");
            }
            // 检查产品图片ID是否为空
            if (!ObjectUtils.isNullOrEmpty(updateProductImageDto.getId())) {
                ProductImage productImage = productImageMapper.loadProductImageById(updateProductImageDto.getId());

                String ext = this.getExtensionName(updateProductImageDto.getImageUrl()).replace(".", "");
                if (ObjectUtils.whetherModified(productImage.getImageUrl1(),
                        updateProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_1." + ext))
                        || ObjectUtils.whetherModified(productImage.getImageOrder(), updateProductImageDto.getImageOrder())
                        || ObjectUtils.whetherModified(productImage.getMasterFlag(), updateProductImageDto.getMasterFlag())) {

                    productImage.setImageUrl1(updateProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_1." + ext));
                    productImage.setImageUrl2(updateProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_2." + ext));
                    productImage.setImageUrl3(updateProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_3." + ext));
                    // 图片顺序
                    productImage.setImageOrder(updateProductImageDto.getImageOrder());
                    // 设置主图标示
                    productImage.setMasterFlag(updateProductImageDto.getMasterFlag());
                    productImage.setModifyTime(updateProductImageDto.getModifyTime());
                    productImage.setModifyUserId(updateProductImageDto.getModifyUserId());
                    productImageMapper.updateProductImageById(productImage);
                }
            } else {
                updateProductImageDto.setCreateUserId(updateProductImageDto.getModifyUserId());
                updateProductImageDto.setCreateTime(updateProductImageDto.getModifyTime());
                this.saveProductImage(updateProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新产品某一张图片出错");
            throw new ProductServiceException("异常：更新产品某一张图片出错");
        }
    }

    @Override
    public void updateProductImages(List<ProductImageDto> updateProductImageDtos) throws ProductServiceException {
        logger.debug("updateProductImageDtos -> " + updateProductImageDtos);
        // 更新产品所有图片
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductImageDtos)) {
                logger.error("ProductImageService.updateProductImageDtos => 产品图片参数为空");
                throw new ProductServiceException("ProductImageService的updateProductImages方法参数为空");
            }
            for (ProductImageDto productImageDto : updateProductImageDtos) {
                this.updateProductImage(productImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新产品图片出错");
            throw new ProductServiceException("异常：更新产品图片出错");
        }

    }

    @Override
    public ProductImageDto loadProductImageById(Integer id) throws ProductServiceException {
        logger.debug("产品图片id -> " + id);
        // 更新产品所有图片
        ProductImageDto productImageDto = null;
        try {
            // 检查产品图片Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductImageService.updateProductImageDtos => 产品图片id参数为空");
                throw new ProductServiceException("产品图片id参数为空");
            }
            ProductImage productImage = productImageMapper.loadProductImageById(id);
            // 检查产品参数对象是否为空
            if (!ObjectUtils.isNullOrEmpty(productImage)) {
                productImageDto = new ProductImageDto();
                ObjectUtils.fastCopy(productImage, productImageDto);
            }
            return productImageDto;
        } catch (ProductServiceException e) {
            logger.error("依据图片ID查找产品图片出错");
            throw new ProductServiceException("异常：依据图片ID查找产品图片出错");
        }
    }

    @Override
    public List<ProductImageDto> listProductImagesByProductIdAndChannelCode(Integer productId, String channelCode)
            throws ProductServiceException {
        logger.debug("productId -> " + productId + "channelCode -> " + channelCode);
        try {
            // 检查产品参数产品Id是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductImageService.productId => 产品Id参数为空");
                throw new ProductServiceException(
                        "ProductImageService的listProductImagesByProductIdAndChannelCode方法参数productId为空");
            }
            // 检查产品参数产品编码渠道是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 查询产品所有图片
            List<ProductImage> listProductImage = productImageMapper.listProductImagesByProductIdAndChannelCode(productId,
                    channelCode);
            List<ProductImageDto> productImageDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listProductImage)) {
                productImageDtos = new ArrayList<ProductImageDto>();
                for (ProductImage productImage : listProductImage) {
                    ProductImageDto productImageDto = null;
                    if (!ObjectUtils.isNullOrEmpty(productImage)) {
                        productImageDto = new ProductImageDto();
                        ObjectUtils.fastCopy(productImage, productImageDto);
                        productImageDto.setImageUrl(productImage.getImageUrl1().replace("_1.", "."));
                        productImageDtos.add(productImageDto);
                    }
                }
            }
            return productImageDtos;
        } catch (ProductServiceException e) {
            logger.error("查询产品图片出错");
            throw new ProductServiceException("异常：查询产品图片出错");
        }
    }

    @Override
    public void deleteProductImageById(Integer id) throws ProductServiceException {
        logger.debug("产品图片id -> " + id);
        // 依据产品图片id删除图片
        try {
            // 检查产品图片Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductImageService.deleteProductImageById => 产品图片id参数为空");
                throw new ProductServiceException("产品图片id参数为空");
            }
            productImageMapper.deleteProductImageById(id);
        } catch (ProductServiceException e) {
            logger.error("依据图片ID删除产品图片出错");
            throw new ProductServiceException("异常：依据图片ID删除产品图片出错");
        }
    }

    @Override
    public void deleteProductImageByProductIdAndChannelCode(Integer productId, String channelCode)
            throws ProductServiceException {
        logger.debug("产品productId -> " + productId + "产品channelCode -> " + channelCode);
        // 删除产品该渠道所有图片
        try {
            // 检查产品图片Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductImageService.deleteProductImageByProductIdAndChannelCode => 产品productId参数为空");
                throw new ProductServiceException("产品productId参数为空");
            }
            // 检查产品图片渠道编码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            productImageMapper.deleteProductImageByProductIdAndChannelCode(productId, channelCode);
        } catch (ProductServiceException e) {
            logger.error("依据产品ID和渠道编码删除产品图片出错");
            throw new ProductServiceException("异常：依据产品ID和渠道编码删除产品图片出错");
        }
    }

    @Override
    public void updateMasterFlagById(String masterFlag, Date modifyTime, Integer id, Integer modifyUserId)
            throws ProductServiceException {
        logger.debug("产品主图标示 -> " + masterFlag + "产品id -> " + id + "产品修改人 -> " + modifyUserId + "产品修改时间 -> " + modifyTime);
        // 更新产品图片主图标示
        try {
            // 检查产品图片主图标示参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(masterFlag)) {
                logger.error("ProductImageService.updateMasterFlagById => 产品masterFlag参数为空");
                throw new ProductServiceException("产品图片主图标示masterFlag参数为空");
            }
            // 检查产品图片图片id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductImageService.updateMasterFlagById => 产品图片id参数为空");
                throw new ProductServiceException("产品图片id参数为空");
            }
            // 检查产品修改人id是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductImageService.updateMasterFlagById => 产品图片修改人modifyUserId参数为空");
                throw new ProductServiceException("产品图片修改人modifyUserId参数为空");
            }
            // 检查产品修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("ProductImageService.updateMasterFlagById => 产品图片修改时间modifyTime参数为空");
                throw new ProductServiceException("产品图片修改时间参数为空");
            }
            productImageMapper.updateMasterFlagById(masterFlag, modifyTime, id, modifyUserId);
        } catch (ProductServiceException e) {
            logger.error("更新产品图片主图标示出错");
            throw new ProductServiceException("异常：更新产品图片主图标示出错");
        }

    }

    @Override
    public void updateImageOrderById(Integer id, Integer imageOrder, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {
        logger.debug("产品图片顺序 -> " + imageOrder + "产品id -> " + id + "产品修改人 -> " + modifyUserId + "产品修改时间 -> " + modifyTime);
        // 更新产品图片主图标示
        try {
            // 检查产品图片顺序参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(imageOrder)) {
                logger.error("ProductImageService.updateImageOrderById => 产品imageOrder参数为空");
                throw new ProductServiceException("产品图片顺序imageOrder参数为空");
            }
            // 检查产品图片渠道编码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductImageService.updateImageOrderById => 产品图片id参数为空");
                throw new ProductServiceException("产品图片id参数为空");
            }
            // 检查产品修改人id是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductImageService.updateImageOrderById => 产品图片修改人modifyUserId参数为空");
                throw new ProductServiceException("产品图片顺序修改人modifyUserId参数为空");
            }
            // 检查产品修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("ProductImageService.updateImageOrderById => 产品图片顺序修改时间modifyTime参数为空");
                throw new ProductServiceException("产品图片顺序修改时间参数为空");
            }
            productImageMapper.updateImageOrderById(imageOrder, id, modifyTime, modifyUserId);
        } catch (ProductServiceException e) {
            logger.error("更新产品图片顺序出错");
            throw new ProductServiceException("异常：更新产品图片顺序出错");
        }
    }

    @Override
    public void deleteProductImageByImageUrl1(String imageUrl1) throws ProductServiceException {
        try {
            // 检查产品图片imageUrl1参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(imageUrl1)) {
                logger.error("ProductImageService.deleteProductImageByImageUrl1 => 产品图片imageUrl1参数为空");
                throw new ProductServiceException("产品图片imageUrl1参数为空");
            }
            productImageMapper.deleteProductImageByImageUrl1(imageUrl1);
        } catch (ProductServiceException e) {
            String msg = null == e.getMessage() ? "根据产品图片imageUrl1删除某一张图片信息出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
