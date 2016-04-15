<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/common.jsp"%>
<script src="/ui/js/jquery-1.7.2.js" type="text/javascript"></script>
<script src="/ui/js/custom.pagination.js" type="text/javascript"></script>
<link href="/ui/themes/css/custom.pagination.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-cmn-Hans"  xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<title>绿色共享基金会</title>
<link type="text/css" rel="stylesheet" href="css/public.css">
<link type="text/css" rel="stylesheet" href="css/layout.css">
</head>
<script type="text/javascript">
    $(function () {
        function pageselectCallback(page_id, jq) {
//		$("#pageNum").val("2");
//		//alert("1");
//		$("#pagerForm").submit();
        }
        $("#Pagination").pagination(${page.total}, {
            callback: pageselectCallback,//PageCallback() 为翻页调用次函数。
            prev_text: " 上一页",
            next_text: "下一页 ",
            items_per_page: ${page.pageSize}, //每页的数据个数
            num_display_entries: 3, //两侧首尾分页条目数
            current_page: ${page.pageNum-1},   //当前页码
            num_edge_entries: 2, //连续分页主体部分分页条目数
            link_to:"?pageNum=__id__"
        });

    });

</script>
<body>
<header>
	<div class="wrap-top"></div>
    <div class="wrap-middle">
    	<header>
        	<div class="share-top">
            	<div class="share-left"><a href="javascript:void(0)"><img src="image/shared-logo.png" /></a></div>
                <div class="share-right"><img src="image/shared-logo-prop.png" /></div>
            </div>
            <div class="share-nav">
            	<ul class="shnav_left">
                	<li><a href="/index.do">首页</a></li>
                    <li><a href="/aboutus.do">关于我们</a></li>
                    <li><a href="/disclosure.do">信息批露</a></li>
                    <li><a href="/welfare.do">公益项目</a></li>
                    <li><a class="active" href="/poverty.do">专项基金</a></li>
                    <li><a href="/volunteers.do">志愿者</a></li>
                </ul>
                <div class="shnav_contact">
                咨询热线：0571-88900726
                </div>
            </div>
        </header>
    	<section>
        	<div class="about-intro-main">
            	<div class="about-intro-left">
                	<div class="intleft-title">专项基金</div>
                    <div class="intleft-conn">
                    	<ul>
                            <li><a class="active" href="#">致瑞扶贫基金</a></li>
                            <li><a  href="/povertyzqkm.do">智骐抗霾基金</a></li>
                            <li><a  href="/povertylsqt.do">绿色青藤残疾儿童艺术培训专项基金</a></li>
                        </ul>
                    </div>
                </div>
            	<div class="about-special-right">
                	<div class="special-title">致瑞扶贫基金</div>
                	<div class="special-conn">
                    	<img class="speco-img" src="image/Poverty-head.jpg" />
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;致瑞扶贫帮困助学基金是由杭州致瑞文化传播有限公司发起设立在浙江绿色共享教育基金会旗下的，该基金主要用于本省及全国贫困地区、贫困家庭突发事件的资助和帮困。其设立3年来用于白血病儿童、烧伤儿童、血管瘤宝宝、癫痫重症儿童、白马雪山藏族学校以及本省金华地区贫困大学新生等资金近百万元。
                    </div>
                    <div class="special-title">基金动态</div>
                    <div class="special-conn">
                        <ul>
                            <c:forEach items="${articleList}" var="bean">
                                <li>
                                    <div class="dyna-left"><img src="${bean.realUrl}" width="126px" height="83px"/></div>
                                    <div class="dyna-right">
                                        <h2><a href="/disclosuredetails.do?id=${bean.id}">${bean.title}</a><span><fmt:formatDate value="${bean.createtime}" pattern="yyyy-MM-dd"/></span></h2>

                                        <p><a href="/disclosurereport.do?id=${bean.id}">${bean.description}</a></p>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>

                    </div>
                    <div id="Pagination" class="flickr"></div>
                    <br>
                </div>
            </div>
        
        </section>
        <jsp:include page="/footer.do"/>
    
    </div>
	<div class="wrap-bottom"></div>
</header>
</body>
</html>
