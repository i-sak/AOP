package com.isaac.mapper;

import org.apache.ibatis.annotations.Insert;

public interface SampleMapper {
	@Insert("insert into tb_sp1 (col) values (#{data}) ")
	public int insertCol(String data);
}
