package com.fh.service.topology.carbinet;

import java.util.List;

import com.fh.entity.topology.carbinet.CarbinetMenu;


/**
 * 说明：CarbinetService 菜单处理接口
 * @author FH
 */
public interface CarbinetManager {
	
	/**
	 * 列举出所有一级菜单
	 */
	public List<CarbinetMenu> listAllCarbinetTreeNode(String treeNodeId,List<CarbinetMenu> carbinetTreeNodeList)throws Exception;
	
	/**
	 * 列举出所有的子菜单
	 */
	public List<CarbinetMenu> listSubTreeNodeByParentId(String parentId)throws Exception;
	
	/**
	 * 查询出所有的数据
	 */
	public CarbinetMenu selectCarbinetTreeNodeById(String treeNodeId)throws Exception;
	
	/**
	 * 查询出所有的数据
	 */
	public List<CarbinetMenu> listAllCarbinetMenu()throws Exception;
	
	/**
	 * 添加树形菜单节点
	 */
	public void addTreeNode(CarbinetMenu menu)throws Exception;
	
	
	/**
	 * 删除树形菜单节点
	 */
	public void deleteTreeNode(CarbinetMenu menu)throws Exception;
	
	
	/**
	 * 修改树形菜单节点
	 */
	public void updateTreeNode(CarbinetMenu menu)throws Exception;
	
	
	/**
	 * 更新设备图片位置信息
	 */
	public void updateDevicePictureInfo(CarbinetMenu menu)throws Exception;
	
	
	/**
	 * 查询所有设备图片的位置信息
	 */
	public List<CarbinetMenu> getAllDevicePictureLocation(String parentId)throws Exception;
	
}
