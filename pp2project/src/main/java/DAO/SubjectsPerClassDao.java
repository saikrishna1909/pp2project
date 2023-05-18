package DAO;

import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

import model.Class;
import model.SQLState;
import model.Subject;
import model.SubjectPerClass;

public interface SubjectsPerClassDao {
    public List<SubjectPerClass> getAllSubjectsPerClass(Class clase) throws SQLException;
    public List<Class> getAllClases() throws SQLException;
    public List<Subject>  getAllSubjectsAvailable() throws SQLException;
    public SQLState deleteOneSubjectPerClass(JSONObject jsonObject)throws SQLException;
    public SQLState saveNewSubjectPerClass(JSONObject jsonObject)throws SQLException;

}


