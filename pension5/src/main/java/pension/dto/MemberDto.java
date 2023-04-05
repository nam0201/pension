package pension.dto;

public class MemberDto {
    // member 테이블의 하나의 레코드를 담을수 있는 필드로 구성
	private int id,state;
	private String name,userid,pwd,phone,email,writeday;
	
	// private인 필드는 저장할때 public인  setter를 이용
    //                읽을때  public인  getter를 이용
		
	// 변수  =>  get변수() , set변수(); 
	     //    변수의 첫자는 대문자로 변경
	
	public String getName() {
		return name;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	
	
	
}
