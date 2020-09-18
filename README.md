# tissueInstrumentation (in progress, yet functional)
UMN-UW tissue instrumentation code repository

*****

Have Processing (32 bit) installed on your machine

Have Grafica library installed as well:

Go to "Sketch" tab in Processing window; then scroll-over "Import Library..." and select "Add Library..."; in the new libraries window search for "grafica"; click on the line that says "grafica: create simple and configurable 2D plots..." and then click "Install down in the right-hand corner; now you can run the code

***

To use code:

0 - Open forcePlotter.pde code with Processing (32 bit) - NOTE: forcePlotter4.pde is old code

1 - Make sure force tongs device is plugged into computer

2 - Look at plot to make sure computer is receiving input data from force tongs

3 - Type desired file name; press enter keyboard or "o" enter button on GUI screen (date and time stamps added; fail-safe file name in place); file saves with a .csv extension

4 - Click green "Start" button to begin recording force data to a text file (data recording indicator circle lights red while recording)

5 - Click red "Stop" button to stop recording data (data recording indicator circle becomes gray when recording stops)

6 - Can type new file name and record new data file if desired (repeat steps 3 - 6)

7 - Stop running code from Processing window when done

*****

Sarah's notes:

This is Sarah's first edit to the readme file

Reminder: edit Processing code directly (can edit main branch directly) in GitHub folder on local machine, then save, then commit in github app, then push changes from local machine to everyone on github repo

*Can code save multiple sets of data if user types a new file name in-between sets? On a basic level, yes, it can. Might change with future addtions.

Create fail-safe measures for:

1 - device not plugged in

2 - user enters new file name partway through?

3 - calibration program running instead of read?

4 - anything else?
