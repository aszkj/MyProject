package com.yilidi.o2o.staticization.generator;

import java.util.List;

import com.yilidi.o2o.staticization.model.GenerateStaticFileModel;

/**
 * 静态化生成器接口
 * 
 * @author chenl
 * 
 */
public interface IStaticizationGenerator {

	public void generate(GenerateStaticFileModel generateStaticFileModel);

	public String generateBatch(List<GenerateStaticFileModel> generateStaticFileModelList);

}
