package controllers;

import DAO.TeacherPerSubjectDao;
import DAOImp.TeacherPerSubjectDaoImpl;

import com.google.gson.Gson;
import model.SQLState;
import model.Subject;
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

@WebServlet("/teacher-per-subject-controller")
public class TeacherPerSubjectController extends HttpServlet {
	public void init() {
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		TeacherPerSubjectDao teacherPerSubjectDao = null;
		try {
			teacherPerSubjectDao = new TeacherPerSubjectDaoImpl();
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		List<Subject> subjectsList = null;
		try {
			subjectsList = teacherPerSubjectDao.getAllSubjects();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		List<Teacher> teachersList = null;
		try {
			teachersList = teacherPerSubjectDao.getAllTeachers();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		request.setAttribute("teachersList", teachersList);
		request.setAttribute("subjectsList", subjectsList);
		request.getRequestDispatcher("TeacherPerSubject.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		TeacherPerSubjectDao teacherPerSubjectDao = null;
		try {
			teacherPerSubjectDao = new TeacherPerSubjectDaoImpl();
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
				String subjectId = (String) jsonObject.get("subjectId");
				Subject oneSubject = teacherPerSubjectDao.fetchOneSubject(subjectId);
				String subjectJsonString = new Gson().toJson(oneSubject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				System.out.println("subjectJsonString" + subjectJsonString);
				out.println(subjectJsonString);
				out.flush();
			}
			if (action.equals("updateOneSubject")) {
				assert teacherPerSubjectDao != null;
				SQLState sqlState = teacherPerSubjectDao.updateOneSubject(jsonObject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("deleteOneSubject")) {
				assert teacherPerSubjectDao != null;
				SQLState sqlState = teacherPerSubjectDao.deleteOneSubject(jsonObject);
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				out.println(new Gson().toJson(sqlState));
				out.flush();
			}
			if (action.equals("saveNewSubject")) {
				SQLState sqlState = teacherPerSubjectDao.saveNewSubject(jsonObject);
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