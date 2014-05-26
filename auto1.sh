rail(){
	delay=30
		c=0
		while true;
	do
		b=$(pgrep -f rails)   
			echo $b
			echo [ !$b ]
			if [ $b ]
				then
					echo $b
					((c=c-1))
			else
				date +'%m/%d/%Y %r' >> ../rails.txt
				zsh --login
				rails s -d
				((c=c+1))
				echo $c >> ../try.txt
			fi
			if [ !$c ]
				then
					((delay=c*!30))
			else
				delay=60
			fi
			sleep $delay
	done
}
rail &
