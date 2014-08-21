<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormulaGroups.aspx.cs" Inherits="NXJC.UI.Web.EnergyEfficiency.FormulaGroups" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>公式组列表</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <style>
        body {
            font-size: 80%;
        }
        .textbox{
			height:20px;
			margin:0;
			padding:0 2px;
			box-sizing:content-box;
		}
    </style>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
	<div data-options="region:'east',split:true,title:'公式组使用状态'" style="width:40%">
	    <table class="easyui-datagrid" title="正在使用中的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'">
		    <thead>
			    <tr>
				    <th data-options="field:'itemid',hidden:true">Item ID</th>
				    <th data-options="field:'productid',width:200">公式组名称</th>
				    <th data-options="field:'listprice',width:80">生效时间</th>
				    <th data-options="field:'unitcost',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40">查看</th>
			    </tr>
		    </thead>
	    </table>
	    <table class="easyui-datagrid" title="即将启用的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true,collapsed:true,url:'datagrid_data1.json',method:'get'">
		    <thead>
			    <tr>
				    <th data-options="field:'itemid',hidden:true">Item ID</th>
				    <th data-options="field:'productid',width:200">公式组名称</th>
				    <th data-options="field:'listprice',width:80">生效时间</th>
				    <th data-options="field:'unitcost',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40">查看</th>
			    </tr>
		    </thead>
	    </table>
	    <table class="easyui-datagrid" title="即将停用的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true,collapsed:true,url:'datagrid_data1.json',method:'get'">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true">Item ID</th>
				    <th data-options="field:'productid',width:200">公式组名称</th>
				    <th data-options="field:'listprice',width:80">生效时间</th>
				    <th data-options="field:'unitcost',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40">查看</th>
			    </tr>
		    </thead>
	    </table>
	</div>
    <div data-options="region:'center'">
	    <table class="easyui-datagrid" title="公式组列表" style="width:100%;height:100%"
			    data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get',toolbar:toolbar">
		    <thead>
			    <tr>
				    <th data-options="field:'itemid',hidden:true">Item ID</th>
				    <th data-options="field:'productid',width:260">公式组名称</th>
				    <th data-options="field:'listprice',width:100">创建时间</th>
				    <th data-options="field:'unitcost',width:80">状态</th>
                    <th data-options="field:'unitcost',width:80">操作</th>
				    <th data-options="field:'attr1',width:80">查看</th>
			    </tr>
		    </thead>
	    </table>
    </div>
	<script type="text/javascript">
	    var toolbar = [{
	        text: '新增公式组',
	        iconCls: 'icon-add',
	        handler: function () { self.location = 'FormulaEditor.aspx'; }
	    }, '-', {
	        text: '删除公式组',
	        iconCls: 'icon-clear',
	        handler: function () { alert('save') }
	    }];
	</script>
    </form>
</body>
</html>
