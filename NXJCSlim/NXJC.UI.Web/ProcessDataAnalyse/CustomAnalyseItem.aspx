<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomAnalyseItem.aspx.cs" Inherits="NXJC.UI.Web.ProcessDataAnalyse.CustomAnalyseItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        function queryProductLine() {
            var productLineName = $('#productLineName').combobox('getText');
            $('#labelSelector').treegrid({
                url: 'treegrid_data1.htm',
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        生产线： <input id="productLineName" class="easyui-combobox" style="width:100px"
					url="data/combobox_data.json"
					valueField="Id" textField="Name">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="queryProductLine();">查询</a>
        <br />
        <table id="labelSelector" title="选择分析标签" class="easyui-treegrid" style="width:700px;height:250px"
			    data-options="
				    method: 'get',
				    rownumbers: true,
				    idField: 'id',
				    treeField: 'name'
			    ">
		    <thead>
			    <tr>
				    <th data-options="field:'name'" width="220">Name</th>
				    <th data-options="field:'size'" width="100" align="right">Size</th>
				    <th data-options="field:'date'" width="150">Modified Date</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    </form>
</body>
</html>
