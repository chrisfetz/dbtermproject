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
        <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
        </li>
    </div>
  </nav>

  <div class="container" id="container">
    <div class="row justify-content-center">
      <div class="col-12 card">
          This website gives you information about restaurants and areas of the United States.
      </div>
      <form class="col-4 card" name="myform" action="results.jsp">
        I'm looking for information about 
        <span>
          <label class="radio-inline"><input type="radio" name="radiocount" value="one" onclick="radioClick(this);" checked>one</label>
          <label class="radio-inline"><input type="radio" name="radiocount" value="two" onclick="radioClick(this);">two</label>
          <label class="radio-inline"><input type="radio" name="radiocount" value="all" onclick="radioClick(this);">all</label>
        </span>
        <span>
          <label class="radio-inline"><input type="radio" name="radiotype" value="zip" id="zipradio" onclick="radioClick(this);" checked>zip code(s)</label>
          <label class="radio-inline"><input type="radio" name="radiotype" value="state" id="zipstate" onclick="radioClick(this);">state(s)</label>
          <label class="radio-inline"><input type="radio" name="radiotype" value="rest" onclick="radioClick(this);">restaurant(s)</label>
        </span>

        <div id="inputs-here">
          <div class="input-group input-group-sm mb-3" id="textinputgroup1">
            <div class="input-group-prepend">
              <span class="input-group-text" id="textinputlabel1">ZIP Code 1</span>
            </div>
            <input type="text" class="form-control" id="textinput1" name="textinputs" aria-label="Text input 1" aria-describedby="inputGroup-sizing-sm">
          </div>
          <div class="input-group input-group-sm mb-3" id="textinputgroup2">
            <div class="input-group-prepend">
              <span class="input-group-text" id="textinputlabel2" style="display:none;">ZIP Code 2</span>
            </div>
            <input type="text" class="form-control" id="textinput2" name="textinputs" style="display:none;" aria-label="Text input 2" aria-describedby="inputGroup-sizing-sm">
          </div>
        </div>

        <input type="submit" value="submit">
      </form> 
    </div>
  </div>

    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/homebrew/scripts.js"></script>
</body>
</html>