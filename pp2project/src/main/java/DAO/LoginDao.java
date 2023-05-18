package DAO;

import java.sql.SQLException;
import java.util.List;

import model.Class;
import model.SQLState;
import model.User;

public interface LoginDao {
	public boolean verifyCredentials(User user) throws SQLException;

}
