package manager.paik.menu;

public class IngredientVO {
	private int itemNum;
	private int caffeine, natrium, fattyAcid, calorie, sugar, protein;
	
	public int getItemNum() {
		return itemNum;
	}
	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}
	public int getCaffeine() {
		return caffeine;
	}
	public void setCaffeine(int caffeine) {
		this.caffeine = caffeine;
	}
	public int getNatrium() {
		return natrium;
	}
	public void setNatrium(int natrium) {
		this.natrium = natrium;
	}
	public int getFattyAcid() {
		return fattyAcid;
	}
	public void setFattyAcid(int fattyAcid) {
		this.fattyAcid = fattyAcid;
	}
	public int getCalorie() {
		return calorie;
	}
	public void setCalorie(int calorie) {
		this.calorie = calorie;
	}
	public int getSugar() {
		return sugar;
	}
	public void setSugar(int sugar) {
		this.sugar = sugar;
	}
	public int getProtein() {
		return protein;
	}
	public void setProtein(int protein) {
		this.protein = protein;
	}
	
	@Override
	public String toString() {
		return "IngredientVO [itemNum=" + itemNum + ", caffeine=" + caffeine + ", natrium=" + natrium + ", fattyAcid="
				+ fattyAcid + ", calorie=" + calorie + ", sugar=" + sugar + ", protein=" + protein + "]";
	}
	
	
}
