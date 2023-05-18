<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.List"%>
<%@ page import="model.Class"%>


<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>


<body>

	<br />
	<br />
	<div>
		<div>
			<h2>Classes</h2>
			<div>

				<div>
					<div>

						<table id="myTable">
							<thead>
								<tr>
									<th>Edit</th>
									<th>ID</th>
									<th>Class Name</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Class> clasesList = (List<Class>) request.getAttribute("classesList");

								// Paint the rows of the clase table
								for (Class clase : clasesList) {
									out.println("");
									out.println("<tr><td >");
									out.println("<a href='javascript:fOpenEdit(\"" + clase.getClassId() + "\")'>" + "edit</a>");
									out.println("</td><td>");
									out.println(clase.getClassId());
									out.println("</td><td>");
									out.println(clase.getClassName());

									out.println("</td><td >");
									out.println("<a href='javascript:fOpenDelete(\"" + clase.getClassId() + "\")'>delete</a>");
									out.println("</td></tr>");
								}
								%>
							</tbody>
						</table>


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
				<h4>Class Detail</h4>
				<div>
					<div>
						<div>
							<input type="text" id="classId" name="classId" value="">
							<label for="classId" class="active">Class</label>
						</div>
					</div>

					<div>
						<div>
							<input type="text" id="className" name="className" value="">
							<label for="className" class="active">Class Name</label>
						</div>
					</div>
					<input type="hidden" id="action" name="action" value=""> <input
						type="hidden" id="deleteClassId" name="deleteClassId" value="">

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
        console.log("----> about to saveOneClass: " + oFormEntries.toString());
        await saveOneClass(oFormEntries);
    }

    const form = document.querySelector('#form1');
    form.addEventListener('submit', handleSubmit);
</script>


	<!--  Scripts-->
	<script>
    async function fOpenEdit(pId) {

        // Set the action
        document.getElementById("action").value = "updateOneClass";

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "flex"; // this centers the spinner in the modal window

        fetch("http://localhost:8080/pp2project/class-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneClass", classId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#classId").value = jsonObject.classId;
                document.querySelector("#className").value = jsonObject.className;

                //Re-initialize the select controls
                M.updateTextFields();

                // Hide the spinner
                await delay(1000);
                document.getElementById("preloader").style.display = "none";

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneClass/querySelector - " + e);
            }

        });
    }

    async function fOpenDelete(pId) {

        // Set the action
        document.getElementById("action").value = "deleteOneClass";

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "flex"; // this centers the spinner in the modal window

        fetch("http://localhost:8080/pp2project/class-controller", {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: JSON.stringify({action: "fetchOneClass", classId: pId})

        }).then(res => res.text()).then(async (jsonString) => {
            console.log(" -------> fetch: " + jsonString);
            try {

                //Painting the values AND disabling the controls
                const jsonObject = JSON.parse(jsonString);
                console.log("---> jsonString: " + jsonString);
                document.querySelector("#classId").value = jsonObject.classId;
                document.querySelector("#className").value = jsonObject.className;
                // Display the modal, hide the spinner

                //Re-initialize the select controls
                M.updateTextFields();

                // Disabling the controls
                document.querySelector("#classId").disabled  = true;
                document.querySelector("#className").disabled  = true;

                //Setting the Id to delete
                document.querySelector("#deleteClassId").value = jsonObject.classId;
                await delay(1000);
                document.getElementById("preloader").style.display = "none";

            } catch (e) {
                // On Error
                console.log("ERROR: fetchOneClass/querySelector - " + e);
            }

        });
    }

    async function fOpenNew() {

        // Set the action
        document.getElementById("action").value = "saveNewClass";

        //Clean and enabling the controls
        document.querySelector("#classId").disabled  = false;
        document.querySelector("#className").disabled  = false;
        document.getElementById("classId").disabled = false;

        M.FormSelect.init(document.querySelectorAll('.select'), {classes: ""});
        M.updateTextFields();

        // Trigger the Modal to open
        document.getElementById('modalLink').click();
        document.getElementById("preloader").style.display = "none";

    }

    //ACTION: updateOneClass or saveNewClass
    function saveOneClass(oFormEntries) {
        console.log(" -----> saveOneClass:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/class-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> clasejsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Class NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchClass/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }

    //ACTION: updateOneClass or saveNewClass
    function deleteOneClass(oFormEntries) {
        console.log(" -----> deleteOneClass:" + "");
        console.log(" -----> action: " + document.getElementById('action').value);
        try {
            fetch("http://localhost:8080/pp2project/class-controller", {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(oFormEntries)
            })
                .then(res => res.text()).then((jsonReturnString) => {
                console.log(" -------> clasejsp fetch: " + jsonReturnString);
                try {

                    //Answer received from the servlet
                    const jsonObject = JSON.parse(jsonReturnString);
                    M.toast({
                        html:
                            jsonObject.code === 0 ? jsonObject.message : "<table><tr><td class=\"center-align\">Class NOT UPDATED</td></tr><tr><td>CODE: " + jsonObject.code +
                                " - " +
                                jsonObject.message + "</td></tr></table>"
                        , completeCallback: function(){location.reload()}
                    })
                } catch (e) {
                    // On Error
                    console.log("ERROR: fetchClass/querySelector" + e);
                }

            });
        } catch (e) {
            console.log(e);
        }
    }
</script>


</body>
</html>

