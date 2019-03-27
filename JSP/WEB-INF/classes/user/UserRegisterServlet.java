package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//post방식으로 전달된 어떠한 요청을 처리해줄 수 있는 역할을 한다.
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		response.getWriter().write(register(userName, userAge, userGender, userEmail) + "");//문자열 형태로 숫자가 출력될 수 있도록 뒤에 공백 문자를 준다.
	}
	
	public int register(String userName, String userAge, String userGender, String userEmail) {
		User user = new User();
		try {
			user.setUserName(userName);
			user.setUserAge(Integer.parseInt(userAge));
			user.setUserGender(userGender);
			user.setUserEmail(userEmail);
		} catch(Exception e) {
			return 0;
		}
		
		return new UserDAO().register(user);
	}

}
