package manager.paik.menu;

public class DrinkOptionVO {
	private int drinkOptionNum, itemNum, shot, syrup;
	private String sizeS,sizeM,sizeL,multiCup;
	public int getDrinkOptionNum() {
		return drinkOptionNum;
	}
	public void setDrinkOptionNum(int drinkOptionNum) {
		this.drinkOptionNum = drinkOptionNum;
	}
	public int getItemNum() {
		return itemNum;
	}
	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
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
	public String getSizeS() {
		return sizeS;
	}
	public void setSizeS(String sizeS) {
		this.sizeS = sizeS;
	}
	public String getSizeM() {
		return sizeM;
	}
	public void setSizeM(String sizeM) {
		this.sizeM = sizeM;
	}
	public String getSizeL() {
		return sizeL;
	}
	public void setSizeL(String sizeL) {
		this.sizeL = sizeL;
	}
	public String getMultiCup() {
		return multiCup;
	}
	public void setMultiCup(String multiCup) {
		this.multiCup = multiCup;
	}
	@Override
	public String toString() {
		return "OptionVO [drinkOptionNum=" + drinkOptionNum + ", itemNum=" + itemNum + ", shot=" + shot + ", syrup="
				+ syrup + ", sizeS=" + sizeS + ", sizeM=" + sizeM + ", sizeL=" + sizeL + ", multiCup=" + multiCup + "]";
	}
	
	
}
