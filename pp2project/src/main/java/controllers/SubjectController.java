package controllers;

import DAO.SubjectDao;
import DAOImp.SubjectDaoImpl;

import com.google.gson.Gson;
import model.SQLState;
import model.Subject;
import model.SubjectFull;
import model.Teacher;
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

@WebServlet("/subject-controller")
public class SubjectController extends HttpServlet {
	private String message;

	public void init() {
		message = "";
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		SubjectDao subjectDao = null;
		try {
			subjectDao = new SubjectDaoImpl();
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		List<SubjectFull> subjectsList = null;
		try {
			subjectsList = subjectDao.getAllSubjects();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		List<Teacher> teachersList = null;
		try {
			teachersList = subjectDao.getAllTeachers();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		request.setAttribute("teachersList", teachersList);
		request.setAttribute("subjectsList", subjectsList);
		request.getRequestDispatcher("subjects.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		SubjectDao subjectDao = null;
		try {
			subjectDao = new SubjectDaoImpl();
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		try {
			String jsonStringPOST = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
			JSONObject jsonObject = new JSONObject(jsonStringPOST);
			System.out.println("jsonObject: " + jsonObject);
			String action = (String) jsonObject.get("action");
			System.out.println("action: " + action);
			if (action.equals("fetchOneSubject")) {

				// Query the DB
				String subjectId = (String) jsonObject.get("subjectId");
				Subject oneSubject = subjectDao.fetchOneSubject(subjectId);

				// Serialize the oneSubject object
				String subjectJsonString = new Gson().toJson(oneSubject);
				// Returns call originated in the client
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				System.out.println("subjectJsonString" + subjectJsonString);
				out.println(subjectJsonString);
				out.flush();
			}
			if (action.equals("updateOneSubject")) {
				assert subjectDao != null;
				SQLState sqlState = subjectDao.updateOneSubject(jsonObject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("deleteOneSubject")) {
				assert subjectDao != null;
				SQLState sqlState = subjectDao.deleteOneSubject(jsonObject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("saveNewSubject")) {
				SQLState sqlState = subjectDao.saveNewSubject(jsonObject);
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