package com.isaac.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.isaac.mapper.SampleMapper;
import com.isaac.mapper.SampleMapper2;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService{

	@Setter(onMethod_ = @Autowired)
	private SampleMapper mapper1;
	
	@Setter(onMethod_ = @Autowired)
	private SampleMapper2 mapper2;
	
	@Transactional
	@Override
	public void addData(String value) {
		log.info("mapper2..............");
		mapper2.insertCol(value);
		log.info("mapper1..............");
		mapper1.insertCol(value);
		log.info("....end..............");
	}

}
