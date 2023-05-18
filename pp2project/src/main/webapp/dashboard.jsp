<!DOCTYPE html>
<html lang="en">

<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>



<body>

<div class="container">
<h3>Dashboard</h3>
<table>
    <tr>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
        <a class=""
           href='./student-controller'><h5>group Student
            list</h5></a>
        </div></td>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./teacher-controller'><h5>
                Teacher list</h5></a>
        </div></td>
    </tr>
    <tr>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./subject-controller'><h5> Subject
                list</h5></a>
        </div></td>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./class-controller'><h5>
            Class list</h5></a>
        </div></td>
    </tr>
    <tr>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a
                    href='./class-report-controller'><h5> Class
                Report</h5></a>
        </div></td>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./class-subject-controller'><h5>
            Subjects Per Class</h5></a>
        </div></td>
    </tr>
    <tr>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./subjects-per-class-controller'><h5>
                Assign Subjects to One Class</h5></a>
        </div></td>
        <td class="dashboard-cell"><div class="card-panel secondary-text-color hoverable">
            <a href='./teacher-per-subject-controller'><h5> Assign
                Teachers to Subject</h5></a>
        </div></td>
    </tr>
</table>
</div>
<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="js/materialize.js"></script>
<script src="js/init.js"></script>

</body>
</html>
