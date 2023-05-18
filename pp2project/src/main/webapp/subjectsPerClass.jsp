<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.List"%>
<%@ page import="model.Subject"%>
<%@ page import="model.Class"%>
<%@ page import="model.Teacher"%>
<%@ page import="model.SubjectPerClass"%>


<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<body>
	<br />
	<div class="container">
		<div>
			<h2>Subjects Per Class</h2>
			<div>
				<div>
					<div>

						<h4>Classes</h4>
						<table>
							<thead>
								<tr>
									<th class="center-align">ID</th>
									<th class="center-align">Class Name</th>
									<th class="center-align">Choose</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Class> classesList = (List<Class>) request.getAttribute("classesList");
								Class claseSelected = (Class) request.getAttribute("claseSelected");

								// Paint the rows of the subject table
								for (Class clase : classesList) {
									out.println("<tr>");
									out.println("<td class=\"center-align\">" + clase.getClassId());
									out.println("</td><td class=\"center-align\">");
									out.println(clase.getClassName());
									out.println("<td class=\"center-align\">" + "<a class=\"waves-effect waves-light btn-small accent-color\" "
									+ "href=\"/pp2project/subjects-per-class-controller?pClaseId=" + clase.getClassId() + "&pClaseName="
									+ clase.getClassName() + "\">" + "<i class=\"material-icons right\">forward</i>" + clase.getClassName()
									+ "</a>");
									out.println("</td><td>");
									out.println("</td></tr>");
								}
								%>
							</tbody>
						</table>


					</div>
					<hr>
				</div>
				<div class="card-stacked">
					<form id="form1" class="col s12">
						<div class="card-content">
							<h4 class="header">
								Subjects of
								<%=claseSelected.getClassName()%>
							</h4>
							<table class="striped card-panel highlight light-primary-color"
								id="myTable">
								<thead>
									<tr>
										<th class="center-align">ID</th>
										<th class="center-align">Subject Name</th>
										<th class="center-align">Delete</th>
									</tr>
								</thead>
								<tbody>
									<%
									List<SubjectPerClass> subjectsPerClassList = (List<SubjectPerClass>) request.getAttribute("subjectsPerClassList");

									// Paint the rows of the subject table
									for (SubjectPerClass subjectPerClass : subjectsPerClassList) {
										out.println("");
										out.println("<tr><td class=\"center-align\">");
										out.println(subjectPerClass.getSubjectId());
										out.println("</td><td>");
										out.println(subjectPerClass.getSubjectName());
										out.println("</td><td class=\"center-align\">");
										out.println("<a href='javascript:fOpenDelete(" + "\"" + subjectPerClass.getClassId() + "\", " + "\""
										+ subjectPerClass.getSubjectId() + "\", " + "\"" + subjectPerClass.getSubjectName() + "\")'>"
										+ "<i class=\"material-icons\">delete</i></a>");
										out.println("</td></tr>");
									}
									%>
								</tbody>
							</table>


						</div>
				</div>
			</div>
		</div>
		<a class="btn-floating btn-large right waves-effect waves-light red"
			href="javascript:fOpenSubjectsAvailable();"> <i
			class="material-icons">add</i></a>
		<hr>
		</form>
	</div>

	<!-- Modal Structure -->
	<div id="modal1" class="modal">
		<form id="form1" class="col s12">

			<div class="modal-content">
				<h4>Subjects Available</h4>
				<div id="contenido">
					<div class="row">
						<div class="input-field col s12">
							<select id="subjectId" name="subjectId" class="select">
								<option value="" disables selected>Select the available
									subject</option>

								<%
								List<Subject> subjectsList = (List<Subject>) request.getAttribute("subjectsAvailableList");

								// Paint the rows of the subject table
								for (Subject subject : subjectsList) {
									out.println("<option value=\"" + subject.getSubjectId() + "\">");
									out.println(subject.getSubjectName());
									out.println("</option>");
								}
								%>
							</select> <label for="subjectId" class="active">Subjects Available</label>
						</div>
					</div>
					<div class="modal-footer">
						<button
							class="modal-close waves-effect waves-light btn accent-color"
							type="submit">Save Changes</button>
					</div>
				</div>
				<input type="text" id="action" name="action" value=""> <input
					type="text" id="classId" name="classId"
					value="<%=claseSelected.getClassId()%>">
			</div>
		</form>
		<hr>
	</div>

	<div id="modal2" class="modal">
		<form id="form2" class="col s12">

			<div class="modal-content">
				<h4>Delete Subject from Class</h4>
				<br />
				<p id="card-text">
					Click <b>SAVE CHANGES</b> if you want to remove the subject.
				</p>
			</div>
			<div class="modal-footer">
				<button
					class="modal-close waves-effect waves-light btn accent-color"
					type="submit">
					<i class="material-icons left">save</i>Save Changes
				</button>
			</div>
			<input type="hidden" id="action" name="action" value=""> <input
				type="hidden" id="deleteClassId" name="deleteClassId"
				value="<%=claseSelected.getClassId()%>"> <input
				type="hidden" id="deleteSubjectId" name="deleteSubjectId" value="">
			<input type="hidden" id="deleteSubjectName" name="deleteSubjectName"
				value="">
		</form>
		<br>
		<hr>
	</div>

	<script>
    async function handleSubmit(event) {
        event.preventDefault();

        const data = new FormData(event.target);
        const oFormEntries = Object.fromEntries(data.entries());
        console.log("----> about to saveOneSubject: " + oFormEntries.toString());
        await saveNewSubject(oFormEntries);
    }

    const form = document.querySelector('#form1');
    form.addEventListener('submit', handleSubmit);

    async function handleSubmitDelete(event) {
        event.preventDefault();

        const data = new FormData(event.target);
        const oFormEntries = Object.fromEntries(data.entries());
        console.log("----> about to deleteOneSubject: " + oFormEntries.toString());
        await deleteOneSubject(oFormEntries);
    }

    const form2 = document.querySelector('#form2');
    form2.addEventListener('submit', handleSubmitDelete);
