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
	 ::sts == WAITING -> if
	       ::d2t_b ? start, end -> sts = PICKUP;
	       fi;
	 ::sts == PICKUP -> if
	       ::pos == start -> sts = GETTING_ON;
	       ::else -> if
	       	      ::pos == POS_A -> pos = POS_1;
		      ::pos == POS_1 -> pos = POS_B;
		      ::pos == POS_B -> pos = POS_2;
		      ::pos == POS_2 -> pos = POS_C;
		      ::pos == POS_C -> pos = POS_3;
		      ::pos == POS_3 -> pos = POS_D;
		      ::pos == POS_D -> pos = POS_E;
		      ::pos == POS_E -> pos = POS_A;
		      fi;
		fi;
	 ::sts == GETTING_ON -> sts = RENT;
	 ::sts == RENT -> if
	       ::pos == end -> sts = GETTING_ON;
	       ::else -> if
	       	      ::pos == POS_A -> pos = POS_1;
		      ::pos == POS_1 -> pos = POS_B;
		      ::pos == POS_B -> pos = POS_2;
		      ::pos == POS_2 -> pos = POS_C;
		      ::pos == POS_C -> pos = POS_3;
		      ::pos == POS_3 -> pos = POS_D;
		      ::pos == POS_D -> pos = POS_E;
		      ::pos == POS_E -> pos = POS_A;
		      fi;
		fi;
	 ::sts == GETTING_OFF -> sts = FORWARDING;
	 ::sts == FORWARDING -> if
	       ::pos == POS_A -> sts = WAITING;
	       ::else -> if
	       	      ::pos == POS_A -> pos = POS_1;
		      ::pos == POS_1 -> pos = POS_B;
		      ::pos == POS_B -> pos = POS_2;
		      ::pos == POS_2 -> pos = POS_C;
		      ::pos == POS_C -> pos = POS_3;
		      ::pos == POS_3 -> pos = POS_D;
		      ::pos == POS_D -> pos = POS_E;
		      ::pos == POS_E -> pos = POS_A;
		      fi;
		fi;
	 od;
}

/** タクシー B **/
proctype taxi_b() {
	 mtype sts = WAITING;
	 mtype pos = POS_A_;
	 mtype start = POS_NONE_;
	 mtype end = POS_NONE_;
	 
	 do
	 ::sts == WAITING -> if
	       ::d2t_b ? start, end -> sts = PICKUP;
	       fi;
	 ::sts == PICKUP -> if
	       ::pos == start -> sts = GETTING_ON;
	       ::else -> if
	       	      ::pos == POS_A_ -> pos = POS_1_;
		      ::pos == POS_1_ -> pos = POS_B_;
		      ::pos == POS_B_ -> pos = POS_2_;
		      ::pos == POS_2_ -> pos = POS_C_;
		      ::pos == POS_C_ -> pos = POS_3_;
		      ::pos == POS_3_ -> pos = POS_D_;
		      ::pos == POS_D_ -> pos = POS_E_;
		      ::pos == POS_E_ -> pos = POS_A_;
		      fi;
		fi;
	 ::sts == GETTING_ON -> sts = RENT;
	 ::sts == RENT -> if
	       ::pos == end -> sts = GETTING_ON;
	       ::else -> if
	       	      ::pos == POS_A_ -> pos = POS_1_;
		      ::pos == POS_1_ -> pos = POS_B_;
		      ::pos == POS_B_ -> pos = POS_2_;
		      ::pos == POS_2_ -> pos = POS_C_;
		      ::pos == POS_C_ -> pos = POS_3_;
		      ::pos == POS_3_ -> pos = POS_D_;
		      ::pos == POS_D_ -> pos = POS_E_;
		      ::pos == POS_E_ -> pos = POS_A_;
		      fi;
		fi;
	 ::sts == GETTING_OFF -> sts = FORWARDING;
	 ::sts == FORWARDING -> if
	       ::pos == POS_A_ -> sts = WAITING;
	       ::else -> if
	       	      ::pos == POS_A_ -> pos = POS_1_;
		      ::pos == POS_1_ -> pos = POS_B_;
		      ::pos == POS_B_ -> pos = POS_2_;
		      ::pos == POS_2_ -> pos = POS_C_;
		      ::pos == POS_C_ -> pos = POS_3_;
		      ::pos == POS_3_ -> pos = POS_D_;
		      ::pos == POS_D_ -> pos = POS_E_;
		      ::pos == POS_E_ -> pos = POS_A_;
		      fi;
		fi;
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
	       ::d2t_a ! POS_1, POS_2;
	       ::d2t_a ! POS_1, POS_3;
	       ::d2t_a ! POS_2, POS_3;
	       ::d2t_a ! POS_2, POS_1;
	       ::d2t_a ! POS_3, POS_1;
	       ::d2t_a ! POS_3, POS_2;
	       ::timeout -> skip;
	       fi;
	       if
	       ::skip -> sts = SLEEP;
	       ::skip -> sts = TAXI_A;
	       ::skip -> sts = TAXI_B;
	       fi;
	 ::sts == TAXI_B -> if
	       ::d2t_b ! POS_1_, POS_2_;
	       ::d2t_b ! POS_1_, POS_3_;
	       ::d2t_b ! POS_2_, POS_3_;
	       ::d2t_b ! POS_2_, POS_1_;
	       ::d2t_b ! POS_3_, POS_1_;
	       ::d2t_b ! POS_3_, POS_2_;
	       ::timeout -> skip;
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
/*     run passenger_a();
     run passenger_b(); */
     run director();
}
