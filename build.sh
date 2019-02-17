rm log.txt
touch log.txt
/Library/TeX/texbin/pdflatex -interaction=nonstopmode uwthesis >> log.txt
/Library/TeX/texbin/bibtex uwthesis >> log.txt
/Library/TeX/texbin/pdflatex -interaction=nonstopmode uwthesis >> log.txt
/Library/TeX/texbin/pdflatex -interaction=nonstopmode uwthesis >> log.txt
rm uwthesis.aux
rm uwthesis.bbl
rm uwthesis.blg
rm uwthesis.log
rm uwthesis.out
rm uwthesis.toc
open -a Preview.app uwthesis.pdf
