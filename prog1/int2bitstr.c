int int2bitstr(int I, char *str) {
	int counter = 0; //creates and initialzes counter to be returned.
	str[32]='\0'; //adds the null character at the end of the string
	for(int position = 0; position < 32; position++){
		unsigned int bit = (I >> position) & 1; //retrieve the bit at position by shifting I and &.
		if(bit == 1){
			counter++;
			str[31-position] = '1'; //assign 1 to relevant str position
		} else {
			str[31-position] = '0'; //assign 0 to relevant str position
		}
	}
	return counter;
}

int get_exp_value(float f) {
	int ret = 0; //variable to be returned
  	union{ //connect a float to a bitfield so we can get the exponent seperated.
		float f;
		struct { //Make a bit field of the float value
            unsigned int mantissa: 23; //first 23 bits are the mantissa
            unsigned int exponent: 8; //next 8 are exponent
			unsigned int sign: 1; //final is the sign
        } s;
	} u;
	u.f = f; //assign f so that the bit field matches the bit value of f
	if((int)u.s.exponent == 0){ //check if the expoenent is 0 and set ret to -126.
		ret = -126;
	} else if ((int)u.s.exponent == 256){//Check if it is infinity 
		ret = -128;
	} else {
		ret = ((int)u.s.exponent - 127); //else set ret to the exponent value subtracting the bias.
	}
	return ret; //return
}