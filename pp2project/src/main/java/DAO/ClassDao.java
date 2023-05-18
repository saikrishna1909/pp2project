package DAO;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import model.Class;
import model.SQLState;
import model.Student;

public interface ClassDao {
	public List<Class> getAllClasses() throws SQLException;

	public Class fetchOneClass(String id) throws SQLException;

	public SQLState updateOneClass(JSONObject jsonObject) throws SQLException, JSONException;

	public SQLState deleteOneClass(JSONObject jsonObject) throws SQLException, JSONException;

	public SQLState saveNewClass(JSONObject jsonObject) throws SQLException;
}
