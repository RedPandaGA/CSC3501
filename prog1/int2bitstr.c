int int2bitstr(int I, char *str) {
	int counter = 0;
	str[32]='\0';
	for(int position = 0; position < 32; position++){
		unsigned int bit = (I >> position) & 1;
		if(bit == 1){
			counter++;
			str[31-position] = '1';
		} else {
			str[31-position] = '0';
		}
	}
	return counter;
}

int get_exp_value(float f) {
	unsigned f2u(float f);
	unsigned int ui = f2u(f);
	return 0;
}
