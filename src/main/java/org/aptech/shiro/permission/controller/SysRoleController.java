package org.aptech.shiro.permission.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aptech.shiro.permission.dao.SysPermissionDao;
import org.aptech.shiro.permission.dao.SysRoleDao;
import org.aptech.shiro.permission.pojo.SysRole;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/role")
public class SysRoleController {
	@Resource
	private SysRoleDao sysRoleDao;
	@Resource
	private SysPermissionDao sysPermissionDao;
	
	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}
	public void setSysRoleDao(SysRoleDao sysRoleDao) {
		this.sysRoleDao = sysRoleDao;
	}
	@RequestMapping("index")
	public String Index() throws Exception{
		return "sysrole/index";
		
	}
	@RequestMapping(value="/form",method=RequestMethod.GET)
	public String form() throws Exception {
		return "sysrole/sysrole_from";
	}
	@RequestMapping("/all")
	@ResponseBody
	public List<SysRole> all() throws Exception {
		return sysRoleDao.getAll();
	}
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysRole role){
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.add(role);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysRole role){
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.update(role);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/assign")
	@ResponseBody
	public Map<String, Object> assign(Integer roleId,Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		sysPermissionDao.deletePermissionsByRoleId(roleId);
		sysPermissionDao.addRolePermissions(roleId, Arrays.asList(ids));
		map.put("result", true);
		return map;
	}
	@RequestMapping("/toAssign")
	public String toAssign(Integer rid,ModelMap modelMap) throws Exception{
		modelMap.put("roleId", rid);
		return "sysrole/assign";
		
	}
	@RequestMapping("/getPermissions")
	@ResponseBody
	public List<Integer> selectPermission(Integer roleId) throws Exception{
		return sysPermissionDao.getPermissionIdsByRoleId(roleId);
		
	}
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/view")
	@ResponseBody
	public SysRole view(Integer id) throws Exception {
		return sysRoleDao.getById(id);
	}
}






