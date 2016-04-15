package com.lsgx.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lsgx.admin.annotation.ActionLog;
import com.lsgx.admin.model.ActionFunction;
import com.lsgx.admin.model.ActionUser;
import com.lsgx.admin.service.ActionUserService;
import com.lsgx.admin.util.ActionUtil;
import com.lsgx.admin.util.JsonUtil;
import com.lsgx.admin.util.MD5;
import com.lsgx.admin.util.StringUtil;

@Controller
public class LoginController extends BaseController
{
    @Autowired
    private MainController mainController;
    
    @Autowired
    private ActionUserService actionUserService;

    @RequestMapping(value = "/login.do")
    public String login(HttpServletRequest req, HttpServletResponse resp, ModelMap model)
    {
        return "login/login";
    }

    @RequestMapping(value = "/adminlogin.do", method = RequestMethod.POST)
    @ActionLog(content = "登录")
    public String adminlogin(HttpServletRequest req, HttpServletResponse resp, ModelMap model)
    {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String rand = req.getParameter("rand");
        String randsession= (String) req.getSession().getAttribute("rand");

        if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password))
        {
            model.put("msg", "账户或密码为空");
            return "login/login";
        }
        if(StringUtil.isEmpty(rand)||!rand.equals(randsession)){
            model.put("msg", "验证码错误");
            return "login/login";
        }
        String pwd = MD5.encodeString(username + password);
        ActionUser users = actionUserService.queryUser(username, pwd);
        if (users != null)
        {
            saveAdmin(req, users);
            List<ActionFunction> funList = mainController.getUserActionFunctionList(users);
            String roleStr = mainController.listMenu(users);
            model.put("actionUser", users);
            model.put("userName", users.getUserName());
            model.put("roleStr", roleStr);
            req.getSession().setAttribute("ActionUser", users);
            if (funList != null && !funList.isEmpty())
            {
                Map<String, ActionFunction> funMap = new HashMap<String, ActionFunction>(funList.size());
                for (ActionFunction af : funList)
                {
                    funMap.put(af.getCode(), af);
                }
                req.getSession().setAttribute("funListSession", funMap);
            }
            return "index";
        }
        else
        {
            model.put("msg", "账户或密码错误");
            return "login/login";
        }
    }

    @RequestMapping(value = "/loginout.do")
    @ActionLog(content = "退出")
    public String adminloginout(HttpServletRequest req, HttpServletResponse resp, ModelMap model)
    {
        ActionUser admin = super.getActionUser(req);
        if (admin != null)
        {
            try
            {
                super.removeAdmin(req);
            }
            catch (Exception e)
            {
                saveAdmin(req, admin);
                return JsonUtil.toJSONString(ActionUtil.getAjaxToMap("300", "logOut faild", "", "", "", ""));
            }
        }
        return "login/login";
    }
    
    /**
     * 用户信息 修改密码
     * @param req
     * @param resp
     * @param model
     * @return
     */
    @RequestMapping(value = "/action/actionUserPwd.do", method = RequestMethod.POST)
    @ResponseBody
    @ActionLog(content = "修改用户密码")
    public String actionUserPwdPost(HttpServletRequest req, HttpServletResponse resp,
            ModelMap model){
        String id = req.getParameter("actionUser.id");
        String pwd = req.getParameter("actionUser.pwd");
        String pass = req.getParameter("actionUser.password");
        ActionUser user = actionUserService.userEdit(Integer.parseInt(id));
        if (!user.getPassword().equals(MD5.encodeString(user.getUserName() + pwd)))
        {
            saveLogDetail("旧密码输入有误,请重新输入.");
            return JsonUtil.toJSONString(ActionUtil.getAjaxToMap("300", "旧密码输入有误,请重新输入.", "", "", "", ""));
        }
        String password = MD5.encodeString(user.getUserName() + pass);
        user.setPassword(password);
        saveLogDetail("修改用户密码：" + user.toString());
        actionUserService.userInit(user);
        this.adminloginout(req, resp, model);
        return JsonUtil.toJSONString(ActionUtil.getAjaxToMap("200", "update password success,please login again", "", "", "closeCurrent", ""));
    }
    
    /**
     * 用户信息 修改密码页面
     * @param req
     * @param resp
     * @param model
     * @return
     */
    @RequestMapping(value = "/action/actionUserPwd.do", method = RequestMethod.GET)
    public String actionUserPwdGet(HttpServletRequest req,HttpServletResponse resp,
            ModelMap model){
        ActionUser au = super.getActionUser(req);
        model.put("actionUser", au);
        return "ActionUser/actionUserPwd";
    }
}

