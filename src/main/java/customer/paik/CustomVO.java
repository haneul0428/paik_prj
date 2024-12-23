package customer.paik;

import java.sql.Date;

public class CustomVO {
	private String cusId, cusPass, newPass, chkPass, name, phone, email, cusFlag;
	private Date inputDate;
	private String grade;

	public CustomVO() {
		super();
	}

	public CustomVO(String cusId, String cusPass, String name, String phone, String email, String cusFlag, Date inputDate,
					String grade) {
		super();
		this.cusId = cusId;
		this.cusPass = cusPass;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.cusFlag = cusFlag;
		this.inputDate = inputDate;
		this.grade = grade;
	}

	public String getCusId() {
		return cusId;
	}

	public void setCusId(String cusId) {
		this.cusId = cusId;
	}

	public String getCusPass() {
		return cusPass;
	}

	public void setCusPass(String cusPass) {
		this.cusPass = cusPass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCusFlag() {
		return cusFlag;
	}

	public void setCusFlag(String cusFlag) {
		this.cusFlag = cusFlag;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getNewPass() {
		return newPass;
	}

	public void setNewPass(String newPass) {
		this.newPass = newPass;
	}

	public String getChkPass() {
		return chkPass;
	}

	public void setChkPass(String chkPass) {
		this.chkPass = chkPass;
	}

	@Override
	public String toString() {
		return "CustomVO [cusId=" + cusId + ", cusPass=" + cusPass + ", newPass=" + newPass + ", chkPass=" + chkPass
				+ ", name=" + name + ", phone=" + phone + ", email=" + email + ", cusFlag=" + cusFlag + ", inputDate="
				+ inputDate + ", grade=" + grade + "]";
	}
}
