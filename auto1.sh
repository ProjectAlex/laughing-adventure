rail(){
	delay=30
		c=0
		while true;
	do
		b=$(pgrep -f rails)   
			echo $b
			if [ !$b ]
				then
					echo $b
					date +'%m/%d/%Y %r' >> ../rails.txt
					zsh --login
					rails s
					((c=c+1))
					echo $c >> ../try.txt
			else
				
					((c=c-1))
					fi
					if [ !$c ]
						then
							((delay=c*30))
					else
						delay=30
							fi
							sleep 30
							done
}
rail &
