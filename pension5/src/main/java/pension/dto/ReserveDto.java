package pension.dto;

public class ReserveDto {
	private int id, room_id, chacol, bbq, inwon, tprice;
	private String inday, outday, userid, jcode, email, writeday;
	
	//room테이블의 name필드
	private String name;
	
	//입실일, 퇴실일을 이용한 숙박일수
	private long suk;
	
	public long getSuk() {
		return suk;
	}
	public void setSuk(long suk) {
		this.suk = suk;
	}
	public String getName() {
		return name;
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
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	public int getChacol() {
		return chacol;
	}
	public void setChacol(int chacol) {
		this.chacol = chacol;
	}
	public int getBbq() {
		return bbq;
	}
	public void setBbq(int bbq) {
		this.bbq = bbq;
	}
	public int getInwon() {
		return inwon;
	}
	public void setInwon(int inwon) {
		this.inwon = inwon;
	}
	public int getTprice() {
		return tprice;
	}
	public void setTprice(int tprice) {
		this.tprice = tprice;
	}
	public String getInday() {
		return inday;
	}
	public void setInday(String inday) {
		this.inday = inday;
	}
	public String getOutday() {
		return outday;
	}
	public void setOutday(String outday) {
		this.outday = outday;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getJcode() {
		return jcode;
	}
	public void setJcode(String jcode) {
		this.jcode = jcode;
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
