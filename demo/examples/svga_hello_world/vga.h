typedef struct {
	int out;
	int row;
	int col;
} vga;

void vga_init(vga *self, int out){
	self->out = out;
	self->col = 0;
	self->row = 0;
}

void vga_set_cursor(vga * self, int row, int col){
	self->row = row;
	self->col = col;
}

void vga_put_char(vga * self, int c){
	unsigned address;
	address = self->row * 100 + self->col;
	address <<= 8;
	fputc(address | c, self->out);
	if(self->col == 74) {
		self->col = 0;
		self->row++;
	} else {
		self->col++;
	}
}

void vga_clear(vga * self){
	unsigned i;
	self->col = 0;
	self->row = 0;
	for(i=0; i<7500; i++){
		fputc(i<<8, self->out);
	}
}
