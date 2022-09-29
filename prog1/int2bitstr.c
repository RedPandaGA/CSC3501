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
	int ret = 0;
  	union{
		float f;
		struct {
            unsigned int mantissa: 23;
            unsigned int exponent: 8;
			unsigned int sign: 1;
        } s;
	} u;
	u.f = f;
	if((int)u.s.exponent == 0){
		ret = -126;
	} else {
		ret = ((int)u.s.exponent - 127);
	}
	return ret;
}