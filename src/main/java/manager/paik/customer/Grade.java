package manager.paik.customer;

/**
 * @author : user
 * @fileName : Grade
 * @since : 24. 10. 24.
 */
public enum Grade {
    실버(0), 골드(1);

    private final int dbValue;

    Grade(int dbValue) {
        this.dbValue = dbValue;
    }

    public int getValue() {
        return dbValue;
    }

    // DB값으로부터 enum을 찾는 메소드
    public static Grade gradeForDB(int value) {
        for (Grade grade : values()) {
            if (grade.getValue() == value) {
                return grade;
            }
        }
        throw new IllegalArgumentException("Invalid grade value: " + value);
    }
}