<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	var modifyPwdDialog;
	var modifyPwdForm;
	var modifyUserRoleDialog;
	var modifyUserRoleForm;
	var modifyUserRoleCombobox;
	
	$(function() {

		searchForm = $('#searchForm').form();

		datagrid = $('#datagrid').datagrid({
			url : 'userAction!datagrid.action',
			title : '用户列表(admin拥有所有权限，不需要更改角色)',
			iconCls : 'icon-save',
			striped : true,
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'cid',
			sortName : 'cname',
			sortOrder : 'desc',
			frozenColumns : [ [ {
				title : '编号',
				field : 'cid',
				width : 150,
				sortable : true,
				checkbox : true
			}, {
				title : '姓名',
				field : 'cname',
				width : 150,
				sortable : true,
				editor : {
					type : 'validatebox',
					options : {
						required : true
					}
				}
			} ] ],
			columns : [ [ {
				title : '密码',
				field : 'cpwd',
				width : 150,
				formatter : function(value, rowData, rowIndex) {
					return '******';
				}
			}, {
				title : '创建时间',
				field : 'ccreatedatetime',
				sortable : true,
				width : 150,
				formatter : function(value, rowData, rowIndex) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			}, {
				title : '最后修改时间',
				field : 'cmodifydatetime',
				sortable : true,
				width : 150,
				formatter : function(value, rowData, rowIndex) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			}, {
				title : '所属角色',
				field : 'roleIds',
				width : 150,
				formatter : function(value, rowData, rowIndex) {
					if (rowData.roleNames) {
						return sy.fs('<span title="{0}">{1}</span>', rowData.roleNames, rowData.roleNames);
					}
				},
				editor : {
					type : 'multiplecombobox',
					options : {
						url : 'roleAction!roleCombobox.action',
						valueField : 'cid',
						textField : 'cname'
					}
				}
			}, {
				title : '所属角色',
				field : 'roleNames',
				width : 150,
				hidden : true
			},{
				title : '工作单位',
				field : 'cworkplace',
				width : 150
			} ,{
				title : '电子邮件',
				field : 'cemail',
				width : 150
			},{
				title : '通信地址',
				field : 'caddress',
				width : 150
			},{
				title : '联系电话',
				field : 'ctelphone',
				width : 150
			}, {
				title : '所属分组',
				field : 'cgroupid',
				width : 150,
				/*formatter : function(value, rowData, rowIndex) {
					return rowData.groupName;
				}, */
				editor : {
					type : 'combobox',
					options : {
						url : '${pageContext.request.contextPath}/jslib/groupid.json',
						valueField : 'id',
						textField : 'text'
					}
				}
			}] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('rejectChanges');
					editRow = undefined;
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-', {
				text : '修改密码',
				iconCls : 'icon-edit',
				handler : function() {
					var rows = datagrid.datagrid('getSelections');
					var ids = [];
					if (rows.length > 0) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].cid);
						}
						modifyPwdForm.find('input[name=ids]').val(ids.join(','));
						modifyPwdDialog.dialog('open');
					}
				}
			}, '-', {
				text : '批量改角色',
				iconCls : 'icon-edit',
				handler : function() {
					var rows = datagrid.datagrid('getSelections');
					var ids = [];
					if (rows.length > 0) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].cid);
						}
						modifyUserRoleForm.find('input[name=ids]').val(ids.join(','));
						modifyUserRoleCombobox.combobox({
							url : 'roleAction!roleCombobox.action'
						});
						modifyUserRoleDialog.dialog('open');
					}
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}

				if (editRow == undefined) {
					changeEditorEditRow();/*改变editor*/
					datagrid.datagrid('beginEdit', rowIndex);
					editRow = rowIndex;
					datagrid.datagrid('unselectAll');
				}
			},
			onAfterEdit : function(rowIndex, rowData, changes) {
				var inserted = datagrid.datagrid('getChanges', 'inserted');
				var updated = datagrid.datagrid('getChanges', 'updated');
				if (inserted.length < 1 && updated.length < 1) {
					editRow = undefined;
					datagrid.datagrid('unselectAll');
					return;
				}

				var url = '';
				if (inserted.length > 0) {
					url = 'userAction!add.action';
				}
				if (updated.length > 0) {
					url = 'userAction!edit.action';
				}

				$.ajax({
					url : url,
					data : rowData,
					dataType : 'json',
					success : function(r) {
						if (r.success) {
							datagrid.datagrid('acceptChanges');
							$.messager.show({
								msg : r.msg,
								title : '成功'
							});
							editRow = undefined;
							datagrid.datagrid('reload');
						} else {
							/*datagrid.datagrid('rejectChanges');*/
							datagrid.datagrid('beginEdit', editRow);
							$.messager.alert('错误', r.msg, 'error');
						}
						datagrid.datagrid('unselectAll');
					}
				});

			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
		/*$('.datagrid-header div').css('textAlign', 'center');*/

		modifyPwdForm = $('#modifyPwdForm').form({
			url : 'userAction!modifyPwd.action',
			success : function(data) {
				var d = $.parseJSON(data);
				modifyPwdDialog.dialog('close');
				$.messager.show({
					msg : d.msg,
					title : '提示'
				});
			}
		});

		modifyPwdDialog = $('#modifyPwdDialog').show().dialog({
			modal : true,
			title : '批量修改密码',
			buttons : [ {
				text : '修改',
				handler : function() {
					modifyPwdForm.submit();
				}
			} ]
		}).dialog('close');

		modifyUserRoleCombobox = $('#modifyUserRoleCombobox').combobox({
			valueField : 'cid',
			textField : 'cname',
			multiple : true,
			editable : false,
			panelHeight : 'auto'
		});

		modifyUserRoleForm = $('#modifyUserRoleForm').form({
			url : 'userAction!modifyUserRole.action',
			success : function(data) {
				var d = $.parseJSON(data);
				datagrid.datagrid('reload');
				modifyUserRoleDialog.dialog('close');
				$.messager.show({
					msg : d.msg,
					title : '提示'
				});
			}
		});

		modifyUserRoleDialog = $('#modifyUserRoleDialog').show().dialog({
			modal : true,
			title : '批量修改角色',
			buttons : [ {
				text : '修改',
				handler : function() {
					modifyUserRoleForm.submit();
				}
			} ]
		}).dialog('close');

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function changeEditorAddRow() {/*添加行时，改变editor*/
		datagrid.datagrid('addEditor', {
			field : 'cpwd',
			editor : {
				type : 'validatebox',
				options : {
					required : true
				}
			}
		});
		datagrid.datagrid('removeEditor', [ 'ccreatedatetime', 'cmodifydatetime' ]);
	}
	function changeEditorEditRow() {/*编辑行时，改变editor*/
		datagrid.datagrid('removeEditor', 'cpwd');
		datagrid.datagrid('addEditor', [ {
			field : 'ccreatedatetime',
			editor : {
				type : 'datetimebox',
				options : {
					editable : false
				}
			}
		}, {
			field : 'cmodifydatetime',
			editor : {
				type : 'datetimebox',
				options : {
					editable : false
				}
			}
		} ]);
	}

	function add() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
		}

		if (editRow == undefined) {
			datagrid.datagrid('unselectAll');

			changeEditorAddRow();/*改变editor*/

			var row = {
				cid : sy.UUID()
			};
			/*datagrid.datagrid('insertRow', {
				index : 0,
				row : row
			});
			editRow = 0;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);*/
			datagrid.datagrid('appendRow', row);
			editRow = datagrid.datagrid('getRows').length - 1;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);
		}
	}
	function del() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
			return;
		}
		var rows = datagrid.datagrid('getSelections');
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].cid);
					}
					$.ajax({
						url : 'userAction!delete.action',
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			if (editRow != undefined) {
				datagrid.datagrid('endEdit', editRow);
			}

			if (editRow == undefined) {
				changeEditorEditRow();/*改变editor*/
				editRow = datagrid.datagrid('getRowIndex', rows[0]);
				datagrid.datagrid('beginEdit', editRow);
				datagrid.datagrid('unselectAll');
			}
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>用户名</th>
					<td><input name="cname" style="width:315px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datetimebox" editable="false" style="width: 155px;" />至<input name="ccreatedatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datetimebox" editable="false" style="width: 155px;" />至<input name="cmodifydatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 155px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="modifyPwdDialog" style="padding: 5px;display: none;" align="center">
		<form id="modifyPwdForm" method="post">
			<input name="ids" type="hidden" />
			<table class="tableForm">
				<tr>
					<th>新密码</th>
					<td><input name="cpwd" type="password" class="easyui-validatebox" required="true" missingMessage="请填写新密码" /></td>
				</tr>
				<tr>
					<th>重复</th>
					<td><input name="recpwd" type="password" class="easyui-validatebox" required="true" missingMessage="请再次填写新密码" validType="eqPassword['#modifyPwdForm input[name=cpwd]']" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="modifyUserRoleDialog" style="display: none;">
		<form id="modifyUserRoleForm">
			<input name="ids" type="hidden" />
			<table class="tableForm">
				<tr>
					<th>角色</th>
					<td><input name="roleIds" id="modifyUserRoleCombobox" style="width:150px;" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>