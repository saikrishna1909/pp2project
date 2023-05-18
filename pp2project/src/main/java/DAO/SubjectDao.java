package DAO;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

import model.SQLState;
import model.Subject;
import model.SubjectFull;
import model.Teacher;

public interface SubjectDao {
	public List<SubjectFull> getAllSubjects() throws SQLException;

	public List<Teacher> getAllTeachers() throws SQLException;

	public Subject fetchOneSubject(String id) throws SQLException;

	public SQLState updateOneSubject(JSONObject jsonObject) throws SQLException;

	public SQLState deleteOneSubject(JSONObject jsonObject) throws SQLException;

	public SQLState saveNewSubject(JSONObject jsonObject) throws SQLException;
}
