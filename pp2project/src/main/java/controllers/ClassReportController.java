package controllers;

import DAO.ClassReportDao;
import DAO.StudentDao;
import DAOImp.ClassReportDaoImpl;
import DAOImp.StudentDaoImpl;

import com.google.gson.Gson;
import model.Class;
import model.ClassFull;
import model.SQLState;
import model.Student;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/class-report-controller")
public class ClassReportController extends HttpServlet {
	private String message;

	public void init() {
		message = "";
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		ClassReportDao studentDao = null;
		try {
			studentDao = new ClassReportDaoImpl();
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}

		List<ClassFull> studentsList = null;

		try {
			studentsList = studentDao.getAllStudents();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}

		List<Class> classesList = null;
		try {
			classesList = studentDao.getAllClasses();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		request.setAttribute("classesList", classesList);
		request.setAttribute("studentsList", studentsList);
		request.getRequestDispatcher("classReport.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		StudentDao studentDao = null;
		try {
			studentDao = new StudentDaoImpl();
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		try {
			String jsonStringPOST = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
			JSONObject jsonObject = new JSONObject(jsonStringPOST);
			System.out.println("jsonObject: " + jsonObject);
			String action = (String) jsonObject.get("action");
			System.out.println("action: " + action);
			if (action.equals("fetchOneStudent")) {
				String studentId = (String) jsonObject.get("studentId");
				Student oneStudent = studentDao.fetchOneStudent(studentId);
				String studentJsonString = new Gson().toJson(oneStudent);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				System.out.println("studentJsonString" + studentJsonString);
				out.println(studentJsonString);
				out.flush();
			}
			if (action.equals("updateOneStudent")) {
				assert studentDao != null;
				SQLState sqlState = studentDao.updateOneStudent(jsonObject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("deleteOneStudent")) {
				assert studentDao != null;
				SQLState sqlState = studentDao.deleteOneStudent(jsonObject);

				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("saveNewStudent")) {

				// Query the DB
				SQLState sqlState = studentDao.saveNewStudent(jsonObject);
				// Returns call originated in the client
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void destroy() {
	}
}