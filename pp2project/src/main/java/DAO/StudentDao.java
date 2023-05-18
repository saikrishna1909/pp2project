package DAO;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import model.Class;
import model.SQLState;
import model.Student;

public interface StudentDao {
	public List<Student> getAllStudents() throws SQLException;

	public List<Class> getAllClasses() throws SQLException;

	public Student fetchOneStudent(String id) throws SQLException;

	public SQLState updateOneStudent(JSONObject jsonObject) throws SQLException, JSONException;

	public SQLState deleteOneStudent(JSONObject jsonObject) throws SQLException, JSONException;

	public SQLState saveNewStudent(JSONObject jsonObject) throws SQLException;
}
