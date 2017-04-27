<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- <%@page import="com.imagic.GlobalCons"%>
 --%><%@page import="com.test.Oauth2callback"%>
 <%@page import="com.test.AddJdo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <%
         response.setHeader("Cache-Control","no-cache");
         response.setHeader("Cache-Control","no-store");
         response.setHeader("Pragma","no-cache");
         response.setDateHeader ("Expires", 0);
         String loggedInUser = (String) session.getAttribute("email");
             if(session.getAttribute("email")==null){
             	response.sendRedirect(request.getContextPath() + "/home");
         	}
         %>
      <title>Your Todo</title>
      
   </head>
   <style>
      body {
      margin: 0;
      min-width: 250px;
      }
      h1{
      padding: 4px 15px;
      }
      /* Include the padding and border in an element's total width and height */
      {
      box-sizing: border-box;
      }
      /* Remove margins and padding from the list */
      ul {
      margin: 40px;
      padding: 0;
      }
      /* Style the list items */
      ul li {
      display: inline-block;
      width: 73.75%;
      cursor: pointer;
      position: relative;
      /*   padding: 12px 8px 12px 40px;*/
      background: #eee;
      font-size: 18px;
      transition: 0.2s;
      /* make the list items unselectable */
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
      }
      /* Set all odd list items to a different color (zebra-stripes) */
      ul li:nth-child(odd) {
      background: #f9f9f9;
      }
      /* Darker background-color on hover */
      ul li:hover {
      background: #ddd;
      }
      /* When clicked on, add a background color and strike out text */
      ul li.checked {
      background: #888;
      color: #fff;
      text-decoration: line-through;
      }
      ul li>div.checked {
      background: #888;
      color: #fff;
      text-decoration: line-through;
      }
      /* Add a "checked" mark when clicked on */
      ul li>div.checked::before {
      content: '';
      position: absolute;
      border-color: #fff;
      border-style: solid;
      border-width: 0 2px 2px 0;
      top: 10px;
      left: 16px;
      transform: rotate(45deg);
      height: 15px;
      width: 7px;
      }
      ul li>div{
      height: 45px;
      float: left;
      width: 96%;
      line-height: 43px;
      padding-left: 45px;
      }
      /* Style the close button */
      .close {
      position: absolute;
      height: 21px;
      right: -5px;
      top: 0;
      padding: 12px 16px 12px 16px;
      background: cornflowerblue;
      }
      .close:hover {
      background-color: #f44336;
      color: white;
      }
      /* Style the header */
      .header {
      padding: 30px 40px;
      color: black;
      text-align: center;
      }
      /* Clear floats after the header */
      .header:after {
      content: "";
      display: table;
      clear: both;
      }
      /* Style the input */
      input {
      border: groove;
      width: 60%;
      padding: 10px;
      float: left;
      font-size: 16px;
      }
      /* Style the "Add" button */
      .addBtn {
      padding: 13.5px;
      width: 4%;
      background: cornflowerblue;
      float: left;
      text-align: center;
      font-size: 16px;
      cursor: pointer;
      transition: 0.3s;
      }
      .addBtn:hover {
      background-color: #bbb;
      }
      a {
      text-decoration: none ! important;
      float: right;
      padding: 5px 30px;
      font-size: 22px;
      font-family: Times New Roman;
      font-weight: bold;
      }
      element.style {
    margin-left: 161px;
}
li:not(:last-child) {
    margin-bottom: 12px;
}
   </style>
   <body onload="loading()">
   			 		<body background="http://cdn.pcwallart.com/images/light-blue-background-wallpaper-2.jpg">
   
   	  <a href="/logout">Logout</a>
        <!-- <a href="/logout" class="btn btn-info btn-lg">
          <span class="glyphicon glyphicon-log-out"></span> Logout
        </a> -->
        
	  <h1>Welcome <%=session.getAttribute("email")%></h1>
	  
	  
	  
	     <center>  <h1>My To Do List</h1> </center> 
	  
      <div id="myDIV" class="header">
         <input type="text" id="inputText" placeholder="What needs to be done?" style=margin-left:163px;
         onkeypress="keyCode(event);">
         <span onclick="addElement();" class="addBtn">Add</span>
      </div>
      <center><ul id="todo">
      </ul></center>
      <script type="text/javascript">
         var todoArray = [];
         var myNodelist = document.getElementsByTagName("LI");
         var i;
         for (i = 0; i < myNodelist.length; i++) {
           var span = document.createElement("SPAN");
           var txt = document.createTextNode("\u00D7");
           span.className = "close";
           span.appendChild(txt);
           myNodelist[i].appendChild(span);
         }
         
         // Click on a close button to hide the current list item
         
         
         var close = document.getElementsByClassName("close");
         var i;
         for (i = 0; i < close.length; i++) {
           close[i].onclick = function() {
             var div = this.parentElement;
             div.style.display = "none";
           }
         }
         
         
         // Add a "checked" symbol when clicking on a list item
         /* var list = document.querySelector('ul');
         list.addEventListener('click', function(ev) {
           if (ev.target.tagName === 'LI') {
             ev.target.classList.toggle('checked');
           }
         }, false); */
         
         function loading(){
         	var email = '<%=loggedInUser%>';
         	var xhttp = new XMLHttpRequest();
         	  xhttp.onreadystatechange = function() {
         	    if (this.readyState == 4 && this.status == 200) {
         	    	
         	    	try {
                         var data = JSON.parse(xhttp.responseText);
                         
                         for(var item in data) {
         	                  var li = document.createElement("li");
         	           	      var t = document.createTextNode(data[item].name);
         	           	      var div = document.createElement("div");
         	           	      var id = data[item].key;
         	           	      var status = data[item].status;
         	           	      li.setAttribute("id", id);
         	           	      if( status  == "inactive")
         	           	      {
         	           	    	div.className = "checked";
         	           	      } else {
         	           	      	div.className = "active";
         	           	      }
         	           	      //li.appendChild(t);
         	           	      li.appendChild(div);
         	           	      div.appendChild(t);
         	           	      div.setAttribute("id",id);
         	           	      document.getElementById("todo").appendChild(li);
         	           	    
         	           	      
         	           		 $('#todo div').unbind('click').bind('click',function(e){
         	          			var id = $(this).attr("id");
         	          			if ( $( this ).hasClass( "checked" ) ) {
         	          					$( this ).removeClass( "checked" );
         	          			 		status = "active";
         	          			 		update(id,status);
         	          			 		return false;
         	          			 		
         	          			    }  else {
         	          			    	$( this ).addClass( "checked" );
         	          			    	status = "inactive";
         	          			 		update(id,status);
         	          			 		return false;
         	          			    }
         	          			
         	          	}); 
         	           	      document.getElementById("inputText").value = "";
         	           	      var span = document.createElement("TEXTBOX");
         	           	      var txt = document.createTextNode("\u00D7");
         	           	      span.className = "close";
         	           	      span.setAttribute("id", id);
         	           	      span.appendChild(txt);
         	           	      li.appendChild(span);
         	           	      todoArray.push(id);
         	             $('.close').unbind('click').bind('click',function(e){
         	           		var id = $(this).attr("id");
         	           		
         	           		var index = todoArray.indexOf(id);
         	           		
         	           		if (index > -1) {
         	           			var del = todoArray.splice(index, 1);
         	           			loadDoc(del);
         	           		}
         
         
         	           		console.log(todoArray);
         	           		$(this).parent().hide();
         	           	});
                         }
                         
                     } catch(err) {
                         console.log(err.message + " in " + xhttp.responseText);
                         return;
                     }
         	    	
         	      }
         	  };
         	  xhttp.open("POST", "/addJdo?email="+email, true);
         	  xhttp.send();
         	}
         function keyCode(event){
        	 var x = event.keyCode;
        	 if(x == 13){
        		 addElement();
        		 return false;
        	 }
        	 else{
        		 return false;
        	 }
         }
         function addElement(){
         	  var email = '<%=loggedInUser%>';
         	  var li = document.createElement("li");
         	  var div = document.createElement("div");
         	  var id = guid();
         	  var status = "active";
         	  li.setAttribute("id", id);
         	  var inputValue = document.getElementById("inputText").value;
         	  var t = document.createTextNode(inputValue);
         	  li.appendChild(div);
         	  div.appendChild(t);
         	  div.setAttribute("id",id);
         	  if (inputValue === '') {
         	    alert("Please provide a task!");
         	    return;
         	  } else {
         	    document.getElementById("todo").appendChild(li);
         	  }
         	 $('#todo div').unbind('click').bind('click',function(e){
         			var id = $(this).attr("id");
         			if ( $( this ).hasClass( "checked" ) ) {
         					$( this ).removeClass( "checked" );
         			 		status = "active";
         			 		update(id,status);
         			 		return false;
         			    }  else {
         			    	$( this ).addClass( "checked" );
         			    	status = "inactive";
         			 		update(id,status);
         			 		return false;
         			    }
         			
         	}); 
         	  document.getElementById("inputText").value = "";
         	  var span = document.createElement("TEXTBOX");
         	  var txt = document.createTextNode("\u00D7");
         	  span.className = "close";
         	  span.setAttribute("id", id);
         	  span.appendChild(txt);
         	  li.appendChild(span);
         		todoArray.push(id);
         		 $('.close').unbind('click').bind('click',function(e){
         				var id = $(this).attr("id");
         				
         				var index = todoArray.indexOf(id);
         				
         				if (index > -1) {
         					var del = todoArray.splice(index, 1);
                    			loadDoc(del);
         				}
         
         
         				console.log(todoArray);
         				$(this).parent().hide();
         				
         			});
         		 
         		  var myObj = {};
         
         		  myObj.name = inputValue;
         		  myObj.key  = id;
         		  myObj.email = email;
         		  myObj.status = status;
         		  
         		  console.log(myObj);
         		  
         		  addTodo(myObj);
         		}
         		function addTodo(myObj) {
         			  var xhttp = new XMLHttpRequest();
         			  xhttp.onreadystatechange = function() {
         			    if (this.readyState == 4 && this.status == 200) {
         			    	console.log("added");
         			    }
         			  };
         			  xhttp.open("POST", "/addTodo?todoArray="+JSON.stringify(myObj), true);
         			  xhttp.send();
         			}
         //UUID
         function guid() {
         	  function s4() {
         	    return Math.floor((1 + Math.random()) * 0x10000)
         	      .toString(16)
         	      .substring(1);
         	  }
         	  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
         	    s4() + '-' + s4() + s4() + s4();
         	}
         
         
         function update(id,status) {
         		  var xhttp = new XMLHttpRequest();
         		  xhttp.onreadystatechange = function() {
         		    if (this.readyState == 4 && this.status == 200) {
         		      console.log("Status changed");
         		    }
         		  };
         		  xhttp.open("POST", "/update?status="+status+"&key="+id, true);
         		  xhttp.send();
         		} 
         		
         function loadDoc(del) {
         	  var xhttp = new XMLHttpRequest();
         	  xhttp.onreadystatechange = function() {
         	    if (this.readyState == 4 && this.status == 200) {
         	    	console.log("deleted");
         	    }
         	  };
         	  xhttp.open("POST", "/delTodo?delElement="+del, true);
         	  xhttp.send();
         	}
      </script>
   </body>
</html>