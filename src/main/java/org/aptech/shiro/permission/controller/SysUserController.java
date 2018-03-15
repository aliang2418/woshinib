package org.aptech.shiro.permission.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.aptech.shiro.permission.dao.SysUserDao;
import org.aptech.shiro.permission.pojo.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class SysUserController {
	@Resource
	private SysUserDao sysUserDao;

	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index() throws Exception {
		return "sysuser/index";
	}
	
	@RequestMapping(value="/form",method=RequestMethod.GET)
	public String form() throws Exception {
		return "sysuser/sysuser_form";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(Integer page, Integer rows,@RequestParam(defaultValue="id") String sort,@RequestParam(defaultValue="asc") String order,SysUser condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		int start = (page - 1) * rows;
		List<SysUser> list = sysUserDao.getListByCondition(start, rows, condition, sort, order);
		int total = sysUserDao.getCountByCondition(condition);
		
		map.put("rows", list);
		map.put("total", total);
		
		return map;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysUser user,Integer[] roleIds){
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.add(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		
		map.put("result", true);
		return map;
	}
	
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysUser user,Integer[] roleIds){
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.update(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		map.put("result", true);
		return map;
	}
	
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		sysUserDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/view")
	@ResponseBody
	public SysUser view(Integer id) throws Exception {
		return sysUserDao.getById(id);
	}
	
}






