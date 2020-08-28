<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tetris game!</title>
<style>
	table{
		width : 200px;
		height : 400px;
		border : 1px solid black;
		border-collapse: collapse;
	}

</style>
</head>
<body>
<script type="text/javascript" src="/game/resources/make2DArr.js"></script>
<script>

	var map = make2DArr(20,10,0);
	var rowSize = 20;
	var colSize = 10;
	var dir = 2;
	var score = 0;
	var blockRot = 1;
	
	var dr = [-1,0,1,0];
	var dc = [0,1,0,-1];
	
	var blockNum = 0;
	var block = [];
	var headr = -2;
	var headc = 4;
	
	window.onload = function(){
		drawGrid();
	}
	
	function drawGrid(){
		var tetrisTableDom = document.getElementById("tetris_table");
		var str = "";
		for(var i=0;i<rowSize;i++){
			str+="<tr>\n\t";
			for(var j=0;j<colSize;j++){
				str+="<td style='width:14px;height:14px;border:1px solid #444444;'></td>";
			}
			str+="\n</tr>\n";
		}
		tetrisTableDom.innerHTML=str;
	}
	
	function gameStart(){
		while(true){
			aboutOneBlock();
		}
	}
	
	function aboutOneBlock(){
		blockNum = Math.floor(Math.random()*7+1);
		block = drawBlock(blockNum,blockRot);
		document.body.addEventListner('keydown',keypress);
		
		headr = -2;
		headc = 4;
		var repeat = setInterval(moveBlock,500);
	}
	
	function drawBlock(num,rot){
		var block;
		if(num==1){
			if(rot==1){
				block = [[0,0],[-1,0],[-2,0],[-3,0]];
			}
			if(rot==2){
				block = [[0,0],[0,1],[0,2],[0,3]];
			}
		}
		if(num==2){
			block = [[0,0],[0,1],[-1,0],[-1,1]];
		}
		if(num==3){
			if(rot==1){
				block = [[0,0],[0,1],[-1,1],[-1,2]];
			}
			if(rot==2){
				block = [[0,0],[-1,0],[-1,-1],[-2,-1]];
			}
		}
		if(num==4){
			if(rot==1){
				block = [[0,0],[0,-1],[-1,-1],[-1,-2]];
			}
			if(rot==2){
				block = [[0,0],[-1,0],[-1,1],[-2,1]];
			}
		}
		if(num==5){
			if(rot==1){
				block = [[0,0],[0,1],[0,2],[-1,1]];
			}
			if(rot==2){
				block = [[0,0],[-1,0],[-2,0],[-1,1]];
			}
			if(rot==3){
				block = [[0,0],[-1,-1],[-1,0],[-1,1]];
			}
			if(rot==4){
				block = [[0,0],[-1,0],[-2,0],[-1,-1]];
			}
		}
		if(num==6){
			if(rot==1){
				block = [[0,0],[0,1],[0,2],[-1,2]];
			}
			if(rot==2){
				block = [[0,0],[0,-1],[-1,-1],[-2,-1]];
			}
			if(rot==3){
				block = [[0,0],[-1,0],[-1,1],[-1,2]];
			}
			if(rot==4){
				block = [[0,0],[-1,0],[-2,0],[-2,-1]];
			}
		}
		if(num==7){
			if(rot==1){
				block = [[0,0],[0,-1],[0,-2],[-1,-2]];
			}
			if(rot==2){
				block = [[0,0],[-1,0],[-2,0],[-2,1]];
			}
			if(rot==3){
				block = [[0,0],[-1,0],[-1,-1],[-1,-2]];
			}
			if(rot==4){
				block = [[0,0],[0,1],[-1,1],[-2,1]];
			}
		}
		return block;
	}

</script>
<div style="position:absolute;top:10%;left:20%;text-align:center">
<h2>Tetris game!</h2>
<table id="tetris_table">
</table>
<br>
<button id="start-btn" onclick="gameStart();">시작하기</button>
<button id="reset-btn" onclick="init_game();">다시하기</button>
<button id="ranking-btn" onclick="location.href='/game/rankingBoard?kind=${gameKind}'">점수 보기</button>
</div>
</body>
</html>