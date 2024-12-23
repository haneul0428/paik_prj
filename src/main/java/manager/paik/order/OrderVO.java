package manager.paik.order;

import java.sql.Date;

public class OrderVO {
	private int cartItemNumber, cartNum, itemNum, quantity; // 카트 아이템 번호, 카트 고유 번호, 아이템 번호, 주문 수량
	private String cartItemNum, orderFlag, receiptFlag, cusId, name, iNameK;  // 주문 플래그, 수령 플래그, 주문자 id, 주문자 이름, 주문 상품 이름
	private Date inputDate; // 주문 시간
	
	
	
	public int getCartItemNumber() {
		return cartItemNumber;
	}
	public void setCartItemNumber(int cartItemNumber) {
		this.cartItemNumber = cartItemNumber;
	}
	public String getCartItemNum() {
		return cartItemNum;
	}
	public void setCartItemNum(String cartItemNum) {
		this.cartItemNum = cartItemNum;
	}
	public int getCartNum() {
		return cartNum;
	}
	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
	public int getItemNum() {
		return itemNum;
	}
	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
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
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getiNameK() {
		return iNameK;
	}
	public void setiNameK(String iNameK) {
		this.iNameK = iNameK;
	}
	public Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}
	@Override
	public String toString() {
		return "OrderVO [cartItemNumber=" + cartItemNumber + ", cartNum=" + cartNum + ", itemNum=" + itemNum
				+ ", quantity=" + quantity + ", cartItemNum=" + cartItemNum + ", orderFlag=" + orderFlag
				+ ", receiptFlag=" + receiptFlag + ", cusId=" + cusId + ", name=" + name + ", iNameK=" + iNameK
				+ ", inputDate=" + inputDate + "]";
	}

	
	
}
