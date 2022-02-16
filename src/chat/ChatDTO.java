package chat;

public class ChatDTO {
	
	Integer chatid;
	String fromid;
	String toid;
	String chatcontent;
	String chattime;
	
	
	public Integer getChatid() {
		return chatid;
	}
	public void setChatid(Integer chatid) {
		this.chatid = chatid;
	}
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getToid() {
		return toid;
	}
	public void setToid(String toid) {
		this.toid = toid;
	}
	public String getChatcontent() {
		return chatcontent;
	}
	public void setChatcontent(String chatcontent) {
		this.chatcontent = chatcontent;
	}
	public String getChattime() {
		return chattime;
	}
	public void setChattime(String chattime) {
		this.chattime = chattime;
	}
	
	
}
