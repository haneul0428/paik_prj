package customer.paik;

import java.sql.Date;

public class CartItemVO {
	private int cartItemNum, cartNum, itemNum, quantity, price, shot, syrup, categoriesNum;
	private String cusId, image, itemName, orderFlag, receiptFlag, size, addChoco, addStraw, cup;
	private Date inputDate;
	private ItemVO iVO;

	public int getCategoriesNum() {
		return categoriesNum;
	}

	public void setCategoriesNum(int categoriesNum) {
		this.categoriesNum = categoriesNum;
	}

	public int getCartItemNum() {
		return cartItemNum;
	}

	public void setCartItemNum(int cartItemNum) {
		this.cartItemNum = cartItemNum;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public String getCusId() {
		return cusId;
	}

	public void setCusId(String cusId) {
		this.cusId = cusId;
	}

	public int getItemNum() {
		return itemNum;
	}

	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}



	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}

	public String getReceiptFlag() {
		return receiptFlag;
	}

	public void setReceiptFlag(String receiptFlag) {
		this.receiptFlag = receiptFlag;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getAddChoco() {
		return addChoco;
	}

	public void setAddChoco(String addChoco) {
		this.addChoco = addChoco;
	}

	public String getAddStraw() {
		return addStraw;
	}

	public void setAddStraw(String addStraw) {
		this.addStraw = addStraw;
	}

	public String getCup() {
		return cup;
	}

	public void setCup(String cup) {
		this.cup = cup;
	}

	public ItemVO getiVO() {
		return iVO;
	}

	public void setiVO(ItemVO iVO) {
		this.iVO = iVO;
	}

	@Override
	public String toString() {
		return "CartItemVO [cartItemNum=" + cartItemNum + ", cartNum=" + cartNum + ", itemNum=" + itemNum
				+ ", quantity=" + quantity + ", price=" + price + ", shot=" + shot + ", syrup=" + syrup
				+ ", categoriesNum=" + categoriesNum + ", cusId=" + cusId + ", image=" + image + ", itemName="
				+ itemName + ", orderFlag=" + orderFlag + ", receiptFlag=" + receiptFlag + ", size=" + size
				+ ", addChoco=" + addChoco + ", addStraw=" + addStraw + ", cup=" + cup + ", inputDate=" + inputDate
				+ ", iVO=" + iVO + "]";
	}
	
}
