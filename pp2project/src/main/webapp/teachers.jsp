<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.List"%>
<%@ page import="model.Teacher"%>
<%@ page import="model.Class"%>


<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<body>

	<br />
	<br />
	<div>
		<div>
			<h2>Teachers</h2>
			<div>

				<div>
					<div>

						<table id="myTable">
							<thead>
								<tr>
									<th>Edit</th>
									<th>ID</th>
									<th>&nbsp;</th>
									<th>Teacher Name</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Teacher> teachersList = (List<Teacher>) request.getAttribute("teachersList");

								// Paint the rows of the teacher table
								for (Teacher teacher : teachersList) {
									out.println("");
									out.println("<tr><td>");
									out.println("<a class=\"modal-trigger\" href='javascript:fOpenEdit(\"" + teacher.getTeacherId() + "\")'>"
									+ "<i class=\"material-icons\">edit</i></a>");
									out.println("</td><td class=\"center-align\">");
									out.println(teacher.getTeacherId());
									out.println("</td><td>");
									out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
									out.println("</td><td>");
									out.println(teacher.getTeacherName());
									out.println("</td><td >");
									out.println("<a href='javascript:fOpenDelete(\"" + teacher.getTeacherId()
									+ "\")'><i class=\"material-icons\">delete</i></a>");
									out.println("</td></tr>");
								}
								%>
							</tbody>
						</table>


					</div>
					<div>
						<div>
							<span id="total_reg"></span>
							<ul id="myPager"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<a href="javascript:fOpenNew();">add</a>
	</div>


	<!-- Modal Structure -->
	<div>
		<form id="form1">

			<div>
				<h4>Teacher Detail</h4>
				<div id="contenido">
					<div>
						<div>
							<input type="text" id="teacherId" name="teacherId" value="">
							<label for="teacherId" class="active">Teacher</label>
						</div>
					</div>
					<div>
						<div>
							<input type="text" id="teacherName" name="teacherName" value="">
							<label for="teacherName" class="active">Teacher Name</label>
						</div>
					</div>
					<input type="hidden" id="action" name="action" value=""> <input
						type="hidden" id="deleteTeacherId" name="deleteTeacherId" value="">

				</div>
			</div>
			<div>
				<button type="submit">Save Changes</button>
			</div>
		</form>
	</div>

	<script>
    async function handleSubmit(event) {
        event.preventDefault();

        const data = new FormData(event.target);
        const oFormEntries = Object.fromEntries(data.entries());
        console.log("----> about to saveOneTeacher: " + oFormEntries.toString());
        await saveOneTeacher(oFormEntries);
    }

    const form = document.querySelector('#form1');
    form.addEventListener('submit', handleSubmit);
</script>


	<!--  Scripts-->
	<script>
    async function fOpenEdit(pId) {

        // Set the action
        document.getElementById("action").value = "updateOneTeacher";

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "flex"; // this centers the spinner in the modal window

        fetch("http://localhost:8080/pp2project/teacher-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneTeacher", teacherId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#teacherId").value = jsonObject.teacherId;
                document.querySelector("#teacherName").value = jsonObject.teacherName;
                // Display the modal, hide the spinner
                M.updateTextFields();

                await delay(1000);
                document.getElementById("preloader").style.display = "none";

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneTeacher/querySelector - " + e);
            }

        });
    }

    async function fOpenDelete(pId) {

        // Set the action
        document.getElementById("action").value = "deleteOneTeacher";

        // Trigger the Modal to open
       // this centers the spinner in the modal window

        fetch("http://localhost:8080/pp2project/teacher-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneTeacher", teacherId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values AND disabling the controls
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#teacherId").value = jsonObject.teacherId;
                document.querySelector("#teacherName").value = jsonObject.teacherName;
                // Display the modal, hide the spinner
                M.updateTextFields();

                // Disabling the controls
                document.querySelector("#teacherId").disabled  = true;
                document.querySelector("#teacherName").disabled  = true;

                //Setting the Id to delete
                document.querySelector("#deleteTeacherId").value = jsonObject.teacherId;
                await delay(1000);
                document.getElementById("preloader").style.display = "none";

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneTeacher/querySelector - " + e);
            }

        });
    }

    async function fOpenNew() {

        // Set the action
        document.getElementById("action").value = "saveNewTeacher";

        //Clean and enabling the controls
        document.querySelector("#teacherId").disabled  = false;
        document.querySelector("#teacherName").disabled  = false;
        M.updateTextFields();

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "none";

    }

    //ACTION: updateOneTeacher or saveNewTeacher
    function saveOneTeacher(oFormEntries) {
        console.log(" -----> saveOneTeacher:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/teacher-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> teacherjsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Teacher NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchTeachers/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }

    //ACTION: updateOneTeacher or saveNewTeacher
    function deleteOneTeacher(oFormEntries) {
        console.log(" -----> deleteOneTeacher:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/teacher-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> teacherjsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Teacher NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchTeachers/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }
</script>



</body>
</html>

