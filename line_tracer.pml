/**
 * Verification model for line tracer robot
 **/

mtype = { WAITING, PICKUP, GETTING_ON, RENT, GETTING_OFF, FORWARDING };
mtype = { POS_A,  POS_B,  POS_C,  POS_D,  POS_E,  POS_1,  POS_2,  POS_3 , POS_NONE };
mtype = { POS_A_, POS_B_, POS_C_, POS_D_, POS_E_, POS_1_, POS_2_, POS_3_, POS_NONE_ };
mtype = { OBSTACLE, NONE };
mtype = { SLEEP, TAXI_A, TAXI_B };

chan d2t_a = [1] of { mtype, mtype };	/** channel for director -> taxi_a **/
chan d2t_b = [1] of { mtype, mtype };	/** channel for director -> taxi_b **/


/** タクシー A **/
proctype taxi_a() {
	 mtype sts = WAITING;
	 mtype pos = POS_A;
	 mtype start = POS_NONE;
	 mtype end = POS_NONE;
	 
	 do
	 ::sts == WAITING -> skip;
	 ::sts == PICKUP -> skip;
	 ::sts == GETTING_ON -> skip;
	 ::sts == RENT -> skip;
	 ::sts == GETTING_OFF -> skip;
	 ::sts == FORWARDING -> skip;
	 od;
}

/** タクシー B **/
proctype taxi_b() {
	 mtype sts = WAITING;
	 mtype pos = POS_A_;
	 mtype start = POS_NONE_;
	 mtype end = POS_NONE_;
	 
	 do
	 ::sts == WAITING -> skip;
	 ::sts == PICKUP -> skip;
	 ::sts == GETTING_ON -> skip;
	 ::sts == RENT -> skip;
	 ::sts == GETTING_OFF -> skip;
	 ::sts == FORWARDING -> skip;
	 od;
}

/** 乗客 A **/
proctype passenger_a() {
	 mtype sts = WAITING;

	 do
	 ::sts == WAITING -> skip;
	 ::sts == PICKUP -> skip;
	 ::sts == GETTING_ON -> skip;
	 ::sts == RENT -> skip;
	 ::sts == GETTING_OFF -> skip;
	 ::sts == FORWARDING -> skip;
	 od;
}

/** 乗客 B **/
proctype passenger_b() {
	 mtype sts = WAITING;

	 do
	 ::sts == WAITING -> skip;
	 ::sts == PICKUP -> skip;
	 ::sts == GETTING_ON -> skip;
	 ::sts == RENT -> skip;
	 ::sts == GETTING_OFF -> skip;
	 ::sts == FORWARDING -> skip;
	 od;
}

/** 指令所 **/
proctype director() {
	 mtype sts = SLEEP;

	 do
	 ::sts == SLEEP -> if
	       ::skip -> sts = SLEEP;
	       ::skip -> sts = TAXI_A;
	       ::skip -> sts = TAXI_B;
	       fi;
	 ::sts == TAXI_A -> if
	       ::skip -> d2t_a ! POS_1, POS_2;
	       ::skip -> d2t_a ! POS_1, POS_3;
	       ::skip -> d2t_a ! POS_2, POS_3;
	       ::skip -> d2t_a ! POS_2, POS_1;
	       ::skip -> d2t_a ! POS_3, POS_1;
	       ::skip -> d2t_a ! POS_3, POS_2;
	       fi;
	       if
	       ::skip -> sts = SLEEP;
	       ::skip -> sts = TAXI_A;
	       ::skip -> sts = TAXI_B;
	       fi;
	 ::sts == TAXI_B -> if
	       ::skip -> d2t_b ! POS_1, POS_2;
	       ::skip -> d2t_b ! POS_1, POS_3;
	       ::skip -> d2t_b ! POS_2, POS_3;
	       ::skip -> d2t_b ! POS_2, POS_1;
	       ::skip -> d2t_b ! POS_3, POS_1;
	       ::skip -> d2t_b ! POS_3, POS_2;
	       fi;
	       if
	       ::skip -> sts = SLEEP;
	       ::skip -> sts = TAXI_A;
	       ::skip -> sts = TAXI_B;
	       fi;
	 od;
}

/** main **/
init {
     run taxi_a();
     run taxi_b();
     run passenger_a();
     run passenger_b();
     run director();
}
