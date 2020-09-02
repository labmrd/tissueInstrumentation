# tissue_Instrumentation (in progress, yet functional)
UMN-UW tissue instrumentation code repository

*****

To use code:

0 - Open forcePlotter4.pde code with Processing (32 bit)

1 - Make sure force tongs device is plugged into computer

2 - Look at plot to make sure computer is receiving input data from force tongs

3 - Type desired file name; press enter keyboard or "o" enter button on GUI screen (date and time stamps added; fail-safe file name in place)

4 - Click green "Start" button to begin recording force data to a text file (data recording indicator circle becomes green while recording)

5 - Click red "Stop" button to stop recording data (data recording indicator circle becomes red when recording stops)

6 - Can type new file name and record new data file if desired (repeat steps 3 - 6)

7 - Stop running code from Processing window when done

*****

Sarah's notes:

This is Sarah's first edit to the readme file

Reminder: edit Processing code directly (can edit main branch directly) in GitHub folder on local machine, then save, then commit in github app, then push changes from local machine to everyone on github repo

*Can code save multiple sets of data if user types a new file name in-between sets? On a basic level, yes, it can. Might change with future addtions.

Create fail-safe measures for:

1 - device not plugged in

2 - user didn't enter new file name (add date+time stamp to end of file name; add date+time stamp whether or not user entered file name (time when start button pressed?)

3 - user enters new file name partway through? ask user if want to start new file/dataset or continue old dataset and old name?

4 - anything else?
