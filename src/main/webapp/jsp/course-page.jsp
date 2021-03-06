<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="David Parr">
    <link rel="icon" href="../../favicon.ico">

    <title>School Portal</title>

    <link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/css/sidebar-stylesheet.css" />" rel="stylesheet">
    <link href="<c:url value="/css/course-stylesheet.css" />" rel="stylesheet">
    
    <script src="<c:url value="/js/course-page.js" />"></script>
    
  </head>
  
  <body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button> <!-- /.navbar-toggle collapsed -->
          <a class="navbar-brand" href="#">MCIT Portal</a>
        </div> <!-- ./navbar-header -->
        <div class="collapse navbar-collapse" id="navbar">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><c:out value="${user}"/></a></li>
            <li><a href="<c:url value="/logout.jsp"/>">Sign Out</a></li>
          </ul> <!-- /.nav .navbar-nav .navbar-right -->
        </div> <!-- /.navbar-collapse -->
      </div> <!-- /.container-fluid -->
    </nav> <!-- ./navbar navbar-default navbar-fixed-top -->

    <div class="sidebar">  
      <div class="container-fluid">
        <div class="row">
  	     <div class="col-sm-2">
            <nav class="nav-sidebar">
              <ul class="nav tabs">
                <li class=""><a href="<c:url value="/school/student"/>">Students</a></li>
                <li class="active"><a href="<c:url value="/school/course"/>">Courses</a></li>
                <li class=""><a href="<c:url value="/school/result"/>">Results</a></li>
              </ul> <!-- /.nav .tabs -->
            </nav> <!-- /.nav-sidebar -->
          </div> <!-- /.col-sm-2 -->
          <div class="col-sm-10">
            <div class="tab-content">
              <div class="tab-pane active text-style" id="tab2">
                <div class="course-form">
                  <div class="row">
                    <div class="col-sm-12">
                      <h2>Course Details</h2>
                    </div> <!-- /.col-sm-12 -->
                  </div> <!-- /.row -->
                  <div class="row">
                    <div class="col-sm-12">
                      
                      <form action="${pageContext.request.contextPath}/school/course/create" onsubmit="return validateCourseForm()" method="post">
                        <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                              <label for="courseCode">Course Code</label>
                              <input type="text" name="courseCode" class="form-control" id="courseCode">
                            </div>
                          </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                              <label for="courseName">Course Name</label>
                              <input type="text" name="courseName" class="form-control" id="courseName">
                            </div>
                          </div>
                        </div>
                        
                        <div class="row">
                          <div class="col-sm-5">
                            <div class="form-group">
                              <label for="sel1">Available Semesters (hold shift to select more than one)</label>
                              <select multiple="multiple" name="availableSemesters" class="form-control" id="sel1">
                                <c:forEach var="sem" items="${allSemesters}">
                                  <option>
                                    <c:out value="${sem.semester}"/>
                                  </option>
                                </c:forEach>
                              </select>
                            </div>  <!-- /.form-group -->
                          </div> <!-- /.col-sm-5 -->
                          <div class="col-sm-2">
                            <div class="select-arrows">
                              <button type="button" onclick="rightBox()" name="right" value=right class="btn btn-default"><span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span></button>
                              <button type="button" onclick="leftBox()" name="left" value="left" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span></button>
                            </div>
                          </div> <!-- /.col-sm-2 -->
                          <div class="col-sm-5">
                            <div class="form-group">
                              <label for="sel2">Active Semesters (hold shift to select more than one)</label>
                              <select multiple="multiple" name="activeSemesters" class="form-control" id="sel2">
                              </select>
                            </div>  <!-- /.form-group -->
                          </div> <!-- /.col-sm-5 -->
                        </div> <!-- /.row -->
                        
                        <div class="row">
                          <div class="col-sm-12">
                            <button type="submit" name="option" value="save" class="btn btn-primary">Submit</button>
                          </div>
                        </div>
                      </form>
                      
                      <div class="table-section">
                        <div class="row">
                          <div class="col-sm-12">
                          
                            <table class="table table-hover">
                              <thead>
                                <tr>
                                  <th>Course Code</th>
                                  <th>Course Name</th>
                                  <th>Semesters</th>
                                  <th>Edit</th>
                                  <th>Assign Students</th>
                                  <th>Delete</th>
                                </tr>
                              </thead>
                              <tbody>
                                <c:forEach var="course" items="${allCourses}">
                                  <tr>
	                                  <td><c:out value="${course.courseCode}" /></td>
	                                  <td><c:out value="${course.courseName}"/></td>
                                    <td>
                                      <c:forEach var="sem" items="${course.listOfSemesters}">
                                        <c:out value="${sem.semester}"/>
                                      </c:forEach>
                                    </td>
                                    <td><a href=<c:url value="/school/course/edit/${course.courseId}"/>>Edit</a></td>
                                    <td><a href=<c:url value="/school/course/assign/${course.courseId}"/>>Assign</a></td>
                                    <td><a onclick="return confirmCourseDelete()" href=<c:url value="/school/course/delete/${course.courseId}"/>>Delete</a></td>
                                  </tr>
                                </c:forEach>
                              </tbody>
                            </table>
                          
                          </div>
                        </div>
                      </div>
                    
                    </div>
                  </div>
                </div> <!-- /.course-form -->
              </div> <!-- /.tab-pane .text-style -->
            </div> <!-- /.tab-content -->
          </div> <!-- /.col-sm-10 -->
        </div> <!-- /.row -->
      </div> <!-- /.container-fluid -->
    </div> <!-- /.sidebar -->
    
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="<c:url value="/js/bootstrap.min.js" />"></script>
  </body>
</html>