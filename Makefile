
step1.rda:  step1.R  data1.csv
	    echo "yes"

step2.rda:  step2_bad.R  step1.rda
	    echo "step2"

step3.rda:  step3.R  step2.rda step1.rda
	    echo "step 3"

