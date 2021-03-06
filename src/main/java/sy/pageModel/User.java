package sy.pageModel;

import java.util.Date;



/**
 * 
 * @author 
 * 
 */

public class User implements java.io.Serializable {

	// 自己添加的属性
	private Date ccreatedatetimeStart;
	private Date cmodifydatetimeStart;
	private Date ccreatedatetimeEnd;
	private Date cmodifydatetimeEnd;
	private String ids;
	private String oldPwd;
	private String roleIds;
	private String roleNames;
	private String q;// 补全登录时用到的属性
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private String cgroupid;


	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public String getRoleNames() {
		return roleNames;
	}

	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public Date getCcreatedatetimeStart() {
		return ccreatedatetimeStart;
	}

	public void setCcreatedatetimeStart(Date ccreatedatetimeStart) {
		this.ccreatedatetimeStart = ccreatedatetimeStart;
	}

	public Date getCmodifydatetimeStart() {
		return cmodifydatetimeStart;
	}

	public void setCmodifydatetimeStart(Date cmodifydatetimeStart) {
		this.cmodifydatetimeStart = cmodifydatetimeStart;
	}

	public Date getCcreatedatetimeEnd() {
		return ccreatedatetimeEnd;
	}

	public void setCcreatedatetimeEnd(Date ccreatedatetimeEnd) {
		this.ccreatedatetimeEnd = ccreatedatetimeEnd;
	}

	public Date getCmodifydatetimeEnd() {
		return cmodifydatetimeEnd;
	}

	public void setCmodifydatetimeEnd(Date cmodifydatetimeEnd) {
		this.cmodifydatetimeEnd = cmodifydatetimeEnd;
	}

	private String cid;
	private String cname;
	private String cpwd;
	private Date ccreatedatetime;
	private Date cmodifydatetime;
	private String cworkplace;
	private String cemail;
	private String ctelphone;
	private String cgender;
	private String caddress;
	private String ccity;
	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCpwd() {
		return cpwd;
	}

	public void setCpwd(String cpwd) {
		this.cpwd = cpwd;
	}

	public Date getCcreatedatetime() {
		return ccreatedatetime;
	}

	public void setCcreatedatetime(Date ccreatedatetime) {
		this.ccreatedatetime = ccreatedatetime;
	}

	public Date getCmodifydatetime() {
		return cmodifydatetime;
	}

	public void setCmodifydatetime(Date cmodifydatetime) {
		this.cmodifydatetime = cmodifydatetime;
	}

	public String getCworkplace() {
		return cworkplace;
	}

	public void setCworkplace(String cworkplace) {
		this.cworkplace = cworkplace;
	}

	public String getCemail() {
		return cemail;
	}

	public void setCemail(String cemail) {
		this.cemail = cemail;
	}

	public String getCtelphone() {
		return ctelphone;
	}

	public void setCtelphone(String ctelphone) {
		this.ctelphone = ctelphone;
	}

	public String getCgender() {
		return cgender;
	}

	public void setCgender(String cgender) {
		this.cgender = cgender;
	}

	public String getCaddress() {
		return caddress;
	}

	public void setCaddress(String caddress) {
		this.caddress = caddress;
	}

	public String getCcity() {
		return ccity;
	}

	public void setCcity(String ccity) {
		this.ccity = ccity;
	}

	public String getCgroupid() {
		return cgroupid;
	}

	public void setCgroupid(String cgroupid) {
		this.cgroupid = cgroupid;
	}



}