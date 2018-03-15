package org.aptech.shiro.permission.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aptech.shiro.permission.dao.SysPermissionDao;
import org.aptech.shiro.permission.pojo.SysPermission;
import org.aptech.shiro.permission.pojo.SysRole;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping("/permission")
public class SysPermissionController {
	
	@Resource
	private SysPermissionDao sysPermissionDao;

	public SysPermissionDao getSysPermissionDao() {
		return sysPermissionDao;
	}
	@RequestMapping("/index")
	public String index() throws Exception{
		return "syspermission/index";
	}
	@RequestMapping("/fufrom")
	public String fufrom() throws Exception{
		return "syspermission/syspermission_from";
	}
	@RequestMapping("/zifrom")
	public String zifrom() throws Exception{
		return "syspermission/from";
		
	}
	@RequestMapping("list")
	@ResponseBody
	public List<SysPermission> list() throws Exception{
		return sysPermissionDao.getAll();
		
	}
	@RequestMapping(value="/addfu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addfu(SysPermission sysPermission) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.addFu(sysPermission);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="/addzi",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addzi(SysPermission sysPermission) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.addZi(sysPermission);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/getById")
	@ResponseBody
	public SysPermission getById(Integer ids) throws Exception{
		return sysPermissionDao.getById(ids);
		
	}
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/editZi")
	@ResponseBody
	public Map<String, Object> editZi(SysPermission role){
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.updateZi(role);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/editFu")
	@ResponseBody
	public Map<String, Object> editFu(SysPermission role){
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.updateFu(role);
		map.put("result", true);
		return map;
	}
}
