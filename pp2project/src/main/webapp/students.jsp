<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.List"%>
<%@ page import="model.Student"%>
<%@ page import="model.Class"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<body>
	<br />
	<br />
	<div class="container">
		<h3>Students</h3>
		<br />
		<table class="striped card-panel highlight" id="myTable">
			<thead>
				<tr>
					<th class="center-align">Edit</th>
					<th class="center-align">ID</th>
					<th class="center-align">Student Name</th>
					<th class="center-align">Class</th>
					<th class="center-align">Delete</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<Student> studentsList = (List<Student>) request.getAttribute("studentsList");

				// Paint the rows of the student table
				for (Student student : studentsList) {
					out.println("");
					out.println("<tr><td class=\"center-align\">");
					out.println("<a class=\"modal-trigger\" href='javascript:fOpenEdit(\"" + student.getStudentId() + "\")'>"
					+ "<i class=\"material-icons\">edit</i></a>");
					out.println("</td><td class=\"center-align\">");
					out.println(student.getStudentId());
					out.println("</td><td>");
					out.println(student.getStudentName());
					out.println("</td><td class=\"center-align\">");
					out.println(student.getClassId());
					out.println("</td><td class=\"center-align\">");
					out.println("<a href='javascript:fOpenDelete(\"" + student.getStudentId() + "\")'>delete</i></a>");
					out.println("</td></tr>");
				}
				%>
			</tbody>
		</table>
		<div class="col-md-12 center text-center">
			<span class="left" id="total_reg"></span>
			<ul class="pagination pager" id="myPager"></ul>
		</div>

		<a class="btn-floating btn-large right waves-effect waves-light red"
			href="javascript:fOpenNew();"> add student</a>
	</div>

	<!-- Modal Structure -->
	<div id="modal1" class="modal">
		<form id="form1" class="col s12">
			<div class="modal-content">
				<h4>Student Detail</h4>
				<div id="contenido">
					<div class="row">
						<div class="input-field col s12">
							<input type="text" id="studentId" name="studentId"> <label
								for="studentId" class="active">Student Id</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<select id="classId" name="classId" class="select">
								<option value="" disabled selected>Select the student's
									class</option>

								<%
								List<Class> classesList = (List<Class>) request.getAttribute("classesList");

								// Paint the rows of the student table
								for (Class clase : classesList) {
									out.println("<option value=\"" + clase.getClassId() + "\">");
									out.println(clase.getClassName());
									out.println("</option>");
								}
								%>
							</select> <label for="clasId" class="active">Student's class</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<input type="text" id="studentName" name="studentName" value="">
							<label for="studentName" class="active">Student Name</label>
						</div>
					</div>
					<input type="hidden" id="action" name="action"> <input
						type="hidden" id="deleteStudentId" name="deleteStudentId">

				</div>
			</div>
			<div class="modal-footer">
				<button
					class="modal-close waves-effect waves-light btn accent-color"
					type="submit">
					<i class="material-icons left">save </i>Save Changes
				</button>
			</div>
		</form>
	</div>

	<script>
    async function handleSubmit(event) {
        event.preventDefault();

        const data = new FormData(event.target);
        const oFormEntries = Object.fromEntries(data.entries());
        console.log("----> about to saveOneStudent: " + oFormEntries.toString());
        await saveOneStudent(oFormEntries);
    }

    const form = document.querySelector('#form1');
    form.addEventListener('submit', handleSubmit);
</script>


	<!--  Scripts-->
	<script>
    async function fOpenEdit(pId) {
	console.log("fopenedit");
        // Set the action
        document.getElementById("action").value = "updateOneStudent";

        // Trigger the Modal to open
      // this centers the spinner in the modal window

        fetch("http://localhost:8080/pp2project/student-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneStudent", studentId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#studentId").value = jsonObject.studentId;
                document.querySelector("#studentName").value = jsonObject.studentName;
                // Display the modal, hide the spinner
                //document.querySelector("#classId").value = jsonObject.classId;
                const classEl = document.getElementById("classId");

                for(var i=0; i<classEl.options.length; i++){
                    if(classEl.options[i].value == jsonObject.classId){
                        console.log(classEl.options[i].value + " - " + jsonObject.classId);
                        classEl.options.selectedIndex = i;
                    }
                }
                //Re-initialize the select controls
                M.FormSelect.init(document.querySelectorAll('.select'), {classes: ""});
                M.updateTextFields();



                await delay(1000);
                document.getElementById("preloader").style.display = "none";

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneStudent/querySelector - " + e);
            }

        });
    }

    async function fOpenDelete(pId) {

        // Set the action
        document.getElementById("action").value = "deleteOneStudent";

        // Trigger the Modal to open
   
        fetch("http://localhost:8080/pp2project/student-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneStudent", studentId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values AND disabling the controls
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#studentId").value = jsonObject.studentId;
                document.querySelector("#studentName").value = jsonObject.studentName;
                // Display the modal, hide the spinner
                //document.querySelector("#classId").value = jsonObject.classId;
                const classEl = document.getElementById("classId");

                for(var i=0; i<classEl.options.length; i++){
                    if(classEl.options[i].value == jsonObject.classId){
                        console.log(classEl.options[i].value + " - " + jsonObject.classId);
                        classEl.options.selectedIndex = i;
                    }
                }
                //Re-initialize the select controls
                classEl.disabled = true;
                M.FormSelect.init(document.querySelectorAll('.select'), {classes: ""});
                M.updateTextFields();

                // Disabling the controls
                document.querySelector("#studentId").disabled  = true;
                document.querySelector("#studentName").disabled  = true;

                //Setting the Id to delete
                document.querySelector("#deleteStudentId").value = jsonObject.studentId;
                console.log(parseInt(jsonObject.studentId));
                await delay(1000);

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneStudent/querySelector - " + e);
            }

        });
    }

    async function fOpenNew() {

        // Set the action
        document.getElementById("action").value = "saveNewStudent";

        //Clean and enabling the controls
        document.querySelector("#studentId").disabled  = false;
        document.querySelector("#studentName").disabled  = false;
        document.getElementById("classId").disabled = false;

        M.FormSelect.init(document.querySelectorAll('.select'), {classes: ""});
        M.updateTextFields();

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "none";

    }

    //ACTION: updateOneStudent or saveNewStudent
    function saveOneStudent(oFormEntries) {
        console.log(" -----> saveOneStudent:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/student-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> studentjsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Student NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchStudents/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }

    //ACTION: updateOneStudent or saveNewStudent
    function deleteOneStudent(oFormEntries) {
        console.log(" -----> deleteOneStudent:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/student-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> studentjsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Student NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchStudents/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }
</script>




</body>
</html>

