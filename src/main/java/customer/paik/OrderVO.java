package customer.paik;

import java.sql.Date;

public class OrderVO {
	private int cartItemNum, price, total, quantity,syrup, shot;
	private String iNameK, image,drinkSize, cup,topping,base, ingredient_flag, categories_num;
	private Date inputDate;
	
	public OrderVO() {
		super();
	}

	public OrderVO(int cartItemNum, int price, int total, int quantity, int syrup, int shot, String iNameK,
			String image, String drinkSize, String cup, String topping, String base, String ingredient_flag,
			String categories_num, Date inputDate) {
		super();
		this.cartItemNum = cartItemNum;
		this.price = price;
		this.total = total;
		this.quantity = quantity;
		this.syrup = syrup;
		this.shot = shot;
		this.iNameK = iNameK;
		this.image = image;
		this.drinkSize = drinkSize;
		this.cup = cup;
		this.topping = topping;
		this.base = base;
		this.ingredient_flag = ingredient_flag;
		this.categories_num = categories_num;
		this.inputDate = inputDate;
	}

	public int getCartItemNum() {
		return cartItemNum;
	}

	public void setCartItemNum(int cartItemNum) {
		this.cartItemNum = cartItemNum;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getSyrup() {
		return syrup;
	}

	public void setSyrup(int syrup) {
		this.syrup = syrup;
	}

	public int getShot() {
		return shot;
	}

	public void setShot(int shot) {
		this.shot = shot;
	}

	public String getiNameK() {
		return iNameK;
	}

	public void setiNameK(String iNameK) {
		this.iNameK = iNameK;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDrinkSize() {
		return drinkSize;
	}

	public void setDrinkSize(String drinkSize) {
		this.drinkSize = drinkSize;
	}

	public String getCup() {
		return cup;
	}

	public void setCup(String cup) {
		this.cup = cup;
	}

	public String getTopping() {
		return topping;
	}

	public void setTopping(String topping) {
		this.topping = topping;
	}

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getIngredient_flag() {
		return ingredient_flag;
	}

	public void setIngredient_flag(String ingredient_flag) {
		this.ingredient_flag = ingredient_flag;
	}

	public String getCategories_num() {
		return categories_num;
	}

	public void setCategories_num(String categories_num) {
		this.categories_num = categories_num;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	@Override
	public String toString() {
		return "OrderVO [cartItemNum=" + cartItemNum + ", price=" + price + ", total=" + total + ", quantity="
				+ quantity + ", syrup=" + syrup + ", shot=" + shot + ", iNameK=" + iNameK + ", image=" + image
				+ ", drinkSize=" + drinkSize + ", cup=" + cup + ", topping=" + topping + ", base=" + base
				+ ", ingredient_flag=" + ingredient_flag + ", categories_num=" + categories_num + ", inputDate="
				+ inputDate + "]";
	}
	
} // orderVO 끝
