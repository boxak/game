//큐 생성자 함수
function Queue(){
	this.dataStore = [];
	this.enqueue = enqueue;
	this.dequeue = dequeue;
	this.front = front;
	this.back = back;
	this.toString = toString;
	this.empty = empty;
	this.size = size;
}

//Enqueue, 큐의 끝부분에 요소를 추가
function enqueue(element){
	this.dataStore.push(element);
}

//dequeue, 큐의 앞부분에서 요소를 삭제
function dequeue(){
	return this.dataStore.shift();
}

//front, 큐의 앞부분에 저장된 요소 확인
function front(){
	return this.dataStore[0];
}

//back, 큐의 끝부분에 저장된 요소 확인
function back(){
	return this.dataStore[this.dataStore.length-1];
}

//toString, 큐의 모든 요소를 출력
function toString(){
	var retStr = "";
	for(var i=0;i<this.dataStore.length;i++){
		retStr+=this.dataStore[i]+"\n";
	}
	return retStr;
}

//empty, 큐가 비어있는지 확인
function empty(){
	if(this.dataStore.length==0){
		return true;
	}
	else return false;
}

function size(){
	return this.dataStore.length;
}