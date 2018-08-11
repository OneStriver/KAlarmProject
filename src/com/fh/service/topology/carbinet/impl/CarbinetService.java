package com.fh.service.topology.carbinet.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.topology.carbinet.CarbinetMenu;
import com.fh.service.topology.carbinet.CarbinetManager;

/** 
 * 类名称：CarbinetService 菜单处理
 * 创建人：FH 
 */
@Service("carbinetService")
public class CarbinetService implements CarbinetManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 查询出数据库库中的所有节点包括子节点
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<CarbinetMenu> listAllCarbinetMenu() throws Exception {
		List<CarbinetMenu>	carbinetMenuList = (List<CarbinetMenu>)dao.findForList("CarbinetMapper.getCarbinetMenuList", null);
		return carbinetMenuList;
	}
	
	/**
	 * 添加节点
	 */
	@Override
	public void addTreeNode(CarbinetMenu menu) throws Exception {
		dao.save("CarbinetMapper.saveCarbinetTreeNode", menu);
	}
	
	/**
	 * 删除节点
	 */
	@Override
	public void deleteTreeNode(CarbinetMenu menu) throws Exception {
		dao.delete("CarbinetMapper.deleteCarbinetTreeNode", menu);
		
	}
	
	/**
	 * 更新节点
	 */
	@Override
	public void updateTreeNode(CarbinetMenu menu) throws Exception {
		dao.update("CarbinetMapper.updateCarbinetTreeNode", menu);
		
	}
	
	/**
	 * 查询当前节点下面的子节点以及子节点下面的子节点...
	 */
	@Override
	public List<CarbinetMenu> listAllCarbinetTreeNode(String treeNodeId,List<CarbinetMenu> carbinetTreeNodeList) throws Exception {
		List<CarbinetMenu> treeNodesList = this.listSubTreeNodeByParentId(treeNodeId);
		for (CarbinetMenu treeNode : treeNodesList) {
			carbinetTreeNodeList.add(treeNode);
			String nodeId = treeNode.getId();
			this.listAllCarbinetTreeNode(nodeId,carbinetTreeNodeList);
		}
		return carbinetTreeNodeList;
	}
	
	/**
	 * 查询出当前节点下面的节点
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<CarbinetMenu> listSubTreeNodeByParentId(@Param("treeNodeId")String treeNodeId) throws Exception {
		return (List<CarbinetMenu>)dao.findForList("CarbinetMapper.getCarbinetTreeNodeList", treeNodeId);
	}
	
	/**
	 * 根据树节点Id获取当前节点
	 */
	@Override
	public CarbinetMenu selectCarbinetTreeNodeById(@Param("treeNodeId")String treeNodeId) throws Exception {
		return (CarbinetMenu) dao.findForObject("CarbinetMapper.getCarbinetTreeNodeById", treeNodeId);
	}
	
	/**
	 * 更新图片的位置坐标信息
	 */
	@Override
	public void updateDevicePictureInfo(CarbinetMenu menu) throws Exception {
		dao.update("CarbinetMapper.updateDevicePictureInfo", menu);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CarbinetMenu> getAllDevicePictureLocation(@Param("parentId")String parentId) throws Exception {
		return (List<CarbinetMenu>)dao.findForList("CarbinetMapper.getAllDevicePictureLocation", parentId);
	}
	
	
}
