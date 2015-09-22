# Getting and cleaning the data

### Read the files.
1. First we store the local address to variables.
2. Then we read the tables, giving the name to the columns of activity and subject to avoid any confusion later.
3. Then we bind the data. First the Test data, then the Train data, then the whole set together into a data set called allData.

### Getting the right variables, and the right names
1. We will get the name from the features text file.
2. First we load the file using the read.table method
3. Then we filter out all the values that are not mean or standard deviation.
4. We then store the variable index in a vector called subsetVector, and the variable names in a subsetNames vector.
5. From there, we can subset the allData data set using this subsetVector,
6. We will names the variables later.

### Naming the activities
1.  Using the activity labels text file, stored into a data frame called activityLabels,
2.  we can now map the values (plyr) to the activity numbers in the activity column of our main data set.

### Naming the column
1.  Finally, we clean the subsetNames vector by removing character that are inappropriate,
2.  we then names the columns, not forgetting to keep the activity and subject column name.

### *Optional*
### Writing a second data set
1.  To conclude the task, we summarise the data in another variable, data2, grouped by actitivy and subject.
2.  Writing it in a table for export.

