package manager.paik.manager;/**
 *
 * @fileName      : ManagerVO
 * @author        : user
 * @since         : 24. 10. 23.
 */public class ManagerVO {
     private String managerId;
     private String managerPass;

    public ManagerVO() {
    }


    public ManagerVO(String managerId, String managerPass) {
        this.managerId = managerId;
        this.managerPass = managerPass;
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getManagerPass() {
        return managerPass;
    }

    public void setManagerPass(String managerPass) {
        this.managerPass = managerPass;
    }

    @Override
    public String toString() {
        return "ManagerVO{" +
                "managerId='" + managerId + '\'' +
                ", managerPass='" + managerPass + '\'' +
                '}';
    }
} // ManagerVO 끝
