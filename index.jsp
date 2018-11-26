<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Money vs. Meals</title>
  <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="css/homebrew/styles.css">
	<!--[if IE]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>

<body id="home">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Money vs. Meals</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
        </li>
        <%-- <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
        </li> --%>
    </div>
  </nav>

  <div class="container" id="container">
    <div class="row justify-content-center text-center">
      <div class="col-12 card p-3 m-4">
          This website gives you information about restaurants and areas of the United States.
      </div>
      <div class="col-6 card p-3">
        I'm looking for information about 
        <div class="btn-group p-1">
          <a class="btn btn-primary btn-sm m-1" href="jsp/onezipcode.jsp" role="button">One ZIP Code</a>
          <a class="btn btn-primary btn-sm m-1" href="jsp/twozipcodes.jsp" role="button">Two ZIP Codes</a>
        </div>
        <div class="btn-group p-1">
          <a class="btn btn-primary btn-sm m-1" href="jsp/onestate.jsp" role="button">One State</a>
          <a class="btn btn-primary btn-sm m-1" href="jsp/twostates.jsp" role="button">Two States</a>
          <a class="btn btn-primary btn-sm m-1" href="jsp/allstates.jsp" role="button">All States</a>
        </div>
        <div class="btn-group p-1">
          <a class="btn btn-primary btn-sm m-1" href="jsp/onerestaurant.jsp" role="button">One Restaurant</a>
          <a class="btn btn-primary btn-sm m-1" href="jsp/tworestaurants.jsp" role="button">Two Restuarants</a>
          <a class="btn btn-primary btn-sm m-1" href="jsp/allrestaurants.jsp" role="button">All Restaurants</a>
        </div>

        
      </div> 
    </div>
  </div>

    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/homebrew/scripts.js"></script>
</body>
</html>