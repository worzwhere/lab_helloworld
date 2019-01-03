read -p "What the word do you want to count? : " word

#cut -f 1 ls.txt | grep -i $word | wc -l

cat ls.txt | grep -i $word | echo "The wording count of " $word " is :" $(wc -l)