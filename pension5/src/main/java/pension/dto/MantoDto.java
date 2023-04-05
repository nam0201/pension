package pension.dto;

public class MantoDto {
    private int id, que, state;
    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQue() {
		return que;
	}
	public void setQue(int que) {
		this.que = que;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	private String content, userid, writeday,answer;
}
