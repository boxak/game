package vo;

public class GameVO implements Comparable<GameVO>{
	private String name;
	private int score;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	@Override
	public String toString() {
		return "GameVO [name=" + name + ", score=" + score + "]";
	}
	@Override
	public int compareTo(GameVO vo) {
		if(this.score<vo.getScore()) {
			return 1;
		}
		else if(this.score>vo.getScore()) {
			return -1;
		}
		return 0;
	}
}
