﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditFengGuPing.aspx.cs" Inherits="NXJC.UI.Web.FengGuPing.EditFengGuPing" %>

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

        var m_MsgData;
        var editIndex = undefined;

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
            $.ajax({
                type: "POST",
                url: "EditFengGuPing.asmx/GetFGPValueForGrid",
                data: "{companyId: '1'}",
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
                data: myData,
                iconCls: 'icon-edit', singleSelect: true, rownumbers: true, striped: true, onClickCell: onClickCell, toolbar: '#tb',
                columns: [[
                    { field: 'StartTime', title: '起始时间', width: 150, align: 'center', editor: { type: 'timespinner', options: { showSeconds: true } } },
                    { field: 'EndTime', title: '终止时间', width: 150, align: 'center', editor: { type: 'timespinner', options: { showSeconds: true } } },
                    {
                        field: 'Type', title: '类型', width: 57, align: 'center',
                        formatter: function (value) {
                            if (value == 0)
                                return '峰';
                            else if (value == 1)
                                return '尖峰';
                            else if (value == 2)
                                return '谷';
                            else if (value == 3)
                                return '平';
                            else
                                return '';
                        },
                        editor: {
                            type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                    label: '峰',
                                    value: 0
                                }, {
                                    label: '尖峰',
                                    value: 1
                                }, {
                                    label: '谷',
                                    value: 2
                                }, {
                                    label: '平',
                                    value: 3
                                }]
                            }
                        }
                    },
                    {
                        field: 'Flag', title: '启用标志', width: 75, align: 'center',
                        formatter: function (value) {
                            if (value == true || value == "true")
                                return "启用";
                            else if (value == false || value == "false")
                                return "禁用";
                            else
                                return "";
                        },
                        editor: { type: 'checkbox', options: { on: true, off: false } }
                    },
                    {
                        field: 'action', title: '操作', width: 70, align: 'center',
                        formatter: function (value, row, index) {
                            var s = '<a href="#" onclick="deleteItem(' + index + ')">删除</a> ';
                            return s;
                        }
                    }
                ]]
            });
        }

        function addItem() {
            $('#dg').datagrid('appendRow', {});
        }
        function deleteItem(index) {
            $('#dg').datagrid('deleteRow', index);
        }
        function saveItem() {
            //alert('test');
            endEditing();           //关闭正在编辑

            var insertRows = $('#dg').datagrid('getChanges', 'inserted');
            var updateRows = $('#dg').datagrid('getChanges', 'updated');
            var deleteRows = $('#dg').datagrid('getChanges', 'deleted');
            var changesRows = {
                inserted: [],
                updated: [],
                deleted: []
            };
            if (insertRows.length > 0) {
                for (var i = 0; i < insertRows.length; i++) {
                    insertRows[i]["CompanyID"] = m_MsgData[1]["CompanyID"];
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
                url: "EditFengGuPing.asmx/SavePVFValues",
                data: "{myJsonData:'" + JSON.stringify(changesRows) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "1") {
                        alert("更新成功!");
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
    <table id="dg" class="easyui-datagrid" title="" style="width:530px;height:auto">
	</table>
    <div id="tb" style="padding:5px;height:auto">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
    </div>
</body>
</html>
