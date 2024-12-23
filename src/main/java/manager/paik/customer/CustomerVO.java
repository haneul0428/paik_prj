package manager.paik.customer;

import java.sql.Date;

/**
 * @author : user
 * @fileName : CustomerVO
 * @since : 24. 10. 24.
 */


/*
* myJstar : CustomerVO
* 회원의 정보를 저장하는 VO클래스
*/
public class CustomerVO {
    //cusFlag 는 디폴트
    private String cusId;
    private String cusPass;
    private String name;
    private String phone;
    private String email;
    private Date inputDate;
    private Grade grade;
    private String cusFlag;

    public CustomerVO() {
    }



    public String getCusFlag() {
        return cusFlag;
    }

    public void setCusFlag(String cusFlag) {
        this.cusFlag = cusFlag;
    }

    @Override
    public String toString() {
        return "CustomerVO{" +
                "cusId='" + cusId + '\'' +
                ", cusPass='" + cusPass + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", inputDate=" + inputDate +
                ", grade=" + grade +
                ", cusFlag='" + cusFlag + '\'' +
                '}';
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public Date getInputDate() {
        return inputDate;
    }

    public void setInputDate(Date inputDate) {
        this.inputDate = inputDate;
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

    // DB에서 int 값을 받아올 때 사용
    public void setGradeFromDB(int value) {
        this.grade = Grade.gradeForDB(value);
    }
} // CustomerVO 끝
