package manager.paik.voc;

import java.sql.Date;


public class VocVO {
    private int vocNum;
    private String cusId, inquiryType, title, content, ans, ansAl,route;
    private Date visit, inquiryDate, ansDate;

    public VocVO() {
    }

    public VocVO(String ans, String ansAl, Date ansDate, String content, String cusId, Date inquiryDate, String inquiryType, String route, String title, Date visit, int vocNum) {
        this.ans = ans;
        this.ansAl = ansAl;
        this.ansDate = ansDate;
        this.content = content;
        this.cusId = cusId;
        this.inquiryDate = inquiryDate;
        this.inquiryType = inquiryType;
        this.route = route;
        this.title = title;
        this.visit = visit;
        this.vocNum = vocNum;
    }

    public Date getAnsDate() {
        return ansDate;
    }

    public void setAnsDate(Date ansDate) {
        this.ansDate = ansDate;
    }

    public Date getInquiryDate() {
        return inquiryDate;
    }

    public void setInquiryDate(Date inquiryDate) {
        this.inquiryDate = inquiryDate;
    }

    public String getAns() {
        return ans;
    }

    public void setAns(String ans) {
        this.ans = ans;
    }

    public String getAnsAl() {
        return ansAl;
    }

    public void setAnsAl(String ansAl) {
        this.ansAl = ansAl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCusId() {
        return cusId;
    }

    public void setCusId(String cusId) {
        this.cusId = cusId;
    }

    public String getInquiryType() {
        return inquiryType;
    }

    public void setInquiryType(String inquiryType) {
        this.inquiryType = inquiryType;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getVisit() {
        return visit;
    }

    public void setVisit(Date visit) {
        this.visit = visit;
    }

    public int getVocNum() {
        return vocNum;
    }

    public void setVocNum(int vocNum) {
        this.vocNum = vocNum;
    }
}

