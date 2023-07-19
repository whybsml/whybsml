FILES=Introduction.mlw bsml.mlw sequential.mlw stdlib.mlw skeletons.mlw mps.mlw
TITLE=WhyBSML ${shell cat VERSION}
CODE=bsml wrapper extraction application

doc:
	mkdir -p html
	why3 doc --title "$(TITLE)" -L .  $(FILES) -o html
	why3 session html . -L .
	-pandoc --from gfm --to html --standalone -c html/style.css README.md --output html/README.html

replay:
	why3 replay -L . .

wc:
	why3 wc --factor $(FILES)

clean:
	-rm -Rf html
	-rm why3session.html
	-rm -f *.bak
	-rm -f extraction/*.ml
	-rm -f extraction/*.bak
	for d in $(CODE); do make -C $$d clean; done

extract:
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Int  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.List  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Algebra  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv --recursive --modular -L . sequential.Pair  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . stdlib.Base  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . stdlib.Comm  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . skeletons.Skeletons  -o extraction
	why3 extract -D ocaml64 -D drivers/option.drv -D drivers/bsml.drv --recursive --modular -L . mps.MPS  -o extraction


compile: extract
	for d in $(CODE); do make -C $$d; done