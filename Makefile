FILES=Introduction.mlw bsml.mlw sequential.mlw stdlib.mlw skeletons.mlw mps.mlw
TITLE=WhyBSML ${shell cat VERSION}
CODE=bsml wrapper extraction application/cli application/mps application/average application/count

config: strategy.conf 

strategy.conf: config/strategy.conf.generic
	config/conf_strategy.sh

doc:
	mkdir -p html
	why3 doc --title "$(TITLE)" -L .  $(FILES) -o html
	why3 session html . -L .
	-pandoc --from gfm --to html --standalone -c html/style.css README.md --output html/README.html

bench:
	why3 bench -L . replay

info: bench
	why3 session info --session-stats --provers-stats replay

ide:
	why3 ide --extra-config strategy.conf -L . session *.mlw &

wc:
	why3 wc --factor $(FILES)

clean_config:
	-rm -f strategy.conf

clean_replay: 
	-rm -f replay/*.bak replay/*.gz
	
clean_session:
	-rm -Rf session
	-rm -f why3session.html

clean_doc:
	-rm -Rf html

clean_extraction:
	-rm -f *.bak
	-rm -f extraction/*.ml
	-rm -f extraction/*.bak
	for d in $(CODE); do make -C $$d clean; done

cleanup: clean_extraction clean_doc clean_session clean_config

extract:
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Int  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.List  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Algebra  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Pair  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . stdlib.Base  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . stdlib.Comm  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . skeletons.Skeletons  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . mps.MPS  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . average.Average  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . count.Count  -o extraction

compile: extract
	for d in $(CODE); do make -C $$d; done