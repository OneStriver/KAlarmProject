package com.fh.controller.topology.carbinet;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.PageData;
import com.fh.entity.system.Menu;
import com.fh.entity.topology.carbinet.CarbinetMenu;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.topology.carbinet.CarbinetManager;
import com.fh.util.AppUtil;
import com.fh.util.RightsHelper;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/carbinet")
public class CarbinetTopologyController extends BaseController {

	String menuUrl = "menu.do"; // 菜单地址(权限用)
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "carbinetService")
	private CarbinetManager carbinetService;

	/**
	 * 显示菜单列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString())) ? "0"
					: pd.get("MENU_ID").toString();
			List<Menu> menuList = menuService.listSubMenuByParentId(MENU_ID);
			mv.addObject("pd", menuService.getMenuById(pd)); // 传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID);
			mv.addObject("MSG", null == pd.get("MSG") ? "list" : pd.get("MSG").toString()); // MSG=change
																							// 则为编辑或删除后跳转过来的
			mv.addObject("menuList", menuList);
			mv.setViewName("system/menu/menu_list");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 请求新增菜单页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString())) ? "0"
					: pd.get("MENU_ID").toString();// 接收传过来的上级菜单ID,如果上级为顶级就取值“0”
			pd.put("MENU_ID", MENU_ID);
			mv.addObject("pds", menuService.getMenuById(pd)); // 传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID); // 传入菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "add"); // 执行状态 add 为添加
			mv.setViewName("system/menu/menu_edit");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存菜单信息
	 * 
	 * @param menu
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/add")
	public ModelAndView add(Menu menu) throws Exception {
		logBefore(logger, "保存菜单");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			menu.setMENU_ID(String.valueOf(Integer.parseInt(menuService.findMaxId(pd).get("MID").toString()) + 1));
			menu.setMENU_ICON("menu-icon fa fa-leaf black");// 默认菜单图标
			menuService.saveMenu(menu); // 保存菜单
		} catch (Exception e) {
			logger.error(e.toString(), e);
			mv.addObject("msg", "failed");
		}
		mv.setViewName("redirect:/menu.do?MSG='change'&MENU_ID=" + menu.getPARENT_ID()); // 保存成功跳转到列表页面
		return mv;
	}

	/**
	 * 删除菜单
	 * 
	 * @param MENU_ID
	 * @param out
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(@RequestParam String MENU_ID) throws Exception {
		logBefore(logger, "删除菜单");
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "";
		try {
			if (menuService.listSubMenuByParentId(MENU_ID).size() > 0) {// 判断是否有子菜单，是：不允许删除
				errInfo = "false";
			} else {
				menuService.deleteMenuById(MENU_ID);
				errInfo = "success";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 请求编辑菜单页面
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(String id) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("MENU_ID", id); // 接收过来的要修改的ID
			pd = menuService.getMenuById(pd); // 读取此ID的菜单数据
			mv.addObject("pd", pd); // 放入视图容器
			pd.put("MENU_ID", pd.get("PARENT_ID").toString()); // 用作读取父菜单信息
			mv.addObject("pds", menuService.getMenuById(pd)); // 传入父菜单所有信息
			mv.addObject("MENU_ID", pd.get("PARENT_ID").toString()); // 传入父菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "edit");
			pd.put("MENU_ID", id); // 复原本菜单ID
			mv.setViewName("system/menu/menu_edit");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存编辑
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit(Menu menu) throws Exception {
		logBefore(logger, "修改菜单");
		ModelAndView mv = this.getModelAndView();
		try {
			menuService.edit(menu);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		mv.setViewName("redirect:/menu.do?MSG='change'&MENU_ID=" + menu.getPARENT_ID()); // 保存成功跳转到列表页面
		return mv;
	}

	/**
	 * 请求编辑菜单图标页面
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/toEditicon")
	public ModelAndView toEditicon(String MENU_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("MENU_ID", MENU_ID);
			mv.addObject("pd", pd);
			mv.setViewName("system/menu/menu_icon");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存菜单图标
	 */
	@RequestMapping(value = "/editicon")
	public ModelAndView editicon() throws Exception {
		logBefore(logger, "修改菜单图标");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd = menuService.editicon(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 显示页面左侧的z_tree树结构(机柜拓扑图)
	 */
	@RequestMapping(value = "/listCarbinetAllMenu")
	public ModelAndView listCarbinetAllMenu(Model model) throws Exception {
		ModelAndView mv = this.getModelAndView();
		try {
			JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
			String json = arr.toString();
			System.err.println(json);
			model.addAttribute("carbinetNodes", json);
			mv.setViewName("topologyManage/carbinet_ztree");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 添加树形菜单的节点
	 */
	@RequestMapping(value = "/addCarbinetTreeNode",produces={"text/html;charset=UTF-8;"})
	@ResponseBody
	public String addCarbinetTreeNode(CarbinetMenu menu) throws Exception {
		logBefore(logger, "新增树形菜单节点");
		try {
			menu.setId(String.valueOf((new Date()).getTime()));
			carbinetService.addTreeNode(menu); // 保存菜单
			//再次查询出现在所有的数据
			JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
			String jsonStr = arr.toString();
	        return jsonStr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 刷新所有的树形菜单节点
	 */
	@RequestMapping(value = "/refreshCarbinetTree",produces={"text/html;charset=UTF-8;"})
	@ResponseBody
	public String refreshCarbinetTree() throws Exception {
		logBefore(logger, "刷新树形菜单");
		JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
		String jsonStr = arr.toString();
        return jsonStr;
	}
	
	/**
	 * 修改树形菜单的节点
	 */
	@RequestMapping(value = "/updateCarbinetTreeNode",produces={"text/html;charset=UTF-8;"})
	@ResponseBody
	public String updateCarbinetTreeNode(CarbinetMenu menu) throws Exception {
		logBefore(logger, "修改树形菜单节点");
		try {
			carbinetService.updateTreeNode(menu); // 保存菜单
			//再次查询出现在所有的数据
			JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
			String jsonStr = arr.toString();
	        return jsonStr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 删除树形菜单的节点
	 */
	@RequestMapping(value = "/deleteCarbinetTreeNode",produces={"text/html;charset=UTF-8;"})
	@ResponseBody
	public String deleteCarbinetTreeNode(CarbinetMenu menu) throws Exception {
		logBefore(logger, "删除树形菜单该节点和下面的子节点");
		try {
			List<CarbinetMenu> carbinetList = new ArrayList<CarbinetMenu>();
			CarbinetMenu parentTreeNode = carbinetService.selectCarbinetTreeNodeById(menu.getId());
			carbinetList.add(parentTreeNode);
			List<CarbinetMenu> allCarbinetTreeNode = carbinetService.listAllCarbinetTreeNode(menu.getId(),carbinetList);
			for (CarbinetMenu singleCarbinetNode : allCarbinetTreeNode) {
				carbinetService.deleteTreeNode(singleCarbinetNode);
			}
			//再次查询出现在所有的数据
			JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
			String jsonStr = arr.toString();
	        return jsonStr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 修改图片的位置坐标信息
	 */
	@RequestMapping(value = "/updateDevicePictureInfo",produces={"text/html;charset=UTF-8;"})
	@ResponseBody
	public String updateDevicePictureInfo(@RequestBody List<CarbinetMenu> menus) throws Exception {
		logBefore(logger, "更新图片位置坐标信息");
		for (CarbinetMenu carbinetMenu : menus) {
			carbinetService.updateDevicePictureInfo(carbinetMenu);
		}
		//再次查询出现在所有的数据
		JSONArray arr = JSONArray.fromObject(carbinetService.listAllCarbinetMenu());
		String jsonStr = arr.toString();
		return jsonStr;
	}
	
	/**
	 * 查询所有设备图片的位置信息
	 */
	@RequestMapping(value = "/getAllDevicePictureLocation")
	@ResponseBody
	public List<CarbinetMenu> getAllDevicePictureLocation() throws Exception {
		logBefore(logger, "查询图片位置坐标信息");
		//再次查询出现在所有的数据
		List<CarbinetMenu> allDevicePictureLocation = carbinetService.getAllDevicePictureLocation("1");
		return allDevicePictureLocation;
	}
	
	/**
	 * 根据角色权限获取本权限的菜单列表(递归处理)
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList, String roleRights) {
		for (int i = 0; i < menuList.size(); i++) {
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			if (menuList.get(i).isHasMenu() && "1".equals(menuList.get(i).getMENU_STATE())) { // 判断是否有此菜单权限并且是否隐藏
				this.readMenu(menuList.get(i).getSubMenu(), roleRights); // 是：继续排查其子菜单
			} else {
				menuList.remove(i);
				i--;
			}
		}
		return menuList;
	}

}
