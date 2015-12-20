/*

Wiring definitions of 5 rotors.
The last character represents the turnover position of the rotor.

*/



char rotor_i[]   = "EKMFLGDQVZNTOWYHXUSPAIBRCJQ"; //I
char rotor_ii[]  = "AJDKSIRUXBLHWTMCQGZNPYFVOEE"; //II
char rotor_iii[] = "BDFHJLCPRTXVZNYEIWGAKMUSQOV"; //III
char rotor_iv[]  = "ESOVPZJAYQUIRHXLNFTGKDCMWBJ"; //IV
char rotor_v[]   = "VZBRGITYUPSDNHLXAWMJQOFECKZ"; //V

char reflector_a[] = "EJMZALYXVBWFCRQUONTSPIKHGD"; //Wide A
char reflector_b[] = "YRUHQSLDPXNGOKMIEBFZCWVJAT"; //Wide B
char reflector_c[] = "FVPJIAOYEDRZXWGCTKUQSBNMHL"; //Wide C

/* mod26 operation models the rotating of a rotor */

char mod26(char a)
{
  return (a+26)%26;
}

/*

Enigma data structure

Holds the current state of the machine, and some pre-calculated lookup tables.

*/

typedef struct {
    char forward_reflector[26];
    char forward_l[26];
    char forward_r[26];
    char forward_m[26];
    char reverse_l[26];
    char reverse_r[26];
    char reverse_m[26];
    char ring_setting_l;
    char ring_setting_m;
    char ring_setting_r;
    char turnover_m;
    char turnover_r;
    char l;
    char m;
    char r;
} enigma;

/* initialise the enigma machine */

void enigma_init(
        enigma * self,

        char * rotor_l,
        char * rotor_m,
        char * rotor_r,
        char * reflector,

        char ring_setting_l,
        char ring_setting_m,
        char ring_setting_r,

        char rotor_position_l,
        char rotor_position_m,
        char rotor_position_r
){

   char l, m, r, ref, i;

   self->l = rotor_position_l - 'A';
   self->m = rotor_position_m - 'A';
   self->r = rotor_position_r - 'A';

   self->turnover_m = rotor_m[26] - 'A';
   self->turnover_r = rotor_r[26] - 'A';

   self->ring_setting_l = ring_setting_l - 'A';
   self->ring_setting_m = ring_setting_m - 'A';
   self->ring_setting_r = ring_setting_r - 'A';

   /*
   create forward and reverse lookup tables, letters A-Z are
   represented by the numbers 0 to 25 to allow modulo arithmetic
   */
   for(i=0; i<26; i++){

       l = rotor_l[i]-'A';
       m = rotor_m[i]-'A';
       r = rotor_r[i]-'A';
       ref = reflector[i]-'A';

       self->forward_l[mod26(i)] = l;
       self->forward_m[mod26(i)] = m;
       self->forward_r[mod26(i)] = r;
       self->forward_reflector[i] = ref;

       self->reverse_l[l] = mod26(i);
       self->reverse_m[m] = mod26(i);
       self->reverse_r[r] = mod26(i);

   }

}

/* simulate a key press on the enigma machine */

char enigma_encrypt(enigma * self, char letter)
{

    char a, b, c, temp;

    // Step right rotor on every iteration
    if(self->m == self->turnover_m) self->l = mod26(self->l+1);
    if(self->r == self->turnover_r) self->m = mod26(self->m+1);
    self->r = mod26(self->r + 1);

    // Pass through rotors
    temp = letter - 'A';
    temp = mod26(self->forward_r[mod26(temp + self->r - self->ring_setting_r)] - self->r + self->ring_setting_r);
    temp = mod26(self->forward_m[mod26(temp + self->m - self->ring_setting_m)] - self->m + self->ring_setting_m);
    temp = mod26(self->forward_l[mod26(temp + self->l - self->ring_setting_l)] - self->l + self->ring_setting_l);

    // Pass through reflector
    temp = self->forward_reflector[temp];

    // Inverse rotor pass
    temp = mod26(self->reverse_l[mod26(temp + self->l - self->ring_setting_l)] - self->l + self->ring_setting_l);
    temp = mod26(self->reverse_m[mod26(temp + self->m - self->ring_setting_m)] - self->m + self->ring_setting_m);
    temp = mod26(self->reverse_r[mod26(temp + self->r - self->ring_setting_r)] - self->r + self->ring_setting_r);

    return temp + 'A';
}
