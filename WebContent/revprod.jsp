
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.slidecontainer {
  margin-left: auto !important;
  margin-right: auto !important;
  width: 25%;
}

.slider {
  -webkit-appearance: none;
  width: 100%;
  height: 15px;
  border-radius: 5px;
  background: #d3d3d3;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider:hover {
  opacity: 1;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #4c63af;
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #4CAF50;
  cursor: pointer;
}
</style>
<title>ProperTech - product review</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>
<%
int productId = Integer.parseInt(request.getParameter("pID"));
int customerId = Integer.parseInt(request.getParameter("cusID"));
%>

<form align="center" action="revsubmit.jsp">
<h1 align="center" >Overall rating</h1>
<div align="center" class="slidecontainer">
    <input type="range" min="0" max="5" value="0" class="slider" id="myRange" name="myRange">
    <p><span id="demo"></span> Stars</p>
  </div>
  <script>
  var slider = document.getElementById("myRange");
  var output = document.getElementById("demo");
  output.innerHTML = slider.value;
  
  slider.oninput = function() {
  output.innerHTML = this.value;
  }

</script>

    <label for="rev">Add a written review (30 characters max):</label>
    <p></p>
    <textarea id="review" name="review" rows="4" cols="50"> </textarea>
    <p></p>
    <input class="submit" type="submit" name="Submit" value="Submit">
    </form>

   
</body>
</html>

