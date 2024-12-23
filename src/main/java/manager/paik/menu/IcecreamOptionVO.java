package manager.paik.menu;

public class IcecreamOptionVO {
	private int icecreamOptionNum, itemNum;
	private String addChocolate, addStrawberry;
	
	public int getIcecreamOptionNum() {
		return icecreamOptionNum;
	}

	public void setIcecreamOptionNum(int icecreamOptionNum) {
		this.icecreamOptionNum = icecreamOptionNum;
	}

	public int getItemNum() {
		return itemNum;
	}

	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}

	public String getAddChocolate() {
		return addChocolate;
	}

	public void setAddChocolate(String addChocolate) {
		this.addChocolate = addChocolate;
	}

	public String getAddStrawberry() {
		return addStrawberry;
	}

	public void setAddStrawberry(String addStrawberry) {
		this.addStrawberry = addStrawberry;
	}

	@Override
	public String toString() {
		return "IcecreamOptionVO [icecreamOptionNum=" + icecreamOptionNum + ", itemNum=" + itemNum + ", addChocolate="
				+ addChocolate + ", addStrawberry=" + addStrawberry + "]";
	}
	
	
	
	
}
