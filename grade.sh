CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

pwd
if ! [ -f student-submission/ListExamples.java ]
then
    echo "Missing neccessary files"
    exit
else 
    cp student-submission/ListExamples.java grading-area/
    cp TestListExamples.java grading-area/
fi 

echo "continue"

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area
pwd

javac -cp $CPATH *.java
if [ $? -ne 0 ] #space after and before brackets
then 
    echo "Compilation Error"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

if [[ `grep 'OK' junit-output.txt` ]] #`` tells bash it's a command (grep)
then 
    echo "All tests passed"
    exit 0
fi
#no space after variable and after =
lastline=$(cat junit-output.txt | tail -n 2 | head -n 1)
tests=$(echo $lastline | awk -F'[, ]' '{print $3}')
failures=$(echo $lastline | awk -F'[, ]' '{print $6}')
successes=$((tests - failures))

echo "Your score is $successes/$tests"



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
