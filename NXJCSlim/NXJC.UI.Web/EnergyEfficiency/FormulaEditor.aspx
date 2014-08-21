<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormulaEditor.aspx.cs" Inherits="NXJC.UI.Web.EnergyEfficiency.FormulaEditor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>公式编辑</title>
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
<body>
    <form id="form1" runat="server">
    <div>
	<div style="margin:20px 0;">
        <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="iconCls:'icon-reload'" title="从其他公式组载入。" onclick="$('#dlg').dialog('open')">载入</a> | 
		名称：<input id="vv" class="easyui-validatebox textbox" data-options="required:true,validType:'length[3,50]'" /> | 

        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="">暂存</a> | 
        <a href="javascript:void(0)" class="easyui-linkbutton c4 easyui-tooltip tooltip-f" data-options="iconCls:'icon-ok'" title="提交后不可修改，请谨慎操作。" onclick="">提交</a>
	</div>
	<table id="tg" class="easyui-treegrid" title="公式录入" style="width:100%;height:250px"
			data-options="
				iconCls: 'icon-edit',
				rownumbers: true,
				animate: true,
				fitColumns: true,
				url: 'treegrid_data2.htm',
				method: 'get',
				idField: 'id',
				treeField: 'name',
				onContextMenu: onContextMenu,
                onDblClickRow: edit,
                onClickRow: save
			">
		<thead>
			<tr>
                <th data-options="field:'id',width:50">层次码</th>
				<th data-options="field:'name',width:180,editor:'text'">工序名称</th>
				<th data-options="field:'progress',width:180,formatter:formatProgress,editor:'text'">公式</th>
			</tr>
		</thead>
	</table>
	<div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
		<div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
		<div class="menu-sep"></div>
        <div onclick="appendRoot()" data-options="iconCls:'icon-add'">添加根工序</div>
        <div class="menu-sep"></div>
		<div onclick="collapse()">收起</div>
		<div onclick="expand()">展开</div>
	</div>

    <div id="dlg" class="easyui-dialog" title="载入公式组" style="width:500px;height:500px;" 
        data-options="
            iconCls:'icon-reload',
            modal:true,
            closed:true
        " >
	    <table class="easyui-datagrid" style="width:100%;height:100%"
			    data-options="singleSelect:true,url:'datagrid_data1.json',method:'get'">
		    <thead>
			    <tr>
				    <th data-options="field:'itemid',hidden:true">Item ID</th>
				    <th data-options="field:'productid',width:260">公式组名称</th>
				    <th data-options="field:'listprice',width:100">创建时间</th>
				    <th data-options="field:'status',width:100,align:'center'">状态</th>
			    </tr>
		    </thead>
	    </table>
	</div>


	<script type="text/javascript">
	    function formatProgress(value) {
	        var validateResult = validateExpression(value);
	        
	        if (validateResult == "success") {
	            var s = '<div style="width:100%;">' + value;
	            s += '<div style="float:right;width:16px;height:16px;" class="icon-ok"></div></div>';
	            return s;
	        }
	        else {
	            var s = '<div style="width:100%;">' + value;
	            s += '<div title="' + validateResult + '" class="easyui-tooltip icon-no" style="float:right;width:16px;height:16px;"></div></div>';
	            return s;
	        }
	    }
	    function onContextMenu(e, row) {
	        e.preventDefault();
	        $(this).treegrid('select', row.id);
	        $('#mm').menu('show', {
	            left: e.pageX,
	            top: e.pageY
	        });
	    }
	    var idIndex = 100;
	    function appendRoot() {
	        idIndex++;
	        $('#tg').treegrid('append', {
	            data: [{
	                id: idIndex,
	                name: '请输入工序名称：' + idIndex,
	                progress: ''
	            }]
	        })
	    }
	    function append() {
	        idIndex++;
	        var node = $('#tg').treegrid('getSelected');
	        $('#tg').treegrid('append', {
	            parent: node.id,
	            data: [{
	                id: idIndex,
	                name: '新工序',
	                progress: ''
	            }]
	        })
	    }
	    function removeIt() {
	        var node = $('#tg').treegrid('getSelected');
	        if (node) {
	            $('#tg').treegrid('remove', node.id);
	        }
	    }
	    function collapse() {
	        var node = $('#tg').treegrid('getSelected');
	        if (node) {
	            $('#tg').treegrid('collapse', node.id);
	        }
	    }
	    function expand() {
	        var node = $('#tg').treegrid('getSelected');
	        if (node) {
	            $('#tg').treegrid('expand', node.id);
	        }
	    }
        ///////////////////////////////////////////////////////////
	    var editingId;
	    function edit() {
	        if (editingId != undefined) {
	            $('#tg').treegrid('select', editingId);
	            return;
	        }
	        var row = $('#tg').treegrid('getSelected');
	        if (row) {
	            editingId = row.id
	            $('#tg').treegrid('beginEdit', editingId);
	        }
	    }
	    function save() {
	        if (editingId != undefined) {
	            var t = $('#tg');
	            t.treegrid('endEdit', editingId);
	            editingId = undefined;

	            $('.easyui-tooltip').tooltip({ position: 'left' });
	        }
	    }
	    function cancel() {
	        if (editingId != undefined) {
	            $('#tg').treegrid('cancelEdit', editingId);
	            editingId = undefined;
	        }
	    }

        // 验证公式合法性
	    function validateExpression(expression) {
	        var queryUrl = 'FormulaService.asmx/ValidateExpression';
	        var dataToSend = '{expression: "' + expression + '"}';
	        var result = '验证服务不可用';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            async: false,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                result = msg.d;
	            }
	        });

	        return result;
	    }

	</script>
    </div>
    </form>
</body>
</html>
