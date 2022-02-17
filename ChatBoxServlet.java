package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatBoxServlet")
public class ChatBoxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		if(userID == null || userID.equals("")) {
			response.getWriter().write("0");
		}else {
			try {
				userID = URLDecoder.decode(userID, "UTF-8");
				response.getWriter().write(getBox(userID));
			}catch(Exception e) {
				response.getWriter().write("");
			}

		}
	}
	
	public String getBox(String userID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getBox(userID);
		if(chatList.size() == 0) return "";
		for(int i= chatList.size() - 1; i >=0; i--) {
			String unread = "";
			if(userID.equals(chatList.get(i).getToid())) {
				unread = chatDAO.getUnreadChat(chatList.get(i).getFromid(), userID) + "";
				if(unread.equals("0")) unread ="";
			}
			result.append("[{\"value\": \"" + chatList.get(i).getFromid() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToid() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatcontent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChattime() + "\"},");
			result.append("{\"value\": \"" + unread + "\"}]");
			if(i != 0) result.append(",");//i가 0 아니라면 다음 데이터가 있으니까 ,출력
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1 ).getChatid() + "\"}");
		return result.toString();
	}
}
