<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
img {
	width : 50px;
	height : 50px;
}
</style>
</head>
<body>
<h1>upload with ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<div class="uploadResult">
	<ul>
	
	</ul>
</div>

<button id="uploadBtn">Upload</button>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	var regex = new RegExp("(.*?)\.(exe|sh|js|alz)$"); // regular expression
	var maxSize = 5242880; // 5MB
	// file check
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)) {
			alert("허용되지 않는 확장자");
			return false;
		}
		return true;
	}
	
	var cloneOjb = $(".uploadDiv").clone();
	// upload button
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		
		// add fileData to formData
		for(var i = 0; i < files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
			contentType : false,
			data : formData,
			type : "POST",
			dataType:'json',
			success : function(result) {
				console.log(result);
				
				$(".uploadDiv").html(cloneOjb.html());
				
				showUploadFile(result);
			}
		});
	});
	
	// result 처리
	var uploadResult = $(".uploadResult ul");
	
	function showUploadFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(function(i, obj) {
			if(!obj.image) {
				var fileCellPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li><a href='/download?fileName="+fileCellPath+"'>"
					+  "<img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>";
			} else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCellPath = encodeURIComponent(obj.uploadPath + 
						"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li><img src='/display?fileName="+fileCellPath+"'></li>";
			}
		});
		uploadResult.append(str);
	}
	
	
});
</script>

</body>
</html>