<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body>

	<br />
	<div class="container">
		<div class="col s12 m7">

			<div class="col s12 m7">
				<center>
					<h1>Welcome to Learners' Academy</h1>
				</center>
				<div>

					<center>
						<div>
							<h3>ADMIN LOGIN</h3>
							<form method="GET" action="./login-controller">
								<div class="card-content primary-text-color">
									USER NAME: <input type="text" name="username" /><br />
									PASSWORD : <input type="password" name="password" />
								</div>
								<div>
									<br> <input type="submit" value="LOG IN" />
								</div>
							</form>
						</div>
						<h2 class="header red">Error When Trying to Login</h2>
						<p class="light">Type the correct User and Password</p>
					</center>
				</div>
			</div>
		</div>
	</div>


	<!--  Scripts-->
	<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="js/materialize.js"></script>
	<script src="js/init.js"></script>

</body>
</html>




