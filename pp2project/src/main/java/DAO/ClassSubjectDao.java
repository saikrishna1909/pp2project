package DAO;

import java.sql.SQLException;
import java.util.List;

import model.ClassSubject;

public interface ClassSubjectDao {
    public List<ClassSubject> getAllClassSubjects() throws SQLException;
}


