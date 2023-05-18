package controllers;

import DAO.ClassDao;
import DAOImp.ClassDaoImpl;
import model.SQLState;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;
import model.Class;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/class-controller")
public class ClassController extends HttpServlet {
    private String message;

    public void init() {
        message = "";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ClassDao classDao = null;
        try {
            classDao = new ClassDaoImpl();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }

        List<model.Class> classesList = null;

        try {
            classesList = classDao.getAllClasses();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        request.setAttribute("classesList", classesList);
        request.getRequestDispatcher("class.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        ClassDao classDao = null;
        try {
            classDao = new ClassDaoImpl();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }


        try {
            // To read what the POST brings to the Servlet
            String jsonStringPOST = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
            JSONObject jsonObject = new JSONObject(jsonStringPOST);
            System.out.println("jsonObject: " + jsonObject);
            String action = (String) jsonObject.get("action");
            System.out.println("action: " + action);

            // ACTION ? fetchOneClase
            if (action.equals("fetchOneClass")) {

                //Query the DB
                String classId = (String) jsonObject.get("classId");
                Class oneClase = classDao.fetchOneClass(classId);

                //Serialize the oneClase object
                String claseJsonString = new Gson().toJson(oneClase);
                // Returns call originated in the client
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                System.out.println("claseJsonString" + claseJsonString);
                out.println(claseJsonString);
                out.flush();
            }

            // ACTION ? updateOneClase or saveNewClase
            if (action.equals("updateOneClass")) {

                //Query the DB
                assert classDao != null;
                SQLState sqlState = classDao.updateOneClass(jsonObject);

                // Returns call originated in the client
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                out.println(new Gson().toJson(sqlState));
                out.flush();
            }

            // ACTION ? deleteOneClase
            if (action.equals("deleteOneClass")) {

                //Query the DB
                assert classDao != null;
                SQLState sqlState = classDao.deleteOneClass(jsonObject);

                // Returns call originated in the client
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                out.println(new Gson().toJson(sqlState));
                out.flush();
            }

            // ACTION ? saveNewClase
            if (action.equals("saveNewClass")) {

                //Query the DB
                SQLState sqlState = classDao.saveNewClass(jsonObject);
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