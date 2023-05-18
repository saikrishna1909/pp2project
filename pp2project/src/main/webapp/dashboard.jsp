<!DOCTYPE html>
<html lang="en">

<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.LinkedHashMap"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>



<body>

	<div>
		<center>
			<h1>Dashboard</h1>
			<table>
				<tr>
					<td style="border: 1px solid black"><div>
							<a href='./student-controller'><h2>Student list</h2></a>
						</div></td>
					<td style="border: 1px solid black"><div>
							<a href='./teacher-controller'><h2>Teacher list</h2></a>
						</div></td>
				</tr>
				<tr>
					<td style="border: 1px solid black"><div>
							<a href='./subject-controller'><h2>Subject list</h2></a>
						</div></td>
					<td style="border: 1px solid black"><div>
							<a href='./class-controller'><h2>Class list</h2></a>
						</div></td>
				</tr>
				<tr>
					<td style="border: 1px solid black"><div>
							<a href='./class-report-controller'><h2>Class Report</h2></a>
						</div></td>
					<td style="border: 1px solid black"><div>
							<a href='./class-subject-controller'><h2>Subjects Per
									Class</h2></a>
						</div></td>
				</tr>
				<tr>
					<td style="border: 1px solid black"><div>
							<a href='./subjects-per-class-controller'><h2>Assign
									Subjects to One Class</h2></a>
						</div></td>
					<td style="border: 1px solid black"><div>
							<a href='./teacher-per-subject-controller'><h2>Assign
									Teachers to Subject</h2></a>
						</div></td>
				</tr>
			</table>
		</center>
	</div>


</body>
</html>
