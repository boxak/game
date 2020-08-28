<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Snake Game!</title>
<style>
	table{
		width : 450px;
		height : 400px;
		border : 1px solid black;
		border-collapse: collapse;
	}

</style>
</head>
<body>
<script type="text/javascript" src="/game/resources/Queue.js"></script>
<script type="text/javascript" src="/game/resources/Pair.js"></script>
<script>

	var head_row = 0;
	var head_col = 0;
	var rowSize = 20;
	var colSize = 20;
	var arr = make2DArr(rowSize,colSize,0);
	var que = new Queue();
	
	var score = 0;
	var dir = 1;
	var difficulty = 0;
	
	var dr = [-1,0,1,0];
	var dc = [0,1,0,-1];

	window.onload = function(){
		initSnake();
		drawGrid();
	}
	
	function init_game(){
		initSnake();
		drawGrid();
	}
	
	function drawGrid(){
		var snakeTableDom = document.getElementById("snake_table");
		var str = "";
		for(var i=0;i<rowSize;i++){
			str+="<tr>\n\t";
			for(var j=0;j<colSize;j++){
				if(arr[i][j]==1){
					str+="<td style='width:14px;height:14px;border:1px solid #444444;background-color: #0d47a1;'></td>";
				}
				else if(arr[i][j]==2){
					str+="<td style='width:14px;height:14px;border:1px solid #444444;background-color: gray;'></td>";
				}
				else str+="<td style='width:14px;height:14px;border:1px solid #444444;'></td>";
			}
			str+="\n</tr>\n";
		}
		snakeTableDom.innerHTML=str;
	}
	
	function initSnake(){
		
		head_row = 0;
		head_col = 0;
		rowSize = 20;
		colSize = 20;
		arr = make2DArr(rowSize,colSize,0);
		que = new Queue();
		
		score = 0;
		dir = 1;
		difficulty = 0;
		
		head_row = Math.floor(rowSize*Math.random());
		head_col = Math.floor(colSize*0.5*Math.random());
		
		arr[head_row][head_col] = 1;
		que.enqueue(new Pair(head_row,head_col));
	
		makeApple();
	}
	
	function make2DArr(n,m,initial){
		var a,i,j;
		var mat = [];
		for(i=0;i<n;i++){
			a = [];
			for(j=0;j<m;j++){
				a[j] = initial;
			}
			mat[i] = a;
		}
		return mat;
	};
	
	function makeApple(){
		while(true){
			var row = Math.floor(Math.random()*rowSize);
			var col = Math.floor(Math.random()*colSize);
			if(arr[row][col]==0){
				arr[row][col] = 2;
				break;
			}
		}
	}
	
	function gameStart(){
		document.body.addEventListener('keydown',keypress);
		
		var over = false;
		var eatApple = false;
		
		function moveSnake(){
			var r = que.front().first;
			var c = que.front().second;
			console.log(r+' '+c);
			que.dequeue();
				
			var nr = r+dr[dir];
			var nc = c+dc[dir];
				
			if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize){
				over = true;
			}
			if(arr[nr][nc]==1){
				over = true;
			}
				
			if(arr[nr][nc]==2){
				eatApple = true;
				score++;
			}
				
			arr[r][c] = 0;
			arr[nr][nc] = 1;
			que.enqueue(new Pair(nr,nc));
			nr = r;
			nc = c;
				
			var qSize = que.size()-1;
				
			while(qSize>0){
				qSize--;
				r = que.front().first;
				c = que.front().second;
				que.dequeue();
					
				arr[r][c] = 0;
				arr[nr][nc] = 1;
				que.enqueue(new Pair(nr,nc));
				nr = r;
				nc = c;
			}
			if(eatApple==true){
				eatApple = false;
				arr[r][c] = 1;
				que.enqueue(new Pair(r,c));
				makeApple();
			}
			drawGrid();
			if(over==true){
				clearInterval(repeat);
				var gamerName = prompt("점수 : "+score+"\n이름을 입력해주세요~");
				if(gamerName!=null){
					insertScore(gamerName,score);
				}
			}
			console.log("over : "+over);
		}
		
		
		var repeat = setInterval(moveSnake,100);
		
	}
	
	//왼쪽 : 37
	//윗방향 : 38
	//오른쪽 : 39
	//아래 : 40
	function keypress(e){
		console.log(e.keyCode);
		if(dir==0 && (e.keyCode==37 || e.keyCode==39)){
			if(e.keyCode==37) dir = 3;
			if(e.keyCode==39) dir = 1;
		}
		if(dir==1 && (e.keyCode==38 || e.keyCode==40)){
			if(e.keyCode==38) dir = 0;
			if(e.keyCode==40) dir = 2;
		}
		if(dir==2 && (e.keyCode==37 || e.keyCode==39)){
			if(e.keyCode==37) dir = 3;
			if(e.keyCode==39) dir = 1;
		}
		if(dir==3 && (e.keyCode==38 || e.keyCode==40)){
			if(e.keyCode==38) dir = 0;
			if(e.keyCode==40) dir = 2;
		}
	}
	
	function insertScore(name,score){
		var request = new XMLHttpRequest();
		request.onload = function(){
			if(request.status==200){
				var str = request.responseText;
				alert(str);
				document.location.href = "/game/${gameKind}";
			}
		}
		request.open('GET','/game/insertScore?kind=snake&name='+name+'&score='+score,true);
		request.send();
	}
	
</script>
<div style="position:absolute;top:10%;left:30%;text-align:center">
<h2>Snake Game!</h2>
<table id="snake_table">
</table>
<br>
<button id="start-btn" onclick="gameStart();">시작하기</button>
<button id="reset-btn" onclick="init_game()">다시 시작</button>
<button id="ranking-btn" onclick="location.href='/game/rankingBoard?kind=${gameKind}'">점수 보기</button>
</div>
</body>
</html>