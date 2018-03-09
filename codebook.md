## The codebook for the tidy data set

# Genera info
You can read in the tidy data set tidy_data.txt into R via read.table("tidy.txt").
The so created object is a table with dimensions 181 x 81. The first column is the subject, i.e. the person who is using the device.
The second column shows the activity. The residual columns show the accelerometer and gyroscope data. A list of these features can be found in the feature list.

# How the data are transformed by the script:

1) The data are read in and simplified for processing
2) We define the wanted features, concentrating on standard deviations and means.
3) Only the data relevant for the standard deviations and means are read in to safe memory.
4) Perform steps 1-3 for the test and the training set.
5) Transform activity names into factors.
6) Reshape the data so that subjects and activities become a variables of two independent columns.
7) Finally safe the data.

