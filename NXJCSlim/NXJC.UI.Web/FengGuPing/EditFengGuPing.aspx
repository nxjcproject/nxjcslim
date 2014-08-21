<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditFengGuPing.aspx.cs" Inherits="NXJC.UI.Web.FengGuPing.EditFengGuPing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/Scripts/EasyUI/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/EasyUI/jquery.min.js"></script>
    <script src="/Scripts/EasyUI/jquery.easyui.min.js"></script>
    <title></title>
    <script type="text/javascript">

        $(document).ready(function () {
            loadGridData('first');
        });

        $.extend($.fn.datagrid.methods, {
            editCell: function (jq, param) {
                return jq.each(function () {
                    var opts = $(this).datagrid('options');
                    var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor1 = col.editor;
                        if (fields[i] != param.field) {
                            col.editor = null;
                        }
                    }
                    $(this).datagrid('beginEdit', param.index);
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor = col.editor1;
                    }
                });
            }
        });

        var editIndex = undefined;
        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#dg').datagrid('validateRow', editIndex)) {
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field) {
            if (endEditing()) {
                $('#dg').datagrid('selectRow', index)
						.datagrid('editCell', { index: index, field: field });
                editIndex = index;
            }
        }

        function loadGridData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            var m_MsgData;
            $.ajax({
                type: "POST",
                url: "OnlineReportEditTemplate.aspx/GetUserInfoTemplate",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        $('#dg').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }
        function InitializeGrid(myData) {

            $('#dg').datagrid({
                data:myData
            });
        }

        function addItem() {
            $('#dg').datagrid('appendRow', {});
        }
        function deleteItem(index) {
            $('#dg').datagrid('deleteRow', index);
        }
        function saveItem() {
            endEditing();           //关闭正在编辑

            var insertRows = $('#gridMain_CellEdit').datagrid('getChanges', 'inserted');
            var updateRows = $('#gridMain_CellEdit').datagrid('getChanges', 'updated');
            var deleteRows = $('#gridMain_CellEdit').datagrid('getChanges', 'deleted');
            var changesRows = {
                inserted: [],
                updated: [],
                deleted: []
            };
            if (insertRows.length > 0) {
                for (var i = 0; i < insertRows.length; i++) {
                    changesRows.inserted.push(insertRows[i]);
                }
            }

            if (updateRows.length > 0) {
                for (var k = 0; k < updateRows.length; k++) {
                    changesRows.updated.push(updateRows[k]);
                }
            }

            if (deleteRows.length > 0) {
                for (var j = 0; j < deleteRows.length; j++) {
                    changesRows.deleted.push(deleteRows[j]);
                }
            }

            $.ajax({
                type: "POST",
                url: "OnlineReportEditTemplate.aspx/ChangeDataByGrid",
                data: "{myJsonData:'" + JSON.stringify(changesRows) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "1") {
                        alert("更新成功!");
                        //$('#dlg').dialog('close');
                    } else {
                        alert("更新失败!");
                    }
                }
            });

            //alert(JSON.stringify(changesRows));

            // 保存成功后，可以刷新页面，也可以：
            //$('#tt').datagrid('acceptChanges');
        }
    </script>
</head>
<body>
    <table id="dg" class="easyui-datagrid" title="Cell Editing in DataGrid" style="width:530px;height:auto"
			data-options="iconCls: 'icon-edit',singleSelect: true,rownumbers: true,striped: true,onClickCell: onClickCell, toolbar: '#tb'">
		<thead>
			<tr>
				<%--<th data-options="field:'itemid',width:80">Item ID</th>--%>
				<th data-options="field:'startTime',width:150,align:'center',
                    editor:{type:'textbox'}">起始时间</th>
                <th data-options="field:'endTime',width:150,align:'center',
                    editor:{ type:'textbox'}">终止时间</th>
				<th data-options="field:'unitcost',width:100,align:'center',
                    editor:{
                        type:'combobox',
                        options:{
                            valueField: 'label',
		                    textField: 'value',
		                    data: [{
			                    label: '峰',
			                    value: '峰'
		                    },{
			                    label: '谷',
			                    value: '谷'
		                    },{
			                    label: '平',
			                    value: '平'
		                    }]}
                    }">类型</th>
				<th data-options="field:'status',width:100,align:'center',editor:{type:'checkbox',options:{on:'启用',off:'禁用'}}">启用标志</th>
			</tr>
		</thead>
	</table>
    <div id="tb" style="padding:5px;height:auto">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
    </div>
</body>
</html>
