package manager.paik.menu;

import java.sql.Date;

public class ProductVO {
	private int itemNum, price, categoriesNum, shot, syrup;
	private String iNameK, iNameE, description, image, itemFlag, ingredientFlag, categorieName;
	private Date inputDate;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getiNameK() {
		return iNameK;
	}
	public void setiNameK(String iNameK) {
		this.iNameK = iNameK;
	}
	public String getiNameE() {
		return iNameE;
	}
	public void setiNameE(String iNameE) {
		this.iNameE = iNameE;
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
	public String getItemFlag() {
		return itemFlag;
	}
	public void setItemFlag(String itemFlag) {
		this.itemFlag = itemFlag;
	}
	public String getIngredientFlag() {
		return ingredientFlag;
	}
	public void setIngredientFlag(String ingredientFlag) {
		this.ingredientFlag = ingredientFlag;
	}
	public Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}
	public String getCategorieName() {
		return categorieName;
	}
	public void setCategorieName(String categorieName) {
		this.categorieName = categorieName;
	}
	public int getShot() {
		return shot;
	}
	public void setShot(int shot) {
		this.shot = shot;
	}
	public int getSyrup() {
		return syrup;
	}
	public void setSyrup(int syrup) {
		this.syrup = syrup;
	}
	@Override
	public String toString() {
		return "ProductVO [itemNum=" + itemNum + ", price=" + price + ", categoriesNum=" + categoriesNum + ", shot="
				+ shot + ", syrup=" + syrup + ", iNameK=" + iNameK + ", iNameE=" + iNameE + ", description="
				+ description + ", image=" + image + ", itemFlag=" + itemFlag + ", ingredientFlag=" + ingredientFlag
				+ ", categorieName=" + categorieName + ", inputDate=" + inputDate + "]";
	}
}
