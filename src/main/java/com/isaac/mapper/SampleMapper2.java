package com.isaac.mapper;

import org.apache.ibatis.annotations.Insert;

public interface SampleMapper2 {
	@Insert("insert into tb_sp2 (col) values (#{data}) ")
	public int insertCol(String data);
}
