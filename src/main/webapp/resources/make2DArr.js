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