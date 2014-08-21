﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomAnalyseItem.aspx.cs" Inherits="NXJC.UI.Web.ProcessDataAnalyse.CustomAnalyseItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>自定义过程数据分析项</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#productLineName').combobox({
                onSelect: queryProductLine
            });

            $('#labelSelectedList').datagrid({
                onDblClickRow: onLabelSelectedDoubleClicked
            });
        });

        function queryProductLine() {
            var productLineId = $('#productLineName').combobox('getValue');
            var queryUrl = 'CustomAnalyseItem.asmx/GetLabelsWithTreeGridFormat';
            var dataToSend = '{productLineId: '+ productLineId +'}';

            $.ajax({
                type: "POST",
                url: queryUrl,
                data: dataToSend,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    initializeLabelSelector(jQuery.parseJSON(msg.d));
                }
            });
        }

        function initializeLabelSelector(jsonData) {
            $('#labelSelector').treegrid({
                data: jsonData,
                dataType: "json",
                onDblClickRow: onLabelDoubleClicked
            });
        };

        // 标签候选列表双击事件
        function onLabelDoubleClicked(row) {
            var productLineId = $('#productLineName').combobox('getValue');
            var productLineName = $('#productLineName').combobox('getText');
            appendToLabelSelectedList(productLineId, productLineName, row['VariableName'], row['FieldName']);
        };

        // 标签已选列表双击事件
        function onLabelSelectedDoubleClicked(rowIndex, rowData) {
            $('#labelSelectedList').datagrid('deleteRow', rowIndex);
        };

        // 追加标签项至已选择标签列表
        function appendToLabelSelectedList(_productLineId, _productLineName, _labelName, _name) {
            if (_labelName == null || _name == null)
                return;

            // 最多只能添加8条标签项
            if ($('#labelSelectedList').datagrid('getRows').length >= 8) {
                $.messager.alert('警告', '最多只能添加8项！', 'warning');
                return;
            }

            $('#labelSelectedList').datagrid('appendRow', {
                productLineId: _productLineId,
                productLineName: _productLineName,
                labelName: _labelName,
                name: _name
            });
        };
    </script>
    <style>
        body {
            font-size: 80%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100%; padding-left: 3px; margin-bottom: 10px;">
        生产线： <input id="productLineName" class="easyui-combobox"
                        data-options="valueField:'ID',textField:'Name', editable: false,
                                      url:'CustomAnalyseItem.asmx/GetProductLinesWithComboboxFormat'" />
        <!--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="queryProductLine();">查询</a>-->
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;float:right;" onclick="$('#w').window('open');">提交</a>
    </div>
    <div style="width: 49%; float: left;">
        <table id="labelSelector" title="选择分析标签" class="easyui-treegrid" style="width:100%;height:260px;"
			    data-options="method: 'post', rownumbers: true, idField: 'guid', treeField: 'VariableName'">
		    <thead>
			    <tr>
				    <th data-options="field:'VariableName', width:220">变量名</th>
				    <th data-options="field:'FieldName', width:220">标签名</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    <div style="width: 49%; float: right;">
	    <table id="labelSelectedList" class="easyui-datagrid" title="已选择标签项" style="width:100%;height:260px; margin-left: 10px;"
			    data-options="singleSelect:true,rownumbers: true">
		    <thead>
			    <tr>
                    <th data-options="field:'productLineId',hidden:true"></th>
				    <th data-options="field:'productLineName',width:100">生产线名称</th>
				    <th data-options="field:'labelName',width:150">变量名</th>
				    <th data-options="field:'name',width:150">标签名</th>
			    </tr>
		    </thead>
	    </table>
    </div>

	<div id="w" class="easyui-window" title="过程数据分析" data-options="closed:true" style="width:500px;height:200px;padding:10px;">
		这里放分析图形
	</div>

    </form>
</body>
</html>
