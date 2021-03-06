<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Money vs. Meals</title>
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="../css/homebrew/styles.css">
	<!--[if IE]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>

<body id="home" onload="populateRestaurants();">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="../index.jsp">Money vs. Meals</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="../index.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="../about.html">About <span class="sr-only">(current)</span></a>
        </li>
        <%-- <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
        </li> --%>
    </div>
  </nav>

  <div class="container p-4" id="container">
    <div class="row justify-content-center">
      <form class="col-4 card" name="myform" id="myform" action="../results.jsp">

        <div class="text-center p-4">
            Please choose a restaurant.
        </div>

        <div name="inputs-here">
          <div class="input-group input-group-sm mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">Restaurant</span>
            </div>
            <input type="hidden" class="form-control" name="radiocount" value="One" aria-describedby="inputGroup-sizing-sm">
            <input type="hidden" class="form-control" name="radiotype" value="Restaurant" aria-describedby="inputGroup-sizing-sm">
            <select class="form-control" name="textinput1">
            </select>    
            </div>
        </div>

        <input type="submit" class="m-3" value="Submit">
      </form> 
    </div>
  </div>

    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="../js/homebrew/scripts.js"></script>
</body>
</html>

<style>
.form-control:focus {
  border-color: #007bff;
  box-shadow: 0 0 0 0.05rem #007bff;
}
</style>