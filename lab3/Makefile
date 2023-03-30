TOP     = top
SEED    = 1
VCOMP   = vlogan -full64 -sverilog -timescale 1ps/1ps -l comp.log
COPTS   = -cm line+cond+fsm+tgl+branch
ELAB    = vcs -full64 $(COPTS) -debug_access+all -l elab.log -sim_res=1ps
RUN     = ./simv -l run.log -gui ntb_random_seed=$(SEED) $(COPTS) &
default : comp elab run
comp:
	$(VCOMP) -f file.f
	$(VCOMP) -f tb.f
elab:
	$(ELAB) -top $(TOP)
run:
	./$(RUN)
clean:
	\rm -rf *.log
	\rm -rf AN.DB
	\rm -rf *simv*
	\rm -rf DVEfiles
	\rm -rf csrc
	\rm -rf *vpd
	\rm -rf ucli.key
	\rm -rf vc_hdrs.h
	\rm -rf 64
all: clean comp elab run	
