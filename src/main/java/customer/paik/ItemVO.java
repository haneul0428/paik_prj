package customer.paik;

import java.sql.Date;

public class ItemVO {
	private int itemNum, categoriesNum;
	private String iNameKor, iNameEng, description, image;
	private int price;
	private Date inputDate;
	private char itemFlag, ingredientFlag;
	private int caff, nat, fatAcid, cal, sugar, pro;
	
	public ItemVO() {
		super();
	}
	
	public int getItemNum() {
		return itemNum;
	}

	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}
	public int getCategoriesNum() {
		return categoriesNum;
	}

	public void setCategoriesNum(int categoriesNum) {
		this.categoriesNum = categoriesNum;
	}

	public String getiNameKor() {
		return iNameKor;
	}

	public void setiNameKor(String iNameKor) {
		this.iNameKor = iNameKor;
	}

	public String getiNameEng() {
		return iNameEng;
	}

	public void setiNameEng(String iNameEng) {
		this.iNameEng = iNameEng;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public char getItemFlag() {
		return itemFlag;
	}

	public void setItemFlag(char itemFlag) {
		this.itemFlag = itemFlag;
	}

	public char getIngredientFlag() {
		return ingredientFlag;
	}

	public void setIngredientFlag(char ingredientFlag) {
		this.ingredientFlag = ingredientFlag;
	}

	public int getCaff() {
		return caff;
	}

	public void setCaff(int caff) {
		this.caff = caff;
	}

	public int getNat() {
		return nat;
	}

	public void setNat(int nat) {
		this.nat = nat;
	}

	public int getFatAcid() {
		return fatAcid;
	}

	public void setFatAcid(int fatAcid) {
		this.fatAcid = fatAcid;
	}

	public int getCal() {
		return cal;
	}

	public void setCal(int cal) {
		this.cal = cal;
	}

	public int getSugar() {
		return sugar;
	}

	public void setSugar(int sugar) {
		this.sugar = sugar;
	}

	public int getPro() {
		return pro;
	}

	public void setPro(int pro) {
		this.pro = pro;
	}

	@Override
	public String toString() {
		return "ItemVO [itemNum=" + itemNum + ", categoriesNum=" + categoriesNum + ", iNameKor=" + iNameKor
				+ ", iNameEng=" + iNameEng + ", description=" + description + ", image=" + image + ", price=" + price
				+ ", inputDate=" + inputDate + ", itemFlag=" + itemFlag + ", ingredientFlag=" + ingredientFlag
				+ ", caff=" + caff + ", nat=" + nat + ", fatAcid=" + fatAcid + ", cal=" + cal + ", sugar=" + sugar
				+ ", pro=" + pro + "]";
	}

}//c
