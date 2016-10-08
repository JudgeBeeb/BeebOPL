@echo off

REM change to the master project directory (use the /D switch to change drive as well)
CD /D Z:\Documents\BeebOPL\

REM need to state the full path to BeebAsm
REM but only the sub-path to those files stored under the master project directory

REM -i <filename>			source file
REM (in the absence of any switches specifying disc image filenames, SAVE commands in the source code will write out object files directly to the current directory)

REM -o <filename>		 	output file
REM (if this is specified, then the SAVE command can be used without supplying a filename, and this one will be used instead)

REM -do <filename> 			target disc image	
REM (specifies the name of a new disc image to be created; all object code files will be saved to within this disc image_

REM -boot <DFS filename>
REM (if specifed, BeebAsm will create a !Boot file on the new disc image, containing the command '*RUN <DFS filename>')
REM	(the new disc image will already be set to *OPT 4,3 (*EXEC !Boot)

REM -opt <value>
REM (if specified, the *OPT 4 disc option of the generated disc image will be set to the specified value)

REM -di <filename>			template disc image
REM (if specified, BeebAsm will use this disc image as a template for the new disc image, rather than creating a new blank one)
REM (his is useful if you have a BASIC loader which you want to run before your executable; note this cannot be the same as the -do filename!)

REM -v						verbose output

REM USE "|| pause" to stop the CMD windows closing if there is an error

"C:\Program Files (x86)\beebasm1.08\beebasm.exe" -i "src\jukplay.s.6502" -di "src\jukeplay_template.ssd" -do "\\Mac\Home\Desktop\jukebox.ssd" || pause

REM include the following lines if you want to see the screen come what may

REM @echo on
REM pause