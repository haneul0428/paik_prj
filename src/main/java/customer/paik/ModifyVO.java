package customer.paik;

public class ModifyVO {
    private String email;
    private String password;
    private String name;
    private String zipcode;
    private String address;
    private String address2;
    private String phone; // 전화번호 필드 추가

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getZipcode() {
        return zipcode;
    }
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress2() {
        return address2;
    }
    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getPhone() { // 전화번호 getter
        return phone;
    }
    public void setPhone(String phone) { // 전화번호 setter
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "ModifyVO [email=" + email + ", password=" + password + ", name=" + name + 
                ", zipcode=" + zipcode + ", address=" + address + ", address2=" + address2 + 
                ", phone=" + phone + "]"; // phone 추가
    }
}
