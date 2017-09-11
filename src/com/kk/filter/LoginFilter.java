package com.kk.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter{
	String permitUrls[]=null;
	boolean ignore=false;
	String gotoUrl=null;

	public void destroy() {
		permitUrls=null;
		ignore=false;
		gotoUrl=null;

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest res=(HttpServletRequest) request;
		HttpServletResponse resp=(HttpServletResponse) response;
//        System.out.println("登录过滤器");

		if(!ignore){
			if(!isPermitUrl(request)){
				if(filterCurrUrl(request)){
					resp.sendRedirect(res.getContextPath()+gotoUrl);
					return ;
				}
			}
		}
		chain.doFilter(request, response);
	}

	public boolean isPermitUrl(ServletRequest request){
		boolean isPermit=false;

		if(permitUrls!=null&&permitUrls.length>0){
			for (int i = 0; i < permitUrls.length; i++) {
				if(permitUrls[i].equals(currentUrl(request))){
					isPermit=true;
					break;
				}
			}
		}
		return isPermit;
	}

	public boolean filterCurrUrl(ServletRequest request){

		boolean filter=false;
		HttpServletRequest res=(HttpServletRequest) request;
		Object user = res.getSession().getAttribute("user");
		if(null==user)
			filter=true;

		return filter;


	}

	//xx.jsp
	// servlet/aaServlet?task=11&bb=yy

	public String currentUrl(ServletRequest request){

		HttpServletRequest res=(HttpServletRequest) request;
		String task=request.getParameter("task");
		String path=res.getContextPath();
		String uri=res.getRequestURI();
		if(task!=null){//uri格式 xx/ser
			uri=uri.substring(path.length(), uri.length())+"?"+"task="+task;
		}else{
			uri=uri.substring(path.length(), uri.length());
		}
		//        System.out.println("当前请求地址:"+uri);
		return uri;
	}


	public void init(FilterConfig filterConfig) throws ServletException {
		String ignore =filterConfig.getInitParameter("ignore");
		String permitUrls =filterConfig.getInitParameter("permitUrls");
		String gotoUrl =filterConfig.getInitParameter("gotoUrl");

		if ("1".equals(ignore) || "yes".equals(ignore)||"true".equals(ignore)) {
			this.ignore = true;
		}
		if(permitUrls!=null&&permitUrls.length()>0);
		this.permitUrls=permitUrls.split(",");

		this.gotoUrl=gotoUrl;    
	}

}