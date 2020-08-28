<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2048 game!</title>
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
<script type="text/javascript" src="/game/resources/make2DArr.js"></script>
<script>
	
	var rowSize = 4;
	var colSize = 4;
	var score = 0;
	var dir = 0;
	
	var dr = [-1,0,1,0];
	var dc = [0,1,0,-1];
	
	var map = make2DArr(rowSize,colSize,0);
	
	window.onload = function(){
		init_game();
		drawTable();
	}
	
	function init_game(){
		map = make2DArr(rowSize,colSize,0);
		score = 0;
		drawTable();
	}
	
	function drawTable(){
		var tableDom = document.getElementById("2048_table");
		console.log(map[0][0]);
		var str = "";
		for(var i=0;i<rowSize;i++){
			str+="<tr>\n\t";
			for(var j=0;j<colSize;j++){
				if(map[i][j]==0){
					str+="<td style='width:14px;height:14px;border:1px solid #444444;background-color: white;'></td>";
				}
				
				else{
					if(map[i][j]==2){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#eee4da;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==4){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#ede0c8;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==8){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#f2b179;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==16){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#f59563;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==32){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#f67c5f;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==64){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#f65e3b;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==128){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#f65e3b;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==256){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#edcc61;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==512){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#edc850;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==1024){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#edc850;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
					if(map[i][j]==2048){
						str+="<td style='width:14px;height:14px;border:1px solid #444444; text-align:center; background-color:#edc850;color:white;font-weight: bold;'>"+map[i][j]+"</td>";
					}
				}
			}
			str+="\n</tr>\n";
		}
		tableDom.innerHTML=str;
	}

	function startGame(){
		map[0][0] = 2;
		console.log(map[0][0]);
		drawTable();
		document.body.addEventListener('keydown',keypress);
	}
	
	function keypress(e){
		if(e.keyCode==37) dir = 3;
		if(e.keyCode==38) dir = 0;
		if(e.keyCode==39) dir = 1;
		if(e.keyCode==40) dir = 2;
		if(e.keyCode>=37 && e.keyCode<=40){
			moveNumbers();
			makeNumber();
			drawTable();
			inputScore();
		}
	}
	
	function inputScore(){
		var scoreDom = document.getElementById("curScore");
		scoreDom.innerHTML=score;
	}
	
	function makeNumber(){
		while(true){
			
			var checkEmpty = false;
			
			for(var i=0;i<rowSize;i++){
				for(var j=0;j<colSize;j++){
					if(map[i][j]==0) checkEmpty = true;
				}
			}
			if(checkEmpty==false) break;
			var r = Math.floor(Math.random()*4);
			var c = Math.floor(Math.random()*4);
			var temp = Math.floor(Math.random()*2);
			temp = temp==0 ? 2 : 4;
			if(map[r][c]==0){
				map[r][c] = temp;
				break;
			}
		}
	}
	
	function movableCheck(){
		var movable = false;
		
		for(var d=0;d<4;d++){
			for(var i=0;i<rowSize;i++){
				for(var j=0;j<colSize;j++){
					if(map[i][j]>0){
						var r = i;
						var c = j;
						for(var k=0;k<rowSize;k++){
							var nr = r+dr[d];
							var nc = c+dc[d];
							if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize) break;
							if(map[nr][nc]==0){
								movable = true;
								break;
							}
							else if(map[nr][nc]>0){
								if(map[nr][nc]!=map[r][c]) break;
								else{
									movable = true;
									break;
								}
							}
						}
					}
				}
			}
		}
		console.log(movable);
		
		return movable;
	}
	
	function moveNumbers(){
		var moveExist = false;
		
		moveExist = movableCheck();
		if(moveExist==true){
			if(dir==0){
				for(var i=0;i<rowSize;i++){
					for(var j=0;j<colSize;j++){
						if(map[i][j]>0){
							var r = i;
							var c = j;
							for(var k=0;k<rowSize;k++){
								var nr = r+dr[dir];
								var nc = c+dc[dir];
								if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize) break;
								if(map[nr][nc]==0){
									map[nr][nc] = map[r][c];
									map[r][c] = 0;
									r = nr;
									c = nc;
								}
								else if(map[nr][nc]>0){
									if(map[nr][nc]!=map[r][c]) break;
									else{
										map[nr][nc]=map[nr][nc]+map[r][c];
										score+=map[nr][nc];
										map[r][c] = 0;
										break;
									}
								}
							}
						}
					}
				}
			}
			
			if(dir==1){
				for(var j=colSize-1;j>=0;j--){
					for(var i=0;i<rowSize;i++){
						if(map[i][j]>0){
							var r = i;
							var c = j;
							for(var k=0;k<rowSize;k++){
								var nr = r+dr[dir];
								var nc = c+dc[dir];
								if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize) break;
								if(map[nr][nc]==0){
									map[nr][nc] = map[r][c];
									map[r][c] = 0;
									r = nr;
									c = nc;
								}
								else if(map[nr][nc]>0){
									if(map[nr][nc]!=map[r][c]) break;
									else{
										map[nr][nc]=map[nr][nc]+map[r][c];
										score+=map[nr][nc];
										map[r][c] = 0;
										break;
									}
								}
							}
						}
					}
				}
			}
			
			if(dir==2){
				for(var i=rowSize-1;i>=0;i--){
					for(var j=0;j<colSize;j++){
						if(map[i][j]>0){
							var r = i;
							var c = j;
							for(var k=0;k<rowSize;k++){
								var nr = r+dr[dir];
								var nc = c+dc[dir];
								if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize) break;
								if(map[nr][nc]==0){
									map[nr][nc] = map[r][c];
									map[r][c] = 0;
									r = nr;
									c = nc;
								}
								else if(map[nr][nc]>0){
									if(map[nr][nc]!=map[r][c]) break;
									else{
										map[nr][nc]=map[nr][nc]+map[r][c];
										score+=map[nr][nc];
										map[r][c] = 0;
										break;
									}
								}
							}
						}
					}
				}
			}
			
			if(dir==3){
				for(var j=0;j<colSize;j++){
					for(var i=0;i<rowSize;i++){
						if(map[i][j]>0){
							var r = i;
							var c = j;
							for(var k=0;k<rowSize;k++){
								var nr = r+dr[dir];
								var nc = c+dc[dir];
								if(nr<0 || nr>=rowSize || nc<0 || nc>=colSize) break;
								if(map[nr][nc]==0){
									map[nr][nc] = map[r][c];
									map[r][c] = 0;
									r = nr;
									c = nc;
								}
								else if(map[nr][nc]>0){
									if(map[nr][nc]!=map[r][c]) break;
									else{
										map[nr][nc]=map[nr][nc]+map[r][c];
										score+=map[nr][nc];
										map[r][c] = 0;
										break;
									}
								}
							}
						}
					}
				}
			}
		}
		
		if(moveExist==false){
			document.body.removeEventListener('keydown',keypress);
			var gamerName = prompt('당신의 이름을 입력하세요!\n점수 : '+score);
			if(gamerName!=null && gamerName!=''){
				insertScore(gamerName,score);
			}
			return;
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
		request.open('GET','/game/insertScore?kind=2048&name='+name+'&score='+score,true);
		request.send();
	}
	
</script>
<div>
<h2>2048 game!</h2>
<table id="2048_table"></table>
<br>
<div id="scoreBoard">Score : <span id="curScore"></span></div>
<button id="start-btn" onclick="startGame();">시작하기</button>
<button id="reset-btn" onclick="init_game();">다시하기</button>
<button id="rankingBoard" onclick="location.href='/game/rankingBoard?kind=${gameKind}'">점수보기</button>
</div>
</body>
</html>