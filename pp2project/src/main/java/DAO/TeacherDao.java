package DAO;

import model.Class;
import model.SQLState;
import model.Teacher;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

public interface TeacherDao {
    public List<Teacher> getAllTeachers() throws SQLException;
    public Teacher fetchOneTeacher(String id) throws SQLException;
    public SQLState updateOneTeacher(JSONObject jsonObject)throws SQLException;
    public SQLState deleteOneTeacher(JSONObject jsonObject)throws SQLException;
    public SQLState saveNewTeacher(JSONObject jsonObject)throws SQLException;
}