</script>


	<!--  Scripts-->
	<script>
    async function fOpenSubjectsAvailable() {

        // Set the action
        const form1El = document.getElementById("form1");
        form1El.elements["action"].value = "saveNewSubjectPerClass";

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "flex"; // this centers the spinner in the modal window

        try {

            //Re-initialize the select controls
            M.FormSelect.init(document.querySelectorAll('.select'), {classes: ""});
            M.updateTextFields();

            await delay(1000);
            document.getElementById("preloader").style.display = "none";

        } catch (e) {
            // On Error
            console.log("ERROR: fetchOneSubject/querySelector - " + e);
        }
    }

    async function fOpenDelete(classId, subjectId, subjectName) {

        // Set the action
        const form2El = document.getElementById("form2");
        form2El.elements["action"].value = "deleteOneSubject";
        document.getElementById("deleteClassId").value = classId;
        document.getElementById("deleteSubjectId").value = subjectId;
        document.getElementById("deleteSubjectName").value = subjectName;

        // Trigger the Modal to open
        document.getElementById('modalLink2').click();
        document.getElementById("preloader2").style.display = "flex"; // this centers the spinner in the modal window
        await delay(1000);
        document.getElementById("preloader2").style.display = "none";

    }

    //ACTION: updateOneSubject or saveNewSubject
    function saveNewSubject(oFormEntries) {
        console.log(" -----> saveOneSubject:" + "");
        console.log(" -----> action: " + document.getElementById('action').value); //saveNewSubjectPerClass
        try {
            fetch("http://localhost:8080/pp2project/subjects-per-class-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> subjectjsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Subject NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function () {
                            location.reload()
                        }
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchSubjects/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }

    //ACTION: deleteOneSubject
    function deleteOneSubject(oFormEntries) {
        console.log(" -----> deleteOneSubject:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/subjects-per-class-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> subjectsPerClass.jsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Subject NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function () {
                            location.reload()
                        }
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchSubjects/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }
</script>



</body>
</html>

