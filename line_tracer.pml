/**
 * Verification model for line tracer robot
 **/

mtype = { WAITING, PICKUP, GETTING_ON, RENT, GETTING_OFF, FORWARDING };
mtype = { POS_A,  POS_B,  POS_C,  POS_D,  POS_E,  POS_1,  POS_2,  POS_3  };
mtype = { POS_A_, POS_B_, POS_C_, POS_D_, POS_E_, POS_1_, POS_2_, POS_3_ };
mtype = { OBSTACLE, NONE };


/** タクシー A **/
proctype taxi_a() {
	 mtype sts = WAITING;
	 mtype pos = POS_A;
	 
	 do
	 ::
	 od;
}

/** タクシー B **/
proctype taxi_b() {
	 mtype sts = WAITING;
	 mtype pos = POS_A_;
}

/** 乗客 A **/
proctype passenger_a() {
}

/** 乗客 B **/
proctype passenger_b() {
}

/** 指令所 **/
proctype director() {
}

/** main **/
init {
     run taxi_a();
     run taxi_b();
     run passenger_a();
     run passenger_b();
     run director();
}
