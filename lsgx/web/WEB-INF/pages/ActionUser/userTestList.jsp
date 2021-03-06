<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common/common.jsp"%>

<script type="text/javascript">
document.onkeydown=banBackSpace;
function resetQuery()
{
	$("#name").val("");
}
</script>
<div class="pageHeader">
<form id="pagerForm" method="post" action="action/userTestList.do">
	<input type="hidden" name="pageNum" value="${page.pageNum }" />
	<input type="hidden" name="numPerPage" value="${page.pageSize}" />
	<input type="hidden" name="orderField" value="${orderField}" />
	<input type="hidden" name="orderDirection" value="${orderDirection}" />
	<input type="hidden" name="username" value="${userTest.username}" />
</form>
	<div class="searchBar">
		<form method="post" action="action/userTestList.do" onsubmit="return navTabSearch(this);">
			<table class="searchContent">
				<tr>
					<td>
						登录名1:
						<input type="text" class="textInput" style="width:100px" id="name" name="username" value="${userTest.username}"></td>
					<td>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">检索</button>
							</div>
						</div>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" onclick="resetQuery()">重置</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<!-- 权限 -->
			<priveliege:enable buttonCode="usertestAdd">
				<li><a class="add" href="/action/userTestAdd.do" target="dialog" rel="addUsertest" title="添加用户" mask=true width="550" height="340"><span>添加用户</span></a></li>
			</priveliege:enable>
			<priveliege:enable buttonCode="usertestEdit">
				<li><a class="edit" href="/action/userTestEditGET.do?id={list_item_id}" target="dialog" rel="usertestEdit" title="编辑用户" mask=true width="550" height="340"><span>编辑用户</span></a></li>
			</priveliege:enable>
			<priveliege:enable buttonCode="usertestDel">
				<li><a class="delete" href="/action/userTestDelete.do?id={list_item_id}" target="ajaxTodo" rel="usertestDel" title="删除用户"><span>删除用户</span></a></li>
			</priveliege:enable>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="115">
		<thead>
			<tr >
				<th width="80">登录名</th>
				<th width="80">真实姓名</th>
				<th width="80">性别</th>
				<th width="80">联系方式</th>
				<th width="80">生日</th>
				<th width="80">创建者</th>
				<th width="100">创建时间</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userList}" var="bean">
				<tr target="list_item_id" rel="${bean.id}">
					<td>
						<a
							href="action/actionUserDetail.do?id=${bean.id}"
							target="dialog" width="280" height="260" style="color:blue;"
							rel="show_project" title="管理员详情"  resizable="true" mask="true"
							maxable="false" drawable="true">${bean.username }
							<c:if test="${bean.username == ''}">点击查看详情</c:if>
						</a>
					</td>
					<td>${bean.username }</td>
				    <td>
				    	<c:if test="${bean.sex==1}">男</c:if>
				    	<c:if test="${bean.sex==2}">女</c:if>
				    </td>
				    <td>${bean.address }</td>
				    <td>
						<fmt:formatDate value="${bean.birthday}" pattern="yyyy-MM-dd"/>
				    </td>
				    <td>

				    </td>
				    <td>

				    </td>
				    <td>

				    </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:import url="../common/panelBar.jsp" />
</div>
