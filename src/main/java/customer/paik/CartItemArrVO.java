package customer.paik;

import java.util.Arrays;

public class CartItemArrVO {	
	//주문목록
	private int[] cartItemNumArr, cartNumArr;
	private String[] hiddenChk;
	
	public int[] getCartItemNumArr() {
		return cartItemNumArr;
	}
	public void setCartItemNumArr(int[] cartItemNumArr) {
		this.cartItemNumArr = cartItemNumArr;
	}
	public int[] getCartNumArr() {
		return cartNumArr;
	}
	public void setCartNumArr(int[] cartNumArr) {
		this.cartNumArr = cartNumArr;
	}
	public String[] getHiddenChk() {
		return hiddenChk;
	}
	public void setHiddenChk(String[] hiddenChk) {
		this.hiddenChk = hiddenChk;
	}
	@Override
	
	public String toString() {
		return "CartItemArrVO [cartItemNumArr=" + Arrays.toString(cartItemNumArr) + ", cartNumArr="
				+ Arrays.toString(cartNumArr) + ", hiddenChk=" + Arrays.toString(hiddenChk) + "]";
	}

}
