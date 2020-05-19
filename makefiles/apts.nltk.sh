# TODO seperate note and apt creation
for ch in $(ruby -e "puts ('a'..'k').to_a.zip(('01'..'11').to_a).inspect" | jq -cr .[]); do
  letter=`echo $ch | jq -r .[0]`
  num=`echo $ch | jq -r .[1]`
  DURATION=`cat tmp/xa$letter | tail -n 1 | jq -rR 'split("-") | max'`
  EVENT_TITLE=`cat tmp/xa$letter | head -n 1`
  FINISH_TIME=`date -v '+'$DURATION'H' +%H:%M`
  NOTE_ID=`uuidgen | sed -e 's/-//g'`
  FILE=nltk/book/ch$num.txt
  lynx -dump https://www.nltk.org/book/ch$num.html > $FILE
  line=`cat $FILE | grep -n Exercises | jq -rR 'split(":")[0]'`
  split -l $line $FILE
  cat xaa > $FILE
  NOTE_ID=`cat xab | shasum`
  touch tmp/notes/$NOTE_ID
  NOTE=`ls -tr tmp/notes/* | tail -n 1`
  cat xab > $NOTE
  echo "$BEGIN_DATE @ $BEGIN_TIME -> $FINISH_DATE @ $FINISH_TIME >`basename $NOTE ` | $EVENT_TITLE"
done